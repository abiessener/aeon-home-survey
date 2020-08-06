var express = require('express');
var app = express();
var bodyParser = require('body-parser');

require('dotenv').config();

var passport = require('./strategies/sql.localstrategy');
var sessionConfig = require('./modules/session.config');

// Route includes
var indexRouter = require('./routes/index.router');
var userRouter = require('./routes/user.router');
var registerRouter = require('./routes/register.router');
var csvRouter = require('./routes/csv.router');
var surveyRouter = require('./routes/survey.router');
var userRolesRouter = require('./routes/user-roles.router');
var siteManagerRouter = require('./routes/site-manager.router');
var adminRouter = require('./routes/admin.router');
var propertiesRouter = require('./routes/properties.router')


var port = process.env.PORT || 5000;

// Body parser middleware
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

// Serve back static files
app.use(express.static('./server/public'));

// Passport Session Configuration
app.use(sessionConfig);

// Start up passport sessions
app.use(passport.initialize());
app.use(passport.session());

// Routes
app.use('/register', registerRouter)
app.use('/user', userRouter)
app.use('/csv', csvRouter)
app.use('/survey', surveyRouter)
app.use('/user-roles', userRolesRouter)
app.use('/site-manager', siteManagerRouter)
app.use('/admin', adminRouter)
app.use('/properties', propertiesRouter)


// Catch all bucket, must be last!
app.use('/', indexRouter);

// Listen //
app.listen(port, function () {
    console.log('Listening on port:', port);
});
