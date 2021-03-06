CREATE SCHEMA inbidwin
DEFAULT CHARACTER SET utf8mb4;
-- DROP SCHEMA inbidwin;

USE inbidwin;

CREATE TABLE user (
userid int unsigned PRIMARY KEY auto_increment,
username varchar(100) UNIQUE NOT NULL,
fname varchar(100) NOT NULL,
lname varchar(100) NOT NULL,
password varchar(100) NOT NULL,
email varchar(100) UNIQUE NOT NULL,
credit decimal(14,3) unsigned default 0
);
-- DROP TABLE user;

create table role(
roleid int UNSIGNED PRIMARY KEY auto_increment,
rolename varchar(30) UNIQUE
);
-- DROP TABLE role;

create table user_role(
userid int UNSIGNED NOT NULL,
roleid int UNSIGNED NOT NULL,
PRIMARY KEY(userid, roleid),
CONSTRAINT userrolefk1 FOREIGN KEY (userid) 
REFERENCES user(userid),
CONSTRAINT userrolefk2 FOREIGN KEY (roleid) 
REFERENCES role(roleid)
);
-- DROP TABLE user_role;

CREATE TABLE house(
hid int unsigned PRIMARY KEY auto_increment,
hlocation varchar(100) NOT NULL,
hfloor int unsigned default 0,
hsize int unsigned default 0,
hroom int unsigned default 0,
hbathroom int unsigned default 0,
hheating varchar(100),
hfurnished varchar(3),
hdescr varchar(200)
);
-- DROP TABLE house;

CREATE TABLE item (
itemid int unsigned PRIMARY KEY auto_increment,
ititle varchar(100) NOT NULL,
iprice decimal(14,3) unsigned default 0,
istatus varchar(10) NOT NULL,
user int unsigned NOT NULL,
house int unsigned NOT NULL,
CONSTRAINT fk_house FOREIGN KEY (house)
REFERENCES house(hid),
CONSTRAINT fk_user FOREIGN KEY (user)
REFERENCES user(userid)
);
-- DROP TABLE item;

CREATE TABLE image(
iid int unsigned PRIMARY KEY auto_increment,
iphoto VARCHAR(100),
house int unsigned NOT NULL,
CONSTRAINT fk_house2 FOREIGN KEY (house)
REFERENCES house(hid)
);
-- DROP TABLE image;

CREATE TABLE auction(
auctionid int unsigned PRIMARY KEY auto_increment,
aincrement int unsigned default 0,
areserve int unsigned,
stime DATETIME,
etime DATETIME,
item int unsigned NOT NULL,
CONSTRAINT fk_item2 FOREIGN KEY (item)
REFERENCES item(itemid)
);
-- DROP TABLE auction;

CREATE TABLE bid(
bidid int unsigned PRIMARY KEY auto_increment,
bprice decimal(14,3) unsigned default 0,
btime DATETIME,
auction int unsigned NOT NULL,
user int unsigned NOT NULL,
CONSTRAINT fk_auction FOREIGN KEY (auction)
REFERENCES auction(auctionid),
CONSTRAINT fk_user2 FOREIGN KEY (user)
REFERENCES user(userid)
);
-- DROP TABLE bid;

CREATE TABLE transaction(
tid int unsigned PRIMARY KEY auto_increment,
tprice decimal(14,3) unsigned default 0,
item int unsigned NOT NULL,
owner int unsigned NOT NULL,
winner int unsigned NOT NULL,
CONSTRAINT fk_owner FOREIGN KEY (owner)
REFERENCES user(userid),
CONSTRAINT fk_winner FOREIGN KEY (winner)
REFERENCES user(userid),
CONSTRAINT fk_item3 FOREIGN KEY (item)
REFERENCES item(itemid)
);
-- DROP TABLE transaction;



-- ********* SYNTHETIC DATA ************* --

INSERT INTO user (fname, lname, username, password, email, credit)
VALUES ('George', 'Pasparakis', 'georgepasp', '$2y$10$XoGU8jxStGcKaIM4/DZLuujuxIx8ECfhxlDfzNKSx6Le7GXRM1H/G', 'gpasparakis@gmail.com', 652),
('Tasos', 'Lelakis', 'emergon', '$2y$10$XoGU8jxStGcKaIM4/DZLuujuxIx8ECfhxlDfzNKSx6Le7GXRM1H/G', 'tlelakis@gmail.com', 1245.35);

INSERT INTO role(rolename) 
VALUES ('ROLE_ADMIN'),
('ROLE_USER'),
('ROLE_GUEST');

INSERT INTO user_role(userid, roleid)
VALUES (1,1),
(2,2);

INSERT INTO house (hlocation, hfloor, hsize, hroom, hbathroom, hheating,  hfurnished, hdescr)
VALUES ('Navarinou 8', 1, 70, 2, 1, 'fusiko aerio',  'No', 'Newly renovated, very cosy'),
('Kifisias 65',  2, 50, 1, 2, 'Central with oil',  'Yes', 'Old apartment, very close to transportation');

INSERT INTO item (ititle, iprice, istatus, house , user)
VALUES ('Renovated home', 500, 'DISABLED', 1, 2),
('Central Athens', 300, 'DISABLED', 2 , 1);

INSERT INTO image (iphoto, house)
VALUES ('https://i.postimg.cc/RV82vCKw/cgji0ufwnk941.jpg', 1),
('https://i.postimg.cc/2SYRKY4x/m8iaqfwpxqa41.jpg',1),
('https://i.postimg.cc/TwgJSzjr/image.jpg',1),
('https://i.postimg.cc/t4nZ2hN6/aa8137bb-1797-43bd-909f-c14c440c1af0-l.jpg',2),
('https://i.postimg.cc/vTDHDsPn/attractive-internal-house-designs-spectacular-interior-in-kerala.jpg',2);


