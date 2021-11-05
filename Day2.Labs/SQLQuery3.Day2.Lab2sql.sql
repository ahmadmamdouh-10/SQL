-- 1.	Display the Department id, name and id and the name of its manager.
select d.Dnum, d.Dname, d.MGRSSN as ManagerName, e.Fname
from Departments d, Employee e
where e.SSN = d.MGRSSN

--2.	Display the name of the departments and the name of the projects under its control.
select d.Dname, p.Pname
from Departments d, Project p 
where d.Dnum = p.Dnum

--3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select e.Fname, de.Dependent_name
from Dependent de right outer join Employee e
on e.SSN= de.ESSN

--4.	Display the Id, name and location of the projects in Cairo or Alex city.
select p.Pnumber, p.Pname, p.Plocation
from Project p 
where p.City='Cairo' or p.City='Alex'

--5.	Display the Projects full data of the projects with a name starts with "a" letter.
select p.*
from Project p
where p.Pname like 'a%'


--6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select e.Fname+' ' + e.Lname as Name , e.Salary
from Employee e, Departments d
where e.Salary >=1000 and e.Salary <=2000


--7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select e.Fname, d.Dnum, w.Hours, p.Pname
from Employee e, Departments d, Project p, Works_for w
where d.Dnum = e.Dno and 
p.Pnumber = w.Pno and ---***************
d.Dnum = 10 and 
w.Hours>=10 and
p.Pname='AL Rawdah'

--8.	Find the names of the employees who directly supervised with Kamel Mohamed.
select e.Fname+' ' + e.Lname
from Employee e, Employee m
where e.SSN =m.Superssn and m.Fname='Kamel'

--9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select e.Fname+' ' +e.Lname as Name, p.Pname
from Employee e, Project p, Works_for w
where e.SSN=w.ESSn and p.Pnumber = w.Pno
order by p.Pname

--10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
select p.Pnumber, d.Dname, e.Lname, e.Address, e.Address
from Project p right outer join Departments d, Employee e
where d.MGRSSN = e.SSN and p.Plocation = 'Cairo'

--11.	Display All Data of the mangers
select m.*
from Employee e, Employee m
where m.SSN=e.Superssn


--12.	Display All Employees data and the data of their dependents even if they have no dependents
select e.* , de.* 
from Employee e full outer join Dependent de
on e.SSN=de.ESSN


--DML

--1.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee(SSN, Fname, Lname, Dno,Superssn,salary)
Values (102672,'ahmed','mamdouh',30,112233,3000)


--2.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
INSERT INTO Employee(SSN, Fname, Lname, Dno)
Values (102660,'Moataz','Mahmoud',30)

--3.	Upgrade your salary by 20 % of its last value.
UPDATE Employee
SET Salary = 3000 + 600
WHERE SSN = 102672




