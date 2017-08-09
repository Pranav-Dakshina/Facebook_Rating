var express = require('express');
var Knex = require('knex');
var app = express();
var sql = require('mysql');

const config = {
  user: process.env.SQL_USER,
  password: process.env.SQL_PASSWORD,
  database: process.env.SQL_DATABASE
};

if (process.env.INSTANCE_CONNECTION_NAME && process.env.NODE_ENV === 'production') {
  if (process.env.SQL_CLIENT === 'mysql') {
    config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
  } else if (process.env.SQL_CLIENT === 'pg') {
    config.host = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
  }
}

// Connect to the database
const con = Knex({
  client: process.env.SQL_CLIENT,
  connection: config
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
app.listen(port, function(err) {
    console.log('running server on port ' + port);
});
