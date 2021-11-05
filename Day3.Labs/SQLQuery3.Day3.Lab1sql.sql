-- 1.	Display the Department id, name and id and the name of its manager.
select d.Dnum, d.Dname, e.SSN ,e.Fname+ ' ' + e.Lname as Manager_Name
from Employee e, Departments d
where e.SSN = d.MGRSSN




--2.	Display the name of the departments and the name of the projects under its control.
select d.Dname, p.Pname
from Departments d, Project p
where d.Dnum = p.Dnum

--3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select de.*
from Dependent de left outer join Employee e
on e.SSN = de.ESSN

--4.	Display the Id, name and location of the projects in Cairo or Alex city.
select p.Pname, p.Plocation
from Project p
where p.City  in ('alex','cairo')

--5.	Display the Projects full data of the projects with a name starts with "a" letter.
select p.*
from Project p
where p.Pname like 'a%'


--6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select e.*
from Employee e
where e.Dno= 30 and e.Salary between 1000 and 2000


--7.	Retrieve the names of all employees in department 10 who works more than or equal 10 hours per week on "AL Rabwah" project.
select e.Fname, e.Lname
from Employee e, Works_for wf, Project p 
where e.Dno = 10 and e.SSN = wf.ESSn and wf.Hours >= 10 and p.Pname = 'AL Rabwah'

--8.	Find the names of the employees who directly supervised with Kamel Mohamed.
select emp.Fname+' ' + emp.Lname as Fullname
from Employee emp, Employee mang
where mang.SSN = emp.Superssn and mang.Fname = 'Kamel'


--9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select  e.Fname+' ' + e.Lname as Fullname , p.Pname
from Employee e, Project p, Works_for wf
where e.SSN = wf.ESSn and p.Pnumber = wf.Pno
order by p.Pname ASC


--10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
select p.Dnum, d.Dname,  e.Fname+' ' + e.Lname as Fullname, e.Address , e.Bdate
from Project p, Departments d, Employee e
where d.Dnum = p.Dnum and e.SSN = d.MGRSSN and p.City = 'cairo'

--11.	Display All Data of the managers      -----Question ------- Unlogic Result
select mang.*
from Employee emp, Employee mang
where mang.SSN = emp.Superssn





--12.	Display All Employees data and the data of their dependents even if they have no dependents
select e.*, de.*
from Employee e left outer join Dependent de
on e.SSN = de.ESSN


--DML

--1.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee(SSN, Fname, Lname, Dno,Superssn,salary)
Values (102672,'ahmed','mamdouh',30,112233,3000)


--2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
INSERT INTO Employee(SSN, Fname, Lname, Dno)
Values (102660,'Moataz','Mahmoud',30)

--3.	Upgrade your salary by 20 % of its last value.

update Employee 
set Salary = Salary + (Salary * .2)
where SSN = 102672



