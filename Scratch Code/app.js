var express = require('express');

var app = express();
var sql = require('mysql');
const config = require('./config');

var con = sql.createConnection({
    //host: '35.202.39.85',
    host: 'localhost',
    user: 'root',
    password: 'Linode@2210',
    database: 'facebook_rating'
    //connectTimeout: 60000
});

con.connect(function(err) {
    console.log(err);
});

var port = process.env.PORT || 8080;

var dbConnRouter = require('./src/routes/dbConnRoutes')(con);

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
/*app.listen(port, function(err) {
    const server = app.listen(config.get('PORT');
    const serv = server.address();
    console.log('running server on port ' + serv);*/
    const server = app.listen(config.get('PORT'), () => {
    const serv = server.address().address;
    const porte = server.address().port;
    console.log(`App listening on port ${serv} and ${porte}`);
});
