-- 1.  Create a stored procedure to show the number of students per department.
-- [use ITI DB]
create proc numStudent
as 
select COUNT(s.St_Id), s.Dept_Id
from Student s
group by s.Dept_Id

numStudent

--2.	Create a stored procedure that will check for the # of employees 
-- in the project p1 if they are more than 3 print a message to the user 
-- “'The number of employees in the project p1 is 3 or more'”
-- if they are less display a message to the user 
--“'The following employees work for the project p1'” 
-- in addition to the first name and last name of each one. [Company DB] 

create proc p1 @p1 varchar(10)
as 

declare @NumCount int , @pNum int
select @pNum = wf.Pno, @NumCount = count(wf.ESSn)
from Works_for wf, Project p
where p.Pnumber = wf.Pno and p.Pname = @p1 
group by wf.Pno

if @NumCount >= 3 
select 'Number of Employees in Project p1 is 3 or more'

else 
begin
select e.Fname + ' ' + e.Lname as the_following_employees_work_for_the_project_p1
from Employee e, Works_for wf
where e.SSN = wf.ESSn and wf.Pno = @pNum
end

p1 'AL Solimaniah'






--3.	 Create a stored procedure that will be used in case 
-- there is an old employee has left the project
-- and a new one become instead of him.
-- The procedure should take 3 parameters 
-- (old Emp. number, new Emp. number and the project number) 
-- and it will be used to update works_for table. [Company DB]

alter proc oldEmpUpdate @oldENum int , @newENum int , @pNum int 
as 

update Works_for
set   ESSn = @newENum
where ESSn = @oldENum and Pno = @pNum 

select * from Works_for



oldEmpUpdate 669955 , 66666, 700




--4.     Create an Audit table with the following structure
create table updateTrials 
(
Hours_Old int,
Hours_New int,
ProjectNo varchar(10) ,
UserName varchar(50) ,
date date
)

alter trigger trials
on Works_for
after update
as
if update([Hours])
begin
declare @Hours_Old int , @Hours_New int, @ProjectNo varchar(10)
select @Hours_New = [Hours] from inserted
select @ProjectNo = [Pno] from inserted
select  @Hours_Old = [Hours] from deleted
select @ProjectNo = [Pno] from deleted
insert into updateTrials  values (@Hours_Old , @Hours_New , @ProjectNo, SUSER_NAME() , GETDATE())

delete from Works_for where [Pno] = @ProjectNo

insert into Works_for
select * from deleted
end

update Works_for set [Hours] = 50  where [Pno]=5000 

select * from updateTrials 




 
 --5.     Create a trigger to prevent anyone from inserting a new record
 -- in the Department table [ITI DB]
-- Print a message for the user to tell him
-- that he ‘can’t insert a new record in that table’
use ITI 

create trigger noInsert
on [Department]
instead of insert
as
select 'cannot insert a new record in that table'

 
insert into Department ([Dept_Id],[Dept_Name])
values (50,'test')



-- 6.  Create a trigger that prevents the insertion Process
-- for the Employee table in March [Company DB].

use Company2008

alter trigger noInsertOnMarch
on [Employee]
after insert
as
if format(getdate() , 'MMMM')='August'
begin 
insert into [Employee]
select * from deleted 
select 'Not allowed for '+SUSER_NAME()
end 


insert into [Employee] ([SSN],[Fname])
values (66666,'test') 

select * from Employee



-- 7.  Create a trigger that prevents users from altering any table in Company DB.

alter trigger preventAltering
on  
instead of update
as
select 'Not allowed'




-- 8.  Create a trigger on student table after insert to 
--  add Row in a Student Audit table (Server User Name, Date, Note)
-- where the note will be
-- “[username] Insert New Row with Key=[Key Value] in table [table name]”

create table AuditTable 
(
Note varchar(50) ,
UserName varchar(50) ,
date date
)





 
-- 9. Create a trigger on student table instead of 
-- delete to add Row in Student Audit table (Server User Name, Date, Note) 
-- where the note will be“ try to delete Row with Key=[Key Value]”
create trigger noDeleteStd
on [Student]
instead of delete 
as
insert into AuditTable values (  'try to delete Row with Key=[Key Value]', SUSER_NAME() , GETDATE())

delete from Student

select * from AuditTable