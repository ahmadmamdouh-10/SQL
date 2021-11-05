--Stored Proc Advantages
--1-It can be easily modified without need to redeploy app 
--2-Reduce Netowrk traffic
--3-Security
--4-Take params
--5-Increase Preformance 
--6-We can write any bussiness logic in it 
--7-Prevent Server Errors
--8-Hide Bussiness Rules

-- types of SP
--1) built in SP

sp_bindrule 

sp_unbindrule 
sp_helptext 
sp_helpconstraint 'TableName'







--2) User Defined SP

--Creat Proc that Display all Students

create proc StdInfo
as
select * from student








--Call stored
--1-
StdInfo
--2-
 execute StdInfo


--Create Proc that Take address and return 
--Students Info in that address

create proc StdAddress @add varchar(10)
as 

select * from student 
where St_Address=@add


StdAddress 'alex'



------------------------Stored With DML------------------------------
--Write Stored that Insert values in students table 
--Note Prevent server error that came from DML Queries

alter proc InsertSTDInfo @id int , @name varchar(10)
as
begin try 
insert into Student (St_id , st_Fname) values (@id  , @name)
end try

begin catch 
select 'Error '
end catch 

InsertSTDInfo 5465 , 'Doaa'







--Create Proc that take two int and print sum

alter proc SumXY @x int = 100 , @y int =50
as
 return @x+@y



 ---Pass parameter by position 


declare @x int
execute @x= SumXY 3
select @x

 -- Pass parameter by Name

execute SumXY @y=54 , @x=54


--Write Proc that take two ages and return student info who's age
--Match that range
	create proc StdAges @age1 int , @age2 int 
	as
	select *
	from Student
	where St_Age between @age1 and @age2

StdAges 20 , 25




-----------------------------insert based on execute--------------------------
	alter proc StdAges @age1 int , @age2 int 
	as
	select st_age
	from Student
	where St_Age between @age1 and @age2

declare @t table(age int)

insert into @t
execute StdAges 20 ,30
select * from @t





------------------------------Stored with return------------------------------ 
---Proc takes id and return age 
create proc StdAge @id int 
as
declare @age int 
select @age = St_Age 
from Student
where St_Id = @id 
return @age

declare @a int 
execute  @a=  StdAge 6
select @a






-------------------Save Proc return value in var------------------------






--Create Proc that take student id Return Student name 
create proc StdName @id int 
as
declare @name varchar(10) 
select @name = St_Fname
from Student
where St_Id = @id 
return @name


declare @name varchar(10)
execute @name= StdName 7
select @name










--Create Proc that take student id Return Student name 
--Note stored has two types of parameters 
--Input 
--Output

alter proc StdName @id int , @name varchar(10) output
as
select @name = St_Fname
from Student
where St_Id = @id 


declare @n varchar(10)
execute StdName 9 , @n output
select @n






--Return more than one value using Output
--Create proc that take student id and return student name , age 
alter proc StdName @id int , @name varchar(10) output , @age int output
as
select @name = St_Fname , @age =St_Age
from Student
where St_Id = @id 

declare @n varchar(10) , @a int 
execute StdName 9 , @n output , @a output 
select @n , @a
  









-------------------------------------- Security -----------------------------------
sp_helptext 'StdName'

alter proc StdName @id int , @name varchar(10) output , @age int output
with encryption
as
select @name = St_Fname , @age =St_Age
from Student
where St_Id = @id 



------------------------------ Input / Output ----------------------------
--Create proc that take student id and return student name , age  

alter proc StdName @Ageid int output  , @name varchar(10) output 
with encryption
as
select @name = St_Fname , @Ageid =St_Age
from Student
where St_Id = @Ageid 

declare @n varchar(10) , @a int =10
execute StdName  @a output  ,  @n output 
select @a , @n





--IS it aviliable to write execute in functions ? 
--Create Stored Procdure
--XXXXXXXXXXXXXXXXXXXX
create proc Test @col varchar(10) , @tab varchar(10)
as
execute ('select '+@col+' from  '+@tab)


Test 'St_Fname' , 'Student'


------------------------Input/Output -------------




-------------------------------------------------------------------
--3)Trigger
----It's a special type or Sored Proc
--Can't call
--can't Send parameter
--triggers  on Table
--Listen to (insert update delete)

---------------------------------DML triggers-------------------------------- 
--Create Trigger that print welcome Message after insert in 
--student table

create trigger t1
on Student 
after insert 
as
select 'Welcome to iti'



insert into Student(St_Id , St_Fname) values (345 , 'Test')








--Create trigger that Get date of update
create trigger t2
on student 
after update 
as
select getdate()


update student set St_Fname= 'Pla' where St_Id=6


--Trigger prevent users from delete from table student 
--and show massege not allowed for user + suser_name()
create trigger t3
on Student 
instead of delete
as
select 'not allowed to '+suser_name()

delete from Student 

select * from student 




--How can i make table read only 
create trigger t4
on student
instead of insert , update , delete 
as
select 'Not allowed'






--Trigger autommatically take schema for Data base object
-- that Trigger created in it 

--Create trigger that say hi if any one update student Fname

create schema s1
go 
alter schema s1 transfer Student 

alter trigger s1.t5 
on s1.student 
after update 
as 
select 'Say Hi'

update s1.Student set st_Fname ='ghg' where St_id =1





--How can we know data after delete it or update it
alter  trigger t6
on [Department]
after delete , update 
as
select * from inserted 
select * from deleted

delete from Department where Dept_Id=80
update Department set Dept_Name='test' where Dept_Id =80





--Create Trigger that select course old and new data after update 
--any column in Student table 
alter trigger t7
on Course 
after update 
as
select i.Crs_Name , d.Crs_Name
from inserted i , deleted d 




update Course set Crs_Name='hkbilj.j' where Crs_Id=100



--Create trigger that print student name that you deleted










--Cretate trigger that prevent user from delete any course in sunday
--and show user that tried to update 
alter trigger t9
on Course 
after delete
as
if format(getdate() , 'dddd')='Sunday'
begin 
insert into Course
select * from deleted 
select 'Not allowed for '+SUSER_NAME()
end 




delete from Course where Crs_Id=40000

select * from Course





----------------------------Audit tables -------------------------------

--Create trigger that audit name for user excute update on 
--On top_id  and date of execution , old and new value 
create table history 
(
OldId int ,
_NewId int ,
name varchar(50),
date date
)

alter trigger t10 
on topic
after update
as
if update(top_id)
begin
declare @oldid int , @newid int
select @newid =top_id from inserted
select  @oldid = top_id from deleted
insert into history values (@oldid , @newid , SUSER_NAME() , GETDATE())

delete from Topic where Top_Id = @newid

insert into Topic
select * from deleted
end

update topic set Top_Id = 254 , Top_Name = 'tttt' where Top_Id=6

select * from history

update topic set Top_Name = 'sfkf,n'  where Top_Id=6









---------------------------disable/enable Trigger------------------------
alter table department disable trigger t4
alter table department enable trigger t4
-------------------------------Drop DML trigger---------------------------

drop trigger t5

---------------------------------  DDL  -------------------------------
create trigger t5
on database
for create_table 
as 
select'wlcome'
rollback

drop table history

select * from history

select * from emp

------------------------------enable / disable Trigger-----------------------
ENABLE TRIGGER t5 ON DATABASE
GO
DISABLE TRIGGER t5 ON DATABASE
GO
----------------------enable / disable all Triggers in table------------------
ENABLE TRIGGER ALL ON TableName
DISABLE TRIGGER ALL ON topic

--------------------------------Drop DDL trigger------------------------------

DROP TRIGGER t5 ON DATABASE

-------------------------output Runtime trigger-------------------
insert into s1.Student(St_Id , st_Fname)
output  'Welcome  '+ inserted.st_Fname 
values(554 , 'waefjh')


update s1.Student 
set st_Fname ='PLLLLLLLLLLLLa'
output deleted.st_Fname
where st_id =554

delete from s1.Student 
output 'deleted ', GETDATE() , SUSER_NAME()
where st_id = 5465