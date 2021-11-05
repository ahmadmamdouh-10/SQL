---------------------------- ----Part 1 -----------------------------------
use ITI
--1. Create a view that displays the student’s full name, course name if the student has a grade of more than 50.

alter view v_Student
as 
select s.St_Fname + ' ' + s.St_Lname as Fullname  , sc.Crs_Name
from Student s, Stud_Course scr, Course sc
where s.St_Id = scr.St_Id and sc.Crs_Id = scr.Crs_Id and scr.Grade > 50 

select * from v_Student

--2. Create an Encrypted view that displays manager names and the topics they teach. 

alter view V_ManagerTopics
with encryption
as 
select i.Ins_Name, t.Top_Name
from Department d , Instructor i, Ins_Course ic, Course c,Topic t
where i.Ins_Id = d.Dept_Manager and i.Ins_Id = ic.Ins_Id and c.Crs_Id = ic.Crs_Id and t.Top_Id = c.Top_Id


select *
from V_ManagerTopics


--3.  Create a view that will display Instructor Name, 
--Department Name for the ‘SD’ or ‘Java’ Department 

--“use Schema binding” and describe what is the meaning of Schema Binding 


--  It means that as long as that schemabound object exists as a schemabound object 
-- (ie you don’t remove schemabinding) you are limited in changes
-- that can be made to the tables or views that it refers to.


create view vInstructorName1
with schemabinding	
as 
select i.Ins_Name, d.Dept_Name
from dbo.Department d, dbo.Instructor i
where d.Dept_Name in ('SD', 'Java') 

select * from vInstructorName1

-- schema binding "Description and review it from the Audio's lecutre "

select * from vInstructorName

--4.Create a view “V1” that displays student data for the student 
--who lives in Alex or Cairo.

create view V1
as
select *
from Student s
where  St_Address in ('cairo','alex')

select * from V1 
order by St_Address


--5.	Create a temporary table [Session based] on Company DB 
--       to save employee name and his today task.

create table  #t
(
  employeeName varchar(50),
  task varchar(50)
)



---------------------------------------PART TWOO -------------------------------------



--1)	 Create a view that will display the project name 
--        and the number of employees works on it.

create view vpname1
as 
select count(e.[SSN]) as numberOfEmployees, p.[Pname]
from [dbo].[Employee] as e , [dbo].[Works_for] as wf ,[dbo].[Project] as p
where e.[SSN]= wf.[ESSn] and p.[Pnumber] = wf.[Pno]
group by p.[Pname]


select * from vpname1


--2)	Create a view named   “v_D30”
--      that will display employee number, 
--      project number, hours of the projects in department 30.

create view v_D30
as 
select count(wf.Hours) as HoursInProject, p.Pnumber, d.Dnum
from [dbo].[Employee] as e , [dbo].[Works_for] as wf, [dbo].[Departments] as d, [dbo].[Project] as p
where e.SSN = wf.ESSn and d.Dnum = p.Dnum and d.Dnum = 30
group by p.Pnumber, d.Dnum

select * 
from v_D30
  

--3)	Create a view named  “v_without_budget” that will display
--      all the projects data without a budget

create view v_without_budget
as 
select *
from [dbo].[Project] 

select * from v_without_budget


--4)	Create a view named  “v_count “ that will display the project name and the number of hours for each one. 

create view v_count
as 
select count(wf.Hours) as HoursInProject, p.Pname
from [dbo].[Employee] as e , [dbo].[Works_for] as wf, [dbo].[Departments] as d, [dbo].[Project] as p
where e.SSN = wf.ESSn and d.Dnum = p.Dnum 
group by p.Pname

select * from v_count



--5)	 ” v_project_500” that will display the emp no. 
--        for the project 500, use the previously created view  “v_D30”

alter view v_project_500
as
select e.[SSN], v.HoursInProject , v.Pnumber
from v_D30 as v,[dbo].[Employee] as e
where v.Pnumber = 500

select * from v_project_500


--6)	modify the view named  “v_without_budget”  to display all DATA in project 300 and 400
alter view v_without_budget
as 
select *
from [dbo].[Project] as p
where p.Pnumber in (300,400)

select * from v_without_budget

--7)	Delete the views  “v_D30” and “v_count”
drop view v_D30, v_count


--8)	Create a view that will display the emp no. and emp lastname who works on dept no. is 20
create view v8
as
select e.SSN , Lname
from  [dbo].[Employee] as e
where e.Dno = 20 

select * from v8

--9)	Display the employee  lastname that contains the letter “l”
--       Use the previous view created in Q#8

select v.Lname
from v8 as v
where v.Lname like '%l%'


--10)	Create a view named “v_dept” that will display the department no. 
--       and department name

create view v_dept
as 
select d.Dname, d.Dnum
from Departments d

select * from  v_dept

--11)	using the previous view try to enter new department data where dept  is ’60’ and dept name is ‘Development’
insert into v_dept values ('Development', 60)



--12)	 add new column Enter_Date in Works_for 
-- and insert it then create view name “v_2021_check”
-- that will display employee no., which must be from the first of January 
-- and the last of December 2021. this view will be used to insert data
-- so make sure that the coming new data must match the condition

alter table [dbo].[Works_for] 
add Enter_Date date 


alter view v_2021_check
as 
select e.SSN
from [dbo].[Employee] as e
where e.Bdate >= '20210101' AND e.Bdate < DATEADD(DAY, 1, '20213012')

