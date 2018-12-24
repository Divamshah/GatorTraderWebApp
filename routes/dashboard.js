/*
* The purpose of this .js file is to direct a registered user to their
* personal dashboard where they can view the approved items they have
* posted for sale. The user can also check messages from other users
* who are interested in buying their product.
*/

var express = require("express");
var router = express.Router();
var url = require('url');
var db = require('../db');
var render = require("../models/loginCheck").renderUserAndCategory;
var formatDate = require('../models/loginCheck').formatDate;

/**
 * The route to dashboard.
 * @param req request to http
 * @param res response to http
 * @return void
 */

router.get('/', function(req, res) {
  if (!req.session.user_id) {
    req.session.nextPage = '/dashboard';
    res.redirect('/login');
    return;
  }

//Get user_id from cookies of the user logged in
//Then fetch their data from the database
  var q = url.parse(req.url, true).query;
  var remove = q.remove;
  var sorters = {}
  sorters.items = q.sort_item;
  sorters.messages = q.sort_message
  sorters.type = q.type;


  if (remove && remove.length != 0) {
    console.log("Removing "+remove);
    db.any(`DELETE FROM item WHERE user_id=`+req.session.user_id+` AND item_id=`+remove)
    .then( _ => {
      renderDashboard(req,res);
    })
    .catch( err => {
      console.log(err);
      render(req, res, 'dashboard', 'DASHBOARD PAGE','dashboard', {script: 'tabSwitcher', message: "Couldn't delete item"});
      return;
    });
  }
  else {
    renderDashboard(req,res,sorters);
  }


});
/*
* One of the purpose of this function is to add functionality to the
* sort by feature. Further, this will link a paticular item to the
* user that posted it by looking through the database.
* In the messages tab, the items are linked to userid of the user
* interested in buying the item.
*/

var renderDashboard = function(req, res, sorter) {

  var sortItems = 'ORDER BY item_status DESC';
  var sortMessages = '';

  if (sorter && sorter.items) {
    sortItems = ' ORDER BY '+sorter.items+' '+sorter.type;
  }
  if (sorter && sorter.messages) {
    sortMessages = ' ORDER BY '+sorter.messages+' '+sorter.type;
  }

  db.any(`SELECT * FROM item WHERE user_id =`+req.session.user_id + sortItems)
  .then( data => db.any(`SELECT * from category`)
  .then( cats => {

    var items = data;
    data = {};
    data.items = items;

    // Get items that the user has posted for sale
    data.items.forEach(item => {

      item.item_date = formatDate(item.item_date);

      cats.forEach(cat => {
        if (item.category_id == cat.category_id) {
          item.item_category = cat.category_name;
        }
      });
    });

    //Get messages sent to this user in messages tab
    if (data.items.length > 0) {
      var where = ' WHERE ';
      data.items.forEach(element => {
        where += 'item_id='+element.item_id+' OR ';
      });
      where = where.substr(0, where.length-4);
      db.any(`SELECT * FROM gator_message`+where+sortMessages)
      .then( messages => {
        // Get usernames associated with IDs
        where = ' WHERE ';
        var whereItem = ' WHERE ';
        messages.forEach(element => {
          where += 'user_id='+element.user_id+' OR ';
        });
        where = where.substr(0, where.length-4);
        db.any(`SELECT user_id, user_name FROM user_record`+where)
        .then( usernames => {
          // Map username with message
          messages.forEach( element => {
            element.message_date = formatDate(element.message_date).replace(/<br>/g, ' ');
            usernames.forEach( element2 => {
              if (element.user_id == element2.user_id)
                element.user_name = element2.user_name;
            });
            data.items.forEach( item => {
              if (item.item_id == element.item_id)
                element.item_title = item.item_title;
            });
          });
          data.messages = messages;

          render(req, res, 'dashboard', 'DASHBOARD PAGE','dashboard', {data: data, script: 'tabSwitcher'});
        })
      })
    }
    else {
      render(req, res, 'dashboard', 'DASHBOARD PAGE','dashboard', {data: data, script: 'tabSwitcher'});
    }
  }));
}

module.exports = router;
