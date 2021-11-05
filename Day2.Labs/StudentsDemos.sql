-----------------------------Mapping----------------------------------



----------------DDL(CREATE , ALTER , DROP , TRUNCATE)------------------


----------------------------Create table-------------------------------
create table emp
(
Eid int primary key,
Ename varchar(5),
salary int
)

create table Emp
(
id int primary key ,
name varchar(20),
salary float
)
alter table Emp drop column age 

ALTER TABLE Emp
ALTER COLUMN name VARCHAR(50);







-------------Alter(Alter change structure for table)-------------------
--1-Add new column
alter table emp
add did int

--2-Modifying an existing column
ALTER TABLE emp
ALTER COLUMN Ename VARCHAR(50);

--2-Delete an existing column
ALTER TABLE emp
drop COLUMN Ename 

--Drop(used to delete an data and structure)
create table dept
(
did int primary key,
deptname varchar(50)
)
drop table Emp




--------DML(Insert - Update - Delete ----- Merge -TRANSACTIONS )
--1-insert
--simple insert
insert into student
values(400,'khalid','ali','cairo',22,10,1)

--2-Insert values in Specific columns
insert into student(st_id,st_fname,st_lname,st_age,st_super,dept_id)
values(400,'khalid')

--3-row constructor
insert into student
values(402,'khalid1','ali','cairo',22,10,1),
	  (403,'khalid3','ali','cairo',22,10,1),
	  (404,'khalid5','ali','cairo',22,10,1)



USE ITI
--UPDATE 
UPDATE Student 
SET St_Fname='HAMADA'
WHERE St_Id = 54

--update
update student
set st_age=25

update student
set st_age=25
where st_id=3

update student
set st_age=25
where st_age=24

update student
set st_age=25,st_address='alex'
where st_id=5 


delete from student
where st_id=400

-----------------------------DQL(SELECT)-----------------------

--DQL
--select all employees information 
SELECT *
FROM Instructor






select *
from student

--Select Specific column From Table 
--Select Student id and first name 
SELECT St_Id  , St_Fname
FROM Student


--Select Firat name and last nase as Full name 

select st_fname + ' '+ ST_LNAME as [full name]
from student

--Select all student information whos age >=25
SELECT * 
FROM Student
WHERE St_Age >=25

--Select all student information whos age >=25 and age=<30
SELECT * 
FROM Student
WHERE St_Age BETWEEN 25 AND 30



SELECT *
from student
where st_age>25 and st_age <30



--Use between Select all student information 
--whos age >25 and age<30 
SELECT *
from student
where st_age between 26 and 29


--Select Student information for students who live in alex 
SELECT * 
FROM Student
WHERE St_Address = 'ALEX'


--Select Student information for students who live in 
--alex OR cairo

select St_Id , St_Fname
from student
where st_address ='alex' or st_address='cairo'

--Use in 
--Select Student information for students who live in alex and cairo

select * from student
where st_address in('cairo','alex','mansoura')

--Select student information for student who are not From 
--alex and cairo and mansoura

select * from student
where st_address not in('cairo','alex','mansoura')
