if(process.env.NODE_ENV === 'development') {
require("dotenv").config();
}

var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var exphbs = require('express-handlebars');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var tests = require('./routes/tests');
var vertical = require('./routes/vertical');
var process_insert = require('./routes/process_insert');
var register = require('./routes/register');
var login = require('./routes/login');
var clearPage = require('./routes/clear');
var search = require('./routes/search');
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.engine('handlebars', exphbs(
  {
    partialsDir:  './views/partials/',
    layoutsDir:   './views/layouts/',
    defaultLayout:'main-layout'
  }
));
app.set('view engine', 'handlebars');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser('A@w#e$s(o!m)e T!@$eFA&a&^67m N#%q13umb3232%&er 2'));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/tests', tests);
app.use('/vertical', vertical);
app.use('/process_insert', process_insert);
app.use('/register', register);
app.use('/login', login);
app.use('/clear', clearPage);
app.use('/search', search);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
