var express = require('express');
var router = express.Router();
var render = require('../models/loginCheck').renderUserAndCategory;

router.get('/', function(req, res, next) {
  render(req, res, 'home', 'HOME PAGE', 'home');
});

router.get('/index', function(req, res, next) {
  render(req, res, 'index', 'ABOUT');
});

router.get('/gayatri', function(req, res, next) {
  render(req, res, 'team/gayatri', 'ABOUT');
});
router.get('/charul', function(req, res, next) {
  render(req, res, 'team/charul', 'ABOUT');
});
router.get('/dylan', function(req, res, next) {
  render(req, res, 'team/dylan', 'ABOUT');
});
router.get('/moses', function(req, res, next) {
  render(req, res, 'team/moses', 'ABOUT');
});
router.get('/peter', function(req, res, next) {
  render(req, res, 'team/peter', 'ABOUT');
});
router.get('/regine', function(req, res, next) {
  render(req, res, 'team/regine', 'ABOUT');
});
router.get('/divam', function(req, res, next) {
  render(req, res, 'team/divam', 'ABOUT');
});

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

router.get('/home',function(req,res,next){
  render(req, res, 'home', 'HOME PAGE', 'home');
});

router.get('/details',function(req,res,next){
  render(req, res, 'details', 'DETAILS PAGE', 'details');
});

router.get('/login',function(req,res,next){
  render(req, res, 'login', 'LOGIN PAGE', 'login');
});

router.get('/register',function(req,res,next){
  render(req, res, 'register', 'REGISTRATION PAGE', 'register', {script: 'register'});
});

module.exports = router;
