var express = require('express');
//var bodyParser = require('body-parser');
//var cookieParser = require('cookie-parser');
//var passport = require('passport');
//var session = require('express-session');

var app = express();
var sql = require('mysql');

var con = sql.createConnection({
    host: 'localhost',
    user: 'Nero',
    password: 'Mysql@2210',
    database: 'facebook_rating'
});

con.connect(function(err) {
    console.log(err);
});

var port = process.env.PORT || 5000;

var dbConnRouter = require('./src/routes/dbConnRoutes')(con);
//var adminRouter = require('./src/routes/adminRoutes')(nav, con);
//var authRouter = require('./src/routes/authRoutes')(nav, con);

app.use(express.static('./public/style'));
app.use(express.static('./public/Icons'));
app.use(express.static('./public/images'));
app.use(express.static('./public/script'));

app.set('views','./src/views');
app.set('view engine', 'ejs');

app.use('/', dbConnRouter);
//app.use('/Admin', adminRouter);
//app.use('/Auth', authRouter);

/*app.get('/', function(req, res) {
    res.render('index');
});*/
app.listen(port, function(err) {
    console.log('running server on port ' + port);
});
