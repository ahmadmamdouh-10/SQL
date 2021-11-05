--Find Sum of instructors salary
select sum(i.Salary)
from Instructor i







--Find Max and Min Salary for instructor 

select max(i.Salary) , min(i.Salary)
from Instructor i





--Count Students -- use * , columns
select count(*)
from Student s






--Find avg student ages

select avg(s.St_Age)
from Student s








--Find Sum of salary for each department 
select sum(i.Salary) as sumSalary , i.Dept_Id
from Instructor i
group by i.Dept_Id








--Find Sum of salary for each department , did , dname 
select sum(i.Salary) , i.Dept_Id , d.Dept_Name
from Instructor i , Department d
where d.Dept_Id = i.Dept_Id
group by i.Dept_Id , d.Dept_Name









--Find avg age for student per city per dept_id
select avg(s.St_Age) as avgAge , s.St_Address,s.Dept_Id 
from Student s
group by s.St_Address,s.Dept_Id 










--Find sum salary for each department
select SUM(i.Salary), i.Dept_Id
from Instructor i
group by i.Dept_Id






--Explore Result
select sum(salary),dept_id
from Instructor
where salary>1000
group by dept_id

-- it will out any instructor whose salary is less than 1000 
-- then will sort it by group id of department 
-- then it will sum the salary of each departement.
-- and display the sum of each department and the id of departments



--Find Sum salry for each department 
--If Department sum slary>10000
select sum(salary),dept_id
from Instructor
group by dept_id
having sum(salary) >10000






--EX
select sum(salary),dept_id
from Instructor
group by dept_id
having Count(ins_id)<6

-- after sorted the instructor rows in groups by department ids 
-- it will count the instructor in each department 
-- then will out any department that has less than 6 instructors on it
-- then it will get the sum of salary of rest of instructor for each 
-- department. 





--EX2
select sum(salary),dept_id
from Instructor
where salary>1000 -- this is the new 
group by dept_id
having Count(ins_id)<6



---------------------------Subquery--------------------------------
--Select student info for students whose age< avg(age)
select *
from Student
where St_Age < (select AVG(st_age) from Student)

select *
from student s
where s.St_Age < 
(
select avg(s.St_Age)
from Student s
)







--(1,15)
select st_id, (select count(st_id) from Student)
from Student 

select s.St_Id, 
(
select COUNT(s.St_Id)
from Student s
)
from Student s




--Find Dname for depts that has students (sub query)

select  d.Dept_Name
from Department d
where d.Dept_Id in 
(
select s.Dept_Id
from Student s
where s.Dept_Id is not null
)







select d.Dept_Name
from Department d
where d.Dept_Id in (
select distinct  Dept_Id
from Student
where Dept_Id is not null
)







- -Find Dname for depts that has students (join)

select d.Dept_Name
from Department d
where d.Dept_Id in (
select distinct  Dept_Id
from Student
where Dept_Id is not null
)



select distinct d.Dept_Name
from Student s , Department d 
where d.Dept_Id = s.Dept_Id and s.Dept_Id is not null






-------------------------Subquery  +  DML----------------------------
--Delete student grades (studentCourse )
--For student who live in cairo

delete from student
where St_Id =
(
select s.St_Id
from Student s, Stud_Course sc 
where s.St_Id = sc.St_Id and s.St_Address = 'cairo'
)


---------------------------union family-------------------------------
--union all    union    intersect   except

select s.St_Fname
from Student s
except
select i.Ins_Name
from Instructor i






--------------------------order by-----------------------------------------
--Select student info orderby St_fname

select s.*
from Student s
order by s.St_Age desc



--Select student info orderby n column in select
select s.St_Id , s.St_Fname , s.St_Age
from Student s
order by  2




--Select st_fname,st_age,dept_id order by St_adress

select s.St_Id ,  s.St_Age , Dept_Id
from Student s
order by  s.St_Address






--Select st_fname,st_age,dept_id order by dept_id ,st_age 

select s.St_Id ,  s.St_Age , Dept_Id
from Student s
order by  st_age ,s.Dept_Id








--Select st_fname,st_age,dept_id order by St_Id ,st_age 

select s.St_Id ,  s.St_Age , Dept_Id
from Student s
order by  st_age , St_Id



--------------------------------Top----------------------------
--Select info for first 3 student
select top(3)*
from Student

select top(3)*
from Student s
order by s.St_Age desc




--Select fname for first 3 student 

select top(3)St_Fname
from Student 





--Select fname for first 3 student who live in alex
select top(3)St_Fname
from Student
where St_Address='alex'





--Select first 3 salary
select top(3)Salary
from Instructor






--Select Top 3 Salary 
select top(3) Salary
from Instructor
order by Salary desc 






--Select Top 3 ages 
select top(3) s.St_Age
from Student s
order by s.St_Age desc 






--Select Top 7 ages --with ties
select top(7) with ties s.St_Age 
from Student s
order by s.St_Age desc 





--newID()   GUID

select NEWID()

--Select newid for each student 
select *  , NEWID() as passCode
from Student








--Select Top 3 student randomly 
select top(3)*
from Student
order by NEWID()






--Select st_fname , st_lname as fullname where
-- full name ='ahmed ali'
select s.St_Fname+' '+s.St_Lname as fullname
from Student s
where s.St_Fname+' '+s.St_Lname ='Ahmed Hassan'


------
--from 
--join 
--on 
--where 
--group by 
--having  
--order by ,aggr
--top 
--select 





--Execution order 





--Try now Select st_fname , st_lname as fullname order by
-- full name 

select s.St_Fname+' '+s.St_Lname as fullname
from Student s
where s.St_Fname+' '+s.St_Lname ='Ahmed Hassan'



---------------------------------------------------
--Numeric DT
bit 0-1 
tinyint 1Byte 0-255
smallint 2Byte -32.767 to 32.768
int 4Byte  
bigint 8Byte 9999999999

--Floating DT
money 8 byte 4digits only 0.0000
smallmoney 4byte 4digits only 0.0000
real 4byte 8digit only and round up 0.000000000
float 8byte up to 32 digit 0.00000000000000000000000000
decimal(7,4) 8byte  4.1111
Numeric(7,4) Old

--Date DT
Date
Time
datetime 1753 to 9999 any decimal
smalldatetime 1990 to 2050 no seconds
datetime2 seconds up to 7 decimal
datetimeoffset +2,

--string DT
char(10) 8000 char,
varchar(50),
nvarchar(50),
varchar(max), //2G
Text old

--binary
binary(100) 4 byte,
varbinary(1000) 8 byte,
image



--Others
--XML
--sql_variant

CREATE TABLE  dbo . Datatypes (
	 dt_bit   bit,
	 dt_tinyint   tinyint,
	 dt_smallint   smallint,
	 dt_int   int,

	 dt_money   money,
	 dt_smallmoney   smallmoney,
	 dt_float   float,
	 dt_decimal   decimal (7, 4),
	 
	 dt_datetime   datetime,
	 dt_smalldatetime   smalldatetime,
	 dt_datetime2   datetime2 (7),
	 dt_datetimeoffset   datetimeoffset (7),
	 dt_date   date,
	 dt_time   time (7),
	 
	 dt_char   char (10),
	 dt_varchar   varchar (50),
	 dt_nvarchar   nvarchar (50),
	 dt_varcharmax   varchar (max),
	 
	 dt_sqlvariant   sql_variant   
)










