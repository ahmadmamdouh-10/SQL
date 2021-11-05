----------------------------- Schema --------------------------------
create schema StudentInfo

alter schema StudentInfo transfer student 

select* from StudentInfo.[Student]

create table StudentInfo.Std
(
id int ,
name varchar(10)
)

-------------------------Create schema ------------------------------
create schema StudentInfo





--to move an existing table to my new schema
alter schema StudentInfo transfer student 








--Create table inside specific schema

create table StudentInfo.Std
(
id int ,
name varchar(10)
)





--Deal with Table after change defualt schema 
select* from StudentInfo.[Student]







---------------------------synonym-----------------------------

select * from [HumanResources].[EmployeeDepartmentHistory]

create synonym s1 for [HumanResources].[EmployeeDepartmentHistory]

select * from [dbo].[s1]

-----------------------Create synonym--------------------------










-----------------------Database integrity---------------------
create table Dept1
(did int primary key,
dname varchar(10)
)


create table emp
(
eid int  identity(1 , 1) ,
ename varchar(20) not null  ,
eaddress varchar(20) default 'alex' ,
BD date  ,
age as (year(getdate())-year(BD))  ,
Gender varchar(1),
hiredate date  default getdate(),
hourRate int default 100 ,
salary int unique,
overTime int not null ,
netSalary as salary+overtime ,
did int ,
 constraint c1 primary key(eid,ename),         --Entity integrity(Row Uniqness)
 constraint c2 unique(salary )  ,
 constraint c3 unique(overtime),


 constraint c4 check(salary>1000),
 constraint c15 check(eaddress in('sohag' , 'cairo' , 'alex')),
 constraint c16 check(Gender='F' or Gender='M'),
 constraint c17 check(overtime between 100 and 500),
 constraint c8 foreign key(did)  references Dept1(did)
)
alter table emp add constraint c100 check(hourRate<10)















-------------------------Rule-----------------------------
create rule r1 as @x<10
go
sp_bindrule r1 , 'emp.hourRate'
go
sp_unbindrule 'emp.hourRate'


go 
create default d2 as 500

sp_bindefault d2 , 'emp.hourRate'



























-------------------------------------Rules----------------------------------------------
--what if we want to apply Constraint in new data only
--what if we want to write Constraint once and make it
--- shaired on more than one column
--what if we want to Datatype and apply constraint 
---and Rules on it 
--As Resualt for all of that their is a Rules that
--- solve ali this problems

--XXXXX       Constraint   ---> New Data
--XXXXX       Constraint   --->shared 
--XXXXX       Datatype        Constraint    Default

--------------------------------Create Rule------------------------------------









--------------------------------Create default------------------------------------









---------------------------------Complex data type----------------------------------
--Creating user defined data type
-- OverTimeValue  int not null , value between 100 and 500 ,
-- default 150

create type OverTimeValue from int not null
go
create rule RangeOFVal as @x between 100 and 500

sp_bindrule RangeOFVal , OverTimeValue

create default d4 as 150

sp_bindefault d4 ,  OverTimeValue


create table test
(
id int , 
overt OverTimeValue
)






--Using new data type on a existing table table
--but that column must no have any data base objects related to it like
--(constraint ) 







--Removing user defined Data type
drop type OverTimeValue






------------------------------Views------------------------------------
/** Views **/
/*
IS A Saved select statment we can't write insert update delete in it 

--Why and when we use it?
•	Simplify construction of complex queries
•	Specify user view
•	Limit access to data [grant revoke]
•	Hide names of database objects [table name and columns]
*/								


/** Creating Views **/

--Create view for student info

create view VStudent 
as select * from Student 





---Selecting data from View 
select * from VStudent






---Alias name for view column 
--Create view that containt cairo student (sid,sname,sadd)
alter view StdInfo(SID , Name , Address)
as
select s.St_id , St_Fname , St_Address
from Student s

select SID  from StdInfo





--Create view that contains alex  student (sid,sname,sadd)
create view valex
as
select s.St_id , St_Fname , St_Address
from Student s
where  St_Address = 'alex'


select * from valex 

-----Cairo 
create view vcaire
as
select St_id , St_Fname , St_Address
from Student 
where  St_Address = 'cairo'

select * from vcaire








--Create view for cairo and alex students (j , u)
alter view vMix
as
select * from valex
union all 
select * from vcaire

select * from vMix







--Create view for st_id,st_fname,d.dept_id,dept_name

create view Vjoin
as 
select [St_Id] ,[St_Fname] , s.[Dept_Id] ,d.Dept_Name
from Student s , Department d
 where d.Dept_Id = s.[Dept_Id]






-- view for sname,dname,grade
create view StdGrad
as 
select s.[St_Fname]  , v.Dept_Name , sc.Grade
from Student s , Stud_Course sc ,vjoin v
where s.St_id = sc.St_Id and v.[Dept_Id] = s.[Dept_Id]

create view StdGrad1
as 
select s.[St_Fname]  , d.Dept_Name , sc.Grade
from Student s , Stud_Course sc ,Department d
where s.St_id = sc.St_Id and d.[Dept_Id] = s.[Dept_Id]


select * from StdGrad1



select  * from StdGrad







sp_helptext 'StdGrad1'
----------------------For view security------------------------------
alter view StdGrad1
with encryption
as 
select s.[St_Fname]  , d.Dept_Name , sc.Grade
from Student s , Stud_Course sc ,Department d
where s.St_id = sc.St_Id and d.[Dept_Id] = s.[Dept_Id]





----------------------------------- View+DML -------------------------------------
-----View DML in One table
	
---------------------------1- Insert in one table--------------------------------- 
--1- Rest column in table that we toke view from should have one of the flowing
--(Defualt value , identity , allow null , derived)

--insert data in vcairo

select * from student 
 select * from vcaire
insert into vcaire values(60 , 'Text' , 'Sohag')

------------------------------With Check options-------------------------
insert into valex values(51 , 'Karem' , 'cairo') 
select * from valex


alter view valex
as
select s.St_id , St_Fname , St_Address
from Student s
where  St_Address = 'alex'
with check option


--------------------------------------Update-----------------------------
update valex 
set st_Fname ='Hmada' 
where St_id = 51

insert into valex values(51 , 'Karem' , 'alex') 



--------------------------------------Delete -----------------------------
delete from valex
where st_id =51


-------------------DML with view that came from Multi tables-----------------------
--Delete XXXXXXXXXXXXXXXX
--insert   update avilable with conditions

-----------------insert and update must affect in one table --------------

create view Vjoin1(sid,sname,did,dname)
with encryption
as
select st_id,st_fname,d.dept_id,dept_name
from student S inner join department d
	on d.dept_id=s.dept_id

insert int Vjoin1 values(53 , 'Pla' , 10 , 'SD')

insert into Vjoin1(sid,sname) values(53 , 'Pla')
insert into Vjoin1(did,dname) values(560 , 'SD')

update Vjoin1 
set sname ='PLLLLLLa'
where sid= 53
-------------------------------Tables Types----------------------------------
create table test
(
id int , 
name varchar(20)
)
insert into test values(1 , 'fvbj')

create table #test
(
id int , 
name varchar(20)
)

insert into #test values(100 , 'HHHHHHHHHH')
select * from #test

create table ##test
(
id int , 
name varchar(20)
)

insert into ##test values(5454 , 'GGGGGGGGGGGGG')
select into dddd
select * from student 

SELECT *
INTO #tttttt
FROM Stud_Course



