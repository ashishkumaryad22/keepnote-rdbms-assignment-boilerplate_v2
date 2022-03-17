create database assignment;    
use assignment;    

--Create the tables for Note, Category, Reminder, User, UserNote, NoteReminder and NoteCategory.

--User table fields: user_id, user_name, user_added_date, user_password, user_mobile.
create table User(user_id int primary key AUTO_INCREMENT, user_name varchar(25),user_added_date date,user_password varchar(50),user_mobile int(20)not null);
desc User;

--Insert the rows into the created tables (User). 
insert into User() values(10001,'alok','2019-05-15','alok@123','26534625');
insert into User() values
(10002,'ankit','2019-05-24','ankit@123','2272346'),
(10003,'sumit','2020-05-24','sumit@123','2272342'),
(10004,'zaheer','2022-05-24','zaheer@123','22898898'),
(10005,'raju','2015-08-24','raju@123','2223299');

select * from User;

--Note table fields: note_id, note_title, note_content, note_status, note_creation_date.
create table Note(note_id int primary key AUTO_INCREMENT,note_title varchar(25),note_content text,note_status varchar(15),note_creation_date date);
desc Note;


--Insert the rows into the created tables (Note). 
insert into Note() values
(1001,'product','product delivery details','pending','2012-04-12'),
(1002,'refund','refund issues','solved','2020-04-23'),
(1003,'enquery','complaint against bad services','asccelate','2019-05-08'),
(1004,'item','item deatiling ','rejected','2021-04-04'),
(1005,'rubber','rubber for sale','deliverd','2022-02-18');

select * from Note;

--Category table fields : category_id, category_name, category_descr, category_creation_date, category_creator
create table Category(category_id int primary key AUTO_INCREMENT,category_name varchar(25),category_descr text,category_creation_date date,category_creator varchar(25) not null);
desc Category;


--Insert the rows into the created tables (Category). 
insert into Category() values
(50001,'cloths','cloths retated item','2020-09-08','Anurag'),
(50002,'cosmetics','cosmetics retated item','2017-06-02','Suresh'),
(50003,'mobiles','mobile and laptops retated item','2014-11-03','Deepak'),
(50004,'Electronics','home applinces retated item','2021-03-12','kansal'),
(50005,'atomobiles','vehicle retated item','2010-09-28','Aditya');

select * from Category;

--Reminder table fields : reminder_id, reminder_name, reminder_descr, reminder_type, reminder_creation_date, reminder_creator
create table Reminder(reminder_id int primary key AUTO_INCREMENT,reminder_name varchar(30),reminder_descr text,reminder_type varchar(15),reminder_creation_date date,reminder_creator varchar(20) not null);
desc Reminder;


--Insert the rows into the created tables (Reminder). 
insert into Reminder() values
(20001,'salary policy','salary fund description','level-2','2022-03-15','Ankur'),
(20002,'leave Policy','leave protocal and details','level-1','2021-09-27','Sani'),
(20003,'Security policy','security in data leakage','level-3','2020-08-24','Deepu'),
(20004,'transpory policy','transport for defferent places','level-3','2021-11-19','karan'),
(20005,'medical policy','Medical claims and benifites','level-2','2020-10-23','Annu');

select * from Reminder;

--NoteCategory table fields : notecategory_id, note_id, category_id
create table NoteCategory(notecategory_id int primary key AUTO_INCREMENT,note_id int,category_id int,foreign key(note_id) references Note(note_id),foreign key(category_id) references Category(category_id));
desc NoteCategory;


--Insert the rows into the created tables (NoteCategory). 
insert into NoteCategory() values(101,1001,50002),(102,1002,50001),(103,1002,50002),(104,1004,50003),(105,1003,50004),(106,1005,50001),(107,1001,50005);
select * from NoteCategory;

--NoteReminder table fields : notereminder_id, note_id, reminder_id
create table NoteReminder(notereminder_id int primary key AUTO_INCREMENT, note_id int,reminder_id int,foreign key(note_id) references Note(note_id),foreign key(reminder_id) references Reminder(reminder_id));
desc NoteReminder;


--Insert the rows into the created tables (NoteReminder). 
insert into NoteReminder() values(401,1001,20003),(402,1002,20005),(403,1005,20004),(404,1003,20002),(405,1001,20005),(406,1002,20003),(407,1004,20001);
select * from NoteReminder;

--usernote table fields : usernote_id, user_id, note_id
create table UserNote(usernote_id int primary key AUTO_INCREMENT, note_id int,user_id int,foreign key(note_id) references Note(note_id),foreign key(user_id) references User(user_id));
desc UserNote;


--Insert the rows into the created tables (UserNote). 
insert into UserNote() values(901,1003,10002),(902,1004,10003),(903,1002,10001),(904,1001,10005),(905,1002,10004),(906,1003,10005),(907,1002,10004);
select * from UserNote;


--Fetch the row from User table based on Id and Password.
select * from User where user_id=10001 and user_password='alok@123';
select * from User where user_id=10001 or user_password='alok@123';


--Fetch all the rows from Note table based on the field note_creation_date.
select * from Note where note_creation_date='2020-04-23';
select * from Note where note_creation_date in('2020-04-23','2012-04-12','2019-05-08');

--Fetch all the Categories created after the particular Date.
select * from Category where category_creation_date >='2017-06-02';


--Fetch all the Note ID from UserNote table for a given User.
select note_id from UserNote where user_id = 10004;
select note_id from UserNote where user_id in(10004,10005);
select note_id from UserNote where user_id=(select user_id from User where user_name='ankit');


--Write Update query to modify particular Note for the given note Id.
update Note set note_title = 'febrics' where note_id=1001;
update Note set note_title = 'cloths' , note_status = 'followUp' where note_id=1001;


--Fetch all the Notes from the Note table by a particular User.
select * from Note where note_id IN ( select note_id from UserNote where user_id=10004);
select * from Note where note_id IN ( select note_id from UserNote where user_id=(select user_id from User where user_name='raju'));


--Fetch all the Notes from the Note table for a particular Category.
select * from Note where note_id IN (select note_id from NoteCategory where category_id=50002);
select * from Note where note_id IN (select note_id from NoteCategory where category_id=(select category_id from Category where category_name='mobiles'));
select * from Note where note_id IN (select note_id from NoteCategory where category_id=(select category_id from Category where category_name='Electronics'));


--Fetch all the reminder details for a given note id.
select * from  Reminder where reminder_id IN (select reminder_id from NoteReminder where note_id=1003);
select * from  Reminder where reminder_id IN (select reminder_id from NoteReminder where note_id=1004);
select * from  Reminder where reminder_id IN (select reminder_id from NoteReminder where note_id=1002);


--Fetch the reminder details for a given reminder id.
select * from Reminder where reminder_id IN (20004,20005);


--Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
insert into User(`user_name`,`user_added_date`,`user_password`,`user_mobile`)  values( "Karan", "2022-05-22", "Karan@123", "723426854");
insert into UserNote(note_id, user_id) values(1003,last_insert_id());

--Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)
insert into Note(`note_title`,`note_content`,`note_status`,`note_creation_date`)  values( "Api", "All used API Details", "progress", "2000-06-20");
insert into NoteCategory(note_id, category_id) values(last_insert_id(), 50004);

--Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
insert into Reminder (`reminder_name`,`reminder_descr`,`reminder_type`,`reminder_creation_date`,`reminder_creator`)  values("jogging", "jogging early in the morning", "level-1", "2000-06-20", "tanu");
insert into Notereminder (`note_id`,`reminder_id`) values(1002,last_insert_id());


--Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)
delete from UserNote where user_id=10006 and  note_id=1003 ;
delete from User where user_id=10006;
delete from Note where note_id=1003;


--Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
delete from NoteCategory where category_id=50004 and note_id=1006 ;
delete from Note where note_id=1006;



--Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
--1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically)
DELIMITER //
create trigger del_note before delete on Note FOR EACH ROW Begin delete from UserNote where note_id=old.note_id; delete from Notereminder where note_id=old.note_id; delete from NoteCategory where note_id=old.note_id; END; //
DELIMITER ;

delete from Note where note_id=1006;
delete from Note where note_id=1005;


--2. A particular user is deleted from User table (all the matching notes should be removed automatically)
DELIMITER //
create trigger del_user before delete on User FOR EACH ROW Begin delete from UserNote where note_id=old.user_id;
 delete from NoteReminder where note_id=old.user_id;  delete from Category where category_creator=old.user_id;  
 delete from NoteCategory where note_id=old.user_id;  END; //
DELIMITER ;

delete from User where user_id=10003;
