----------------------------------Note: Use ITI DB-------------------------------------------
use ITI

-- function cannot call stored procedures.
-- 

--1. Create a scalar function that takes a date and 
--returns the Month name of that date. test (‘1/12/2009’)

alter function GetMonthName(@date date)
returns varchar(20)
  begin 

  declare @monthName varchar(20)
  select @monthName = (select format (@date, 'MMM'))

	return @monthName
  end 

  select dbo.GetMonthName('2009-12-1')

 
--2. Create a multi-statements table-valued function 
--   that takes 2 integers and returns 
--   the values between them.

create function numberbetween(@n1 int , @n2 int)
	returns @t table (n int)
	as
  begin 
  declare @c int = @n1 + 1
	  while (@c<@n2)
		begin
		insert into @t values (@c)
		set @c+=1
		end
		 return  
  end
 select * from numberbetween(1,50) 

--3. Create a tabled valued function that takes Student No
--   and returns Department Name 
--   with Student full name.

create function StdDept(@id int)
	returns @t table (dept_name varchar(20) , fullname varchar(50) )
	as
  begin 
	insert into @t
	select d.Dept_Name ,s.St_Fname + ' ' + s.St_Lname
	from Student s , Department d
	where d.Dept_Id = s.Dept_Id and s.St_Id = @id 
		 
		 return 
  end

select * from StdDept(2)


--4. Create a scalar function that takes Student ID 
--   and returns a message to the user 
--   (use Case statement)

--a.  If the first name and Last name are null then display 'First name & last name are null'
--b.  If the First name is null then display 'first name is null'
--c.  If the Last name is null then display 'last name is null'
--d.  Else display 'First name & last name are not null'

create function stdID(@id int)
returns varchar(50)

begin
declare @fn varchar(20)
declare @ln varchar(20)
declare @res varchar(50)

select @fn = St_Fname , @ln = St_Lname
from Student
where St_Id = @id
set @res =case
	when @fn is null and @ln is null then 'First name & last name are null'
	when @ln is null then 'last name is null'
	when @fn is not null and @ln is not null  then 'First name & last name are not null'
	end
	return @res
end

select dbo.stdID(15)


--5.Create a function that takes an integer that represents the format of the 
--  Manager hiring date and displays department name, Manager Name, and hiring date with 
--  this format. 

create function displayformat(@id int , @format varchar(30))
returns @t table (Department_Name varchar(20) ,Manager_Name varchar(20), hDate date)

begin 
	insert into @t
	select d.Dept_Name ,i.Ins_Name ,FORMAT( d.Manager_hiredate,@format )
	from  Department d , Instructor i
	where d.Dept_Manager = i.Ins_Id and i.Ins_Id = @id 
		 
		 return 
end

   select * from displayformat(1,'dd/MM/yy') 


--6. Create multi-statements table-valued function that takes a string
--   If string='first name' returns student first name
--   If string='last name' returns student last name 
--   If string='full name' returns Full Name from student table 

--Note: Use the “ISNULL” function

alter function getStdName(@str varchar(10))
returns @t table ( Student_Name varchar(30))
as
  begin 
  if @str ='first name' 
  insert into @t select isnull(St_Fname , 'No Name') From Student 

  else if @str ='last name' 
  insert into @t select isnull(St_Lname , 'No Name') From Student

  else if @str ='full name' 
  insert into @t select isnull(St_Fname +' '+ St_Lname , 'No Name') From Student
	 return 
  end


  select * from getStdName('full name')



--7. Write a query that returns the Student No and Student first name 
--   without the last char

select St_Id , SUBSTRING( St_Fname, 1, LEN(St_Fname)-1) AS Fname from Student 



--8. Write a query that takes the columns list and table name 
--   into variables and then return
--   the result of this query “Use exec command”

declare @tname varchar(20) = 'Student'
declare @tc1 varchar(20) = 'St_Id'
declare @tc2 varchar(20) = 'St_Fname'
declare @tc3 varchar(20) = 'St_Lname'
execute( 'select '+@tc1+' ,'+@tc2+', '+@tc3+'  from ' +@tname)


--9- Find Second highest total grade student  for each department 

-------------- Ask for Explanation on Dense_rank() and partition by -----------------
------------------------**********************************-------------

select * from 
(
select sum(sc.Grade), 
Dense_rank() over 
(partition by s.Dept_id 
 order by sc.Grade desc) as DN
 from Student s ,Stud_Course sc
 where Dept_Id is not null and s.St_Id=sc.St_Id 
 group by s.St_Id
 ) as newTable
where DN = 2

--Part 2: Use Company DB

--1. Create a function that takes project number
--   and display all employees in this project
	
	create function displayEmployees(@pNum int)
	returns @t table (FullName varchar(50) ,pname  varchar(50))
	begin
	insert into @t
	select e.Fname+' '+e.Lname as FullName ,w.Pno
	from Employee e ,Works_for w 
	where e.SSN=w.ESSn and Pno=@pNum
	return
	end

	select * from displayEmployees(400)
