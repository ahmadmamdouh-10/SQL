
        ---------------------------------- DQL ------------------------------------

-- 1.	Display (Using Union Function)
--a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.

select de.Dependent_name, de.Sex
from Dependent de 
where de.Sex = 'F'
union all 
select e.Fname+' ' + e.Lname, e.Sex
from Employee e
where e.Sex = 'F'



-- b.	 And the male dependence that depends on Male Employee.
select de.Dependent_name, de.Sex
from Dependent de 
where de.Sex = 'M'
union all 
select e.Fname+' ' + e.Lname, e.Sex
from Employee e
where e.Sex = 'M'


--2.	For each project, list the project name and the total hours per week 
--(for all employees) spent on that project.

select SUM((wf.Hours/4)) as weeklyHours, p.Pname
from Project p, Works_for wf
where p.Pnumber = wf.Pno
group by p.Pname



--3.	Display the data of the department which has the smallest employee ID 
--      over all employees' ID.  ///Question: 

 
select top(1)e.SSN
from Employee e
group by e.SSN



--4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

select MAX(e.Salary)as maxSalary,MIN(e.Salary) as minSalary,AVG(e.Salary) as avgSalary, d.Dname
from Employee e, Departments d
where d.Dnum = e.Dno 
group by d.Dname



--5.	List the last name of all managers who have no dependents.
select mang.Lname
from Employee e , Employee mang
where mang.SSN = e.SSN 
except
select e.Lname
from Employee e , Dependent de
where e.SSN = de.ESSN 




--6 For each department-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees.

select AVG(e.Salary) as avgSalary, e.Dno , COUNT(e.SSN) as numberOfEmployee
from Departments d, Employee e
group by e.Dno



--7.	Retrieve a list of employees and the projects they are working
--on ordered by department and within each department,
--ordered alphabetically by last name, first name.

select  e.*, p.*
from Employee e, Works_for wf, Project p
where e.SSN = wf.ESSn and p.Pnumber=wf.Pno
order by e.Dno, e.Fname,e.Lname


--8.	Try to get the max 2 salaries using subquery
 select top(2) e.Salary
 from Employee e
 order by e.Salary desc




--9.	Get the full name of employees that is similar to any dependent name

select e.Fname
from Employee e 
intersect 
select de.Dependent_name
from Dependent de




--10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 

update Employee 
set Salary = Salary + (Salary * .3)
from Employee e, Project p , Works_for wf
where e.SSN = wf.ESSn and p.Pnumber=wf.Pno and p.Pname = 'Al Rabwah'


--11.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.
select e.SSN, e.Fname
from Employee e
where exists 
(
select e.SSN, e.Fname
from Employee e, Dependent de
where e.SSN = de.ESSN
)


---------------------------------------------- DML ------------------------------------------

--1.	In the department table insert new department called "DEPT IT" ,
--with id 100, employee with SSN = 112233 as a manager for this department. 
--The start date for this manager is '1-11-2006'

insert into Departments (Dnum, Dname, MGRSSN,[MGRStart Date])
values (100, 'DEPT IT', 112233, 1-11-2006)






--2.	Do what is required if you know that :
--Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100),
--and they give you(your SSN =102672) her position (Dept. 20 manager) 


--a.	First try to update her record in the department table
update Departments 
set MGRSSN = 968574
where Dnum = 100




--b.	Update your record to be department 20 manager.

update Departments 
set MGRSSN = 102672
where Dnum = 20



--c.	Update the data of employee number=102660 to be in your teamwork 
--(he will be supervised by you) (your SSN =102672)
update Employee 
set Superssn = 102672
where SSN=102660




--3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
--so try to delete his data from your database in case you know
-- that you will be temporarily in his position.
-- Hint: (Check if Mr. Kamel has dependents,
-- works as a department manager,
--supervises any employees or works in any projects and handle these cases).

-- ******** it has dependent and he is a manager of a department so i changed the rule of 
-- delete to set the child as default  ***********

delete from Employee where SSN=223344