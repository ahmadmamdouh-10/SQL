-------------------------------Variables------------------------------
-------------------Declare variables---------------------  
--Declare then assign then select using select 
declare @x int = 30

select @x= st_age
from Student
where St_Id=5

select @x

--Declare then assign then select using set 

declare @x  varchar(20)

select  St_Fname
from Student
select @x



 
--Delcare and initialize then select 




--Save student avg age in a variable 

declare @x int = (select AVG(s.St_Age)from Student s)
select @x


--Save id and name for student number 7 in variables

declare @id int , @name varchar(10)

select  @id= s.St_Id ,  @name=s.St_Fname
from Student s
where s.St_Id=7

select @id as iD , @name as name 




--------------------Use select for Set and Select-------------------

declare @id int , @name varchar(10)

select  @id= s.St_Id , s.St_Fname
from Student s
where s.St_Id=7

select @id as iD 





--write a qurey that update student 6  name , take name and id from 
--user in run time and then select student name and it's 
--Deparment
declare @id int = 10  , @name varchar(10) = 'Test'

update Student 
set st_Fname = @name
where St_id = @id 

select @id , @name 







---------------------------Table variable------------------------------
--How to declare table and it's columns

declare @t table (name varchar(10))

insert into @t
select St_Fname
from Student

select * from  @t 




--Save age for alex student in a variable
declare @t table (age int)

insert into @t
select St_age
from Student
where St_Address = 'alex'

select * from  @t 




-----------------------Make top dynamic using var----------------------

--Find top n st_age from student students 
declare @x int = 6

select top(@x)*
from Student 
order by St_Age desc 


-----------------------------Dynamic query-----------------------------
declare @tab varchar(20) ='Student' , @col varchar(10) ='St_age'

execute( 'select St_age from Student' )
    

-----------------------------Globle var----------------------
select @@SERVERNAME
select @@VERSION

update Student 
set St_Age+=1
select @@ROWCOUNT

select @@ROWCOUNT


select * from stuhdkf
go 
select @@ERROR 

create table t12
(
id int identity (1 , 4),
name varchar(10)
)
insert into t12 values('DDDD')
select @@IDENTITY

drop table t12
-------------------------------Contarl flow ---------------------------
--if , else 
--begin end
--if exists , if not exists
--while , continue , break 
--case
--iif
--waitfor
--Choose 
------------------------IF , else-----------------------------
--Update st_age with 1 and if numer of row affecred >0 
--print multi rows affected else print no rows affected
declare @x int 
update Student
set St_Age+=1
where st_id=545545
select  @x= @@ROWCOUNT

if (@x>0)
  select 'multi rows affected'

else 
 select 'no rows affected'









------------------------------if exists-----------------------------
--Create table STd1 if it's not existed

if exists ( select * from sys.tables where name='Student' )
select ' Dublicate Table '
else 
create table STD1
(
id int
)









---------------------------------while------------------------------
declare @x int =10
while @x<20
begin 
     set @x+=1
	 if(@x=14)
	 continue 
	 if(@x=17)
	 break 

	 select @x
end




--------------------------------Case------------------------------
/**
Case 
    when Cond  then Res
	when Cond2  then Res
	else Res
end
**/

--write query that take student id from user and check 
--if student age between 20 and 25 print 'you can apply'
--if student age >25 'Sorry you cannot apply'
--if student age <20 ''wait until 20 '
--else not allowed

declare @id int=10 , @age int

select @age = St_Age
from Student
where St_id = @id
select 
case
when @age between 20 and 25 then 'you can apply'
when @age > 25 then 'you can not apply'
when @age <20  then 'wait until 20 '
end







----------------------------------iif-------------------------------
--iif(condition , value if true , value if false)
declare @id int=10 , @age int

select @age = St_Age
from Student
where St_id = @id

select iif( @age>25 , 'you can apply' , 'you can not apply')






 
----------------------Batch, Script , Transaction--------------------
select * from Student
select * from Student where St_Id=1

--Script 

create rule r5 as @x>100
go
sp_bindrule r5 , 'instructor.Salary'

--Transaction
select 
update
delete 

Create table parent2 (pid int primary key)
Create table Child3 (cid int foreign key references parent2(pid))

insert into parent2 values(1)
insert into parent2 values(2)
insert into parent2 values(3)
insert into parent2 values(4)


begin transaction
insert into Child3 values(1)
insert into Child3 values(2)
insert into Child3 values(3)
insert into Child3 values(11)
rollback 
end

select * from Child3


 begin transaction
   insert into Child1 values(1)
   insert into Child1 values(2)
   insert into Child1 values(3)
   insert into Child1 values(11)
  commit






begin try
 begin transaction
   insert into Child3 values(1)
   insert into Child3 values(2)
   insert into Child3 values(3)
   insert into Child3 values(11)
  commit 
end try

begin catch
  select 'Erorr occures'
  rollback
end catch



select * from Child3

truncate table Child3


-------------------------Built in Functions-------------------------
select isnull(s.St_Fname , 'No Name')
from Student s

select St_Fname  from Student

select nullif(st_Fname,'Doaa')
from student

select Coalesce( s.St_Fname , s.St_lname , 'ffffff') 
from Student s
select st_Fname 
from Student
where LEN(St_Fname)=(select max(len( St_Fname))
from Student)

select power(Salary,3)
from Instructor

select top(1) St_Fname 
from Student
order by len(st_fname) desc

select upper(St_fname) , lower(St_Lname)
from student

select convert (varchar(20) , getdate() ,106 )

select format (getdate(), 'dd/MM-yy')


select DB_NAME() , SUSER_NAME()

----------------------------Custom Functions--------------------------------
--Notes
--1- Any function has retrun 
--2- we write select only inside it 


-------------------------------Scaler----------------------------
--Make a function that take student id and return name 
--string GetStudentName (int)

create function GetStudentName(@id int)
returns varchar(20)
  begin 

  declare @name varchar(100)
  select @name = St_Fname
  from Student
  where St_Id = @id

	return @name
  end 

select dbo.GetStudentName(3)
----------------------------------inline-------------------------------
--Return Table 
--We us it if function body selects only  

--Write a function that take department id and retrun
--Department instructors name and their anniual salary

create function GetinsInfo1( @did int)
returns table
as 
return 
(
select i.Salary *12 as annSalary
from Instructor i
where i.Dept_Id = @did
)


select * from GetinsInfo1(20)
-----------------------------------multi ------------------------------
--Return table 
--We us it if function body selects + if , while or any logic 

--Write function that take formate from user
--If format= 'first' select id and Fname 
--If format ='last' select id and Lname
--If format ='full' select id and Fname + Lname 
create function GetStudents1(@format varchar(10))
returns @t table (id int , ename varchar(30))
as
  begin 
  if @format ='first' 
  insert into @t select St_id , St_Fname From Student

  else if @format ='last' 
  insert into @t select St_id , St_Lname From Student

  else if @format ='full' 
  insert into @t select St_id ,St_Fname+' '+ St_Lname From Student
	 return 
  end


  select * from GetStudents1('first')

------------------------------Window Functions--------------------------
--write query that show first name and age for student 
--use ranking Functions to rank student From the highest to lowest age
--use rank , Dense_rank , Row_number , Ntile for testing 

select * , Ntile(3) over (order by st_age desc) as RN
from Student 








--Find Second aged Student in each department

select * from 

(
select * , Dense_rank() over (partition by Dept_id
                               order by st_age desc) as DN
from Student 
where Dept_Id is not null

) as newTable
where DN = 2








-----------------------------------CTE---------------------------------
--A Common Table Expression, also called as CTE in short form,
--is a temporary named result set that you can reference within 
--a SELECT, INSERT, UPDATE, or DELETE statement. The CTE can also 
--be used in a View.


-------------------------------CTE Synatx-------------------------------
--WITH expression_name AS (CTE definition)

with cte 
as 
(
 select st_fname ,st_age , St_Address
 from Student
)
select st_fname from cte 
where st_age>20




--Find Top 3 aged student in each each Department 





with cte 
as (
	  SELECT *, ROW_NUMBER() OVER(PARTITION BY dept_id ORDER BY st_age desc) AS rk
      FROM student
      ) 

select St_Fname , St_Age , rk
from cte 
where rk<=3

create table test
(
ID int ,
NAME VARCHAR(10),
AGE INT
)
go
INSERT INTO test values (1,'Doaa' , 24),
						(1,'Doaa' , 24),
						(2,'ali' , 25),
                        (2,'ali' , 25)

select t.ID , t.NAME , t.AGE
from test t


--Find Duplicate in Test table 
WITH cte 
AS (
    SELECT  t.ID , t.NAME , t.AGE ,
	        ROW_NUMBER() OVER (PARTITION BY t.ID , t.NAME , t.AGE
            ORDER BY t.ID , t.NAME , t.AGE) row_num
    FROM test t
) 
delete FROM cte 
WHERE row_num > 1;



select * from test
--Delete Duplicate in each row 




select * from test






