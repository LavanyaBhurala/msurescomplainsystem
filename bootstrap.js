const express = require('express');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const authHook = require('./hooks/auth.hook');
const config = require('config');
const path = require('path');

const app = express();

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

app.use('/static', express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, '/views')));

app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'ejs');

const context = config.get('app-context');
const port = config.get('app-port');

app.use(
  session({
    secret: 'LSPxDHHgEJ8uE39AEV6WBDqqYrsTfgoNv1kDVF3e',
    saveUninitialized: true,
    cookie: { maxAge: 1000 * 60 * 60 * 24 },
    resave: false,
  })
);

app.use(function(req, res, next) {
  res.locals.session = req.session
  next();
});

app.use(context, authHook, require('./routes/auth.routes'));
app.use(context, authHook, require('./routes/business.routes'));

app.use(cookieParser());

app.locals.contextPath = context;

app.listen(config.get('app-port'), function () {
  console.log(
    'MSU Complaint System is up and running at %s with context %s',
    port,
    context
  );
});
