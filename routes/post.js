/*
* The purpose of this .js file is to allow registered users to post an item for sale after login.
* Unregistered users will be prompted to register on the website.
* Users will fill out a form and the data from there will be stored in the database
* under the user_id of the user logged in.
* The user is also required to upload a picture which is then cropped and resized using imagemagick.
*/

var express = require("express");
var router = express.Router();
var db = require('../db');
var hash = require('object-hash');

//formidable is used to read/parse incoming form from the web page.
var formidable = require('formidable');
//This npm helps to resize, crop and render image in thumbnails.
var im = require('node-imagemagick');
//Helps to move the file from one path to another.
var fs_extra = require('fs-extra');
//Hosting service, to host images of item.
var imgur = require('imgur');
//Used to render a page with associated handlebars file.
var render = require('../models/loginCheck').renderUserAndCategory;

var filename, thumbname;

//These variables are needed when callBack functions are called.
var fields, id;
var response, request;

/**
 * This function is responsible for cropping the image.
 * The image gets cropped with minimum dimension, as its width and height
 * @param  err      This throws an error if it fails to identify the image
 * @param  features Detects the features of image. Eg: Widht and Height
 * @return void
 */
var identifySizeCallback = function (err, features) {
  if (err) throw err;
  console.log("Cropping...")
  im.convert(['-background', 'white', '-gravity', 'center',
    './public/images/user_images/' + filename, '-resize', '200x200', '-extent', '200x200', './public/images/user_images/' + thumbname],
    resizeImageCallback)
}

/**
 * This function is responsible for uploading image on imgur hosting service.
 * It uploads the original file as well as thumbnail version of it.
 * It also populates the image database through pg-promise.
 *
 * @param  err throws error if resizing the cropped image failed
 * @return void
 */

var resizeImageCallback = function (err) {
  if (err) throw err;
  console.log('Resized');
  //Uploading of original file
  imgur.uploadFile('./public/images/user_images/' + filename)
    //returns a json file.
    .then((filejson) => {
      //Uploading of thumbnail version of file.
      imgur.uploadFile('./public/images/user_images/' + thumbname)
        //returns a json file of thumbnail version.
        .then(thumbjson => {
          console.log(filejson.data.link);
          console.log(thumbjson.data.link);
          console.log(fields.category)
          //Removes all the '/'' from incoming form.
          let title = fields.title.replace('&apos');
          let description = fields.description.replace('&apos');
          // Insert new item into database
          db.any(
            `INSERT INTO item(
            item_title,
            item_description,
            item_price,
            item_status,
            user_id,
            category_id,
            item_image,
            item_availability,
            item_image_thumbnail
          )
          VALUES
          (
            '` + title + `',
            '` + description + `',
            '` + fields.price + `',
            'Pending',
            ` + id + `,
            ` + fields.category + `,
            '` + filejson.data.link + `',
            true,
            '` + thumbjson.data.link + `'
          )
          RETURNING item_id`
          )
            // Query returns with data called 'myData'
            .then(function (myData) {
              response.redirect('./item/' + myData[0].item_id);
            })
            //If there is an error, it is catched here.
            .catch(function (err) {
              console.log(err.message);
              render(request, response, 'post', 'POST PAGE', 'post', {message: "Something went wrong. Try again."});
            });
        })
    })
    .catch(function (err) {
      console.error(err.message);
      render(request, response, 'post', 'POST PAGE', 'post', {message: "Something went wrong. Try again."});
    });
}

/**
 * This is the main function route, which parses the incoming form and then performs
 * the above mentioned fucntions and callBacks. It also moves the image file from original
 * file directory to a new directory.
 * @param req  it is a request to the http
 * @param res  it is a response to the http
 * @returns void
 */
router.post('/', function (req, res) {
  id = req.session.user_id;

  //response and request
  response = res;
  request = req;
  // Get incoming form
  var form = new formidable.IncomingForm();
  // Parse incoming form
  form.parse(req, function (err, field, files) {
    fields = field
    // Hash the time now for uncollidable filenames
    var name = hash.sha1(Date.now());
    // If the file is a jpeg...
    if (files.image_file.type == 'image/jpeg') {
      // Append the correct suffix
      filename = name + '.jpg';
      thumbname = name + '_thumb.jpg';
    }
    // If the file is a png...
    else if (files.image_file.type == 'image/png') {
      // Append the correct suffix
      filename = name + '.png';
      thumbname = name + '_thumb.png';
    }
    else {
      console.log("Not an image");
      render(request, response, 'post', 'POST PAGE', 'post', {message: "Not an image file."});
      return;
    }
    console.log(filename);
    // Get temp path of uploaded image
    var oldpath = files.image_file.path;
    // Specify new path for uploaded image
    var newpath = './public/images/user_images/' + filename;
    // Move and rename image file to public/images/
    fs_extra.move(oldpath, newpath, function (err) {
      if (err) throw err;
      // Read height and width
      im.identify(newpath, identifySizeCallback);
    });
  });
});
module.exports = router;
