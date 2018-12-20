/*
* The purpose of this .js file is to route to the About Us page.
* This page consists of links to individual developers on this project
* which then routes to their own about page.
* This function doesn't require a user to be logged in.
*/

var express = require('express');
var router = express.Router();
var render = require('../models/loginCheck').renderUserAndCategory;

router.get('/', function(req, res, next) {
  res.redirect('/home');
});

//about us page
router.get('/index', function(req, res, next) {
  render(req, res, 'about', 'ABOUT PAGE', 'about');
});

//For function post am item while on the index page
router.get('/post', function(req, res, next) {
  var user_id = req.session.user_id
  if (user_id == false || !user_id) {
    req.session.nextPage = '/post';
    res.redirect('/login');
  }
  else {
    render(req, res, 'post', 'POST PAGE', 'post');
  }
});

//to get to the details page for a certain item
router.get('/details',function(req,res,next){
  render(req, res, 'details', 'DETAILS PAGE', 'details', {script: 'details'});
});

//login page for the user
router.get('/login',function(req,res,next){
  render(req, res, 'login', 'LOGIN PAGE', 'login');
});

//register page 
router.get('/register',function(req,res,next){
  render(req, res, 'register', 'REGISTRATION PAGE', 'register', {script: 'register'});
});

router.get('/messageSent',function(req,res,next){
  render(req, res, 'messageSent', 'MESSAGE SENT PAGE');
});



module.exports = router;
