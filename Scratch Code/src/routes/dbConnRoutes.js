var express = require('express');
var bookRouter = express.Router();
var sql = require('mysql');
var info = {
  name: {
    first_name: "",
    last_name: ""
  },
  likes: {
    sum: 0
  }
};

var router = function(con) {

  bookRouter.route('/')
    .get(function(req, res) {
      var userID = 1;
      con.query('select * from user where userID = ?', userID,
          function(err, rec) {
             info.name = rec[0];
      });
      con.query('select count(*) as sum from likes where forID = ?', userID,
          function(err, rec) {
             info.likes = rec[0];
      });
      con.query('select * from rating where userID = ?', userID, function(err, rec) {
        //console.log(rec);
        var rating = rec[0].rating + info.likes.sum;
        if (rating < 500) {

        }
        else if(rating > 500) {
          var link = 'social.jpg';
        }
        res.render('index', {
          rating: link,
          name: info.name
        });
      });
    });

  return bookRouter;
};

module.exports = router;
