var express = require("express");
var router = express.Router();
var url = require('url');
var db = require('../db');
var render = require("../models/loginCheck").renderUserAndCategory;

router.get('/', function(req, res, next){
  if (!req.session.user_id){
    req.session.nextPage = '/admin';
    res.redirect('/login');
    return;
  }



  var q = url.parse(req.url, true).query;
  var removeUser = q.remove_user;
  var removeItem = q.remove_item;
  var approveItem = q.approve_item;
  
  db.any(`SELECT admin_right FROM user_record WHERE user_id=`+ req.session.user_id)
  .then(isAdmin =>{
    console.log(isAdmin);
    if(!isAdmin[0].admin_right){
    res.redirect('/dashboard');
    return;
  }
  db.any(`SELECT * FROM item WHERE item_status = 'Pending'`)
  .then( data => db.any('SELECT * FROM category')
  .then (cats => {
    var items = data;
    data = {};
    data.items = items;

    data.items.forEach(item => {
      cats.forEach(cat =>{
        if (item.category_id == cat.category_id){
          item.item_category = cat.category_name;
        }
      });
    });



    db.any(`SELECT * FROM user_record`)
    .then (users => db.any(`SELECT * FROM item`)
    .then (items => {
      users.forEach(user =>{
        user.items= [];
        items.forEach(item => {
          if(  user.user_id == item.user_id){
            user.items.push(item);
          }
        });
      });

      var allData = {};
      allData.users = users;
      allData.items = data.items;
      console.log(allData);
      render(req, res, 'admin', 'ADMIN PAGE', 'admin', {data: allData, script: 'tabSwitcher'});
    }));

  }))});


});
module.exports = router;
