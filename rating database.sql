/*CREATE DATABASE facebook_rating;*/
/*
CREATE TABLE user(userid INT NOT NULL AUTO_INCREMENT,
				first_name VARCHAR(20),
                last_name VARCHAR(20), 
                sex CHAR(1),
                dob DATE, 
                PRIMARY KEY(userid), 
                UNIQUE KEY(userid));

CREATE TABLE likes(forID INT NOT NULL,
					photoID INT NOT NULL,
					fromID INT NOT NULL, 
                    primary key(forID, photoID, fromID), 
                    foreign key(forID)
                    references user(userID));                    
                    
CREATE TABLE posts(forID INT NOT null,
					postID int not null,
                    primary key(forID, postID),
                    foreign key(forID)
                    references user(userID));
			
CREATE TABLE counter(userID INT NOT null,
					no_of_likes int not null,
                    no_of_posts int not null,
                    primary key(userID),
                    foreign key(userID)
                    references user(userID));

CREATE TRIGGER update_counter_likes
		AFTER UPDATE ON likes
        FOR EACH ROW
	INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				values(likes.forID, 0, 0)
                ON DUPLICATE KEY UPDATE
                no_of_likes = no_of_likes + 1; 

CREATE TRIGGER update_counter_posts
		AFTER UPDATE ON posts
        FOR EACH ROW
	INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				VALUES(likes.forID, 0, 0)
                ON DUPLICATE KEY UPDATE
                no_of_posts = no_of_posts + 1; 
                
CREATE TABLE posts_counter(postID int not null,
					no_of_shared int not null,
                    primary key(postID));

CREATE TRIGGER update_posts_counter
		AFTER UPDATE ON posts
        FOR EACH ROW
	INSERT INTO posts_counter(postID, no_of_shared) 
				VALUES(posts.forID, 1)
                ON DUPLICATE KEY UPDATE
                no_of_shared = no_of_shared + 1;   

DROP TRIGGER IF EXISTS update_counter_posts;

SHOW triggers;

CREATE TRIGGER update_counter_posts
		AFTER UPDATE ON posts
        FOR EACH ROW
	INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				VALUES(posts.forID, 0, 1)
                ON DUPLICATE KEY UPDATE
                no_of_posts = no_of_posts + 1; 
                
DROP TRIGGER IF EXISTS update_counter_likes;

CREATE TRIGGER update_counter_likes
		AFTER UPDATE ON likes
        FOR EACH ROW
	INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				values(likes.forID, 1, 0)
                ON DUPLICATE KEY UPDATE
                no_of_likes = no_of_likes + 1; 

SHOW triggers;

DROP TRIGGER IF EXISTS update_posts_counter;

CREATE TRIGGER update_posts_counter
		AFTER UPDATE ON posts
        FOR EACH ROW
	INSERT INTO posts_counter(postID, no_of_shared) 
				VALUES(posts.postID, 1)
                ON DUPLICATE KEY UPDATE
                no_of_shared = no_of_shared + 1; 
                
show triggers;

insert into user(first_name, last_name, sex, dob) 
			values("Pranav", "Dakshinamurthy", "M", "1991-02-11");
            
Select userID, first_name, last_name, sex,date_format(dob, "%W %M %e %Y") from user;

insert into user(first_name, last_name, sex, dob) 
			values("Sreenivasa", "Ayyalasomayajula", "M", "1993-03-18");

insert into user(first_name, last_name, sex, dob) 
			values("Dakshinamurthy", "Eswarappan", "M", "1959-07-15");
            
insert into likes(forID, photoID, fromID) 
			values(1, 1, 2);
            
insert into likes(forID, photoID, fromID) 
			values(1, 1, 3);
            
select forID, photoID, fromID from likes;

select * from counter;

show triggers;

delete from likes where forID > 0;

select* from likes;

drop trigger if exists update_posts_counter;

drop trigger if exists update_counter_likes;

drop trigger if exists update_counter_posts;

CREATE TRIGGER update_counter_posts
		AFTER INSERT ON posts
        FOR EACH ROW
	INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				VALUES(NEW.forID, 0, 1)
                ON DUPLICATE KEY UPDATE
                no_of_posts = no_of_posts + 1; 

delimiter $$
CREATE TRIGGER update_counter_likes
		AFTER INSERT ON likes
        FOR EACH ROW
	BEGIN */
    /* declare ins_id INT;
    
    select forID into ins_id from likes where likes.forID = NEW.forID;
    */
	/* INSERT INTO counter(userID, no_of_likes, no_of_posts) 
				values(NEW.forID, 1, 0)
                ON DUPLICATE KEY UPDATE
                no_of_likes = no_of_likes + 1; 
                
	END;
$$
delimiter ; 


CREATE TRIGGER update_posts_counter
		AFTER INSERT ON posts
        FOR EACH ROW
	INSERT INTO posts_counter(postID, no_of_shared) 
				VALUES(NEW.postID, 1)
                ON DUPLICATE KEY UPDATE
                no_of_shared = no_of_shared + 1; 
                
insert into likes values(1, 1, 2);

select * from login_info;*/

insert into posts(forID, postID) values(1,1);

insert into posts(forID, postID) values(1,2);

insert into posts(forID, postID) values(2,1); 

select * from posts_counter;

CREATE TABLE login_info(userid INT NOT NULL,
				  uname VARCHAR(20),
                  pass VARCHAR(20),  
                  PRIMARY KEY(userid), 
                  UNIQUE KEY(userid),
			      FOREIGN KEY(userid)
				  REFERENCES user(userid)); 
                  
INSERT INTO login_info(userid, uname, pass) values(1,"pranav","pranav");
/*
select * from posts;
select * from posts_counter;
select * from user;
select * from likes;
select * from login_info;
select * from counter;
select * from rating;*/

create table rating(userID INT NOT NULL,
					rating BIGINT NOT NULL,
                    primary key(userID), 
                    foreign key(userID)
                    references user(userID));
                    
ALTER TABLE rating
ALTER rating SET DEFAULT 0;

select * from rating;

delimiter $$
CREATE TRIGGER rating
		AFTER INSERT ON posts
        FOR EACH ROW
BEGIN
    INSERT INTO rating(userID, rating) 
				VALUES(NEW.forID, 
	ROUND(1000/(SELECT no_of_shared from posts_counter where postID = NEW.postID)))
                ON DUPLICATE KEY UPDATE
                rating =  rating +
	ROUND(1000/(SELECT no_of_shared from posts_counter where postID = NEW.postID));

END;	   
$$
delimiter ; 

insert into posts(forID, postID) values(3,1); 
insert into posts(forID, postID) values(3,2); 

truncate table posts;
/*
SELECT COUNT(*) as sum FROM likes where forID = 1;

GRANT ALL PRIVILEGES ON *.* TO 'Nero'@'%' IDENTIFIED BY 'Mysql@2210' WITH GRANT OPTION;
 FLUSH PRIVILEGES;
 
*/
