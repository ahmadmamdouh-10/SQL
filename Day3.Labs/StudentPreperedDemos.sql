-- Cross join 
-- select St_Fname and thier Dept_Name









--------------------------Inner join=Equi joins------------------------
--Find Student names and their Departments name
















--another way using microsoft syntax















--Find Student names and their Departments name and Dept_Id









--Find Students Name and department info










--Find Students name and thier Dept_Name who live in cairo







--Find Student names and thier department even they have 
--department or not 








--Find student names and department names even department
--has students or not







--Find Student name and their leaders name








----Find Student name and their leaders Information









--Find Student names and their courses and course grades










--Find Student names and Department name 
--and their courses and course grades













--Find Student names and Department name 
--and their courses and course grades










----------------------------Joins with DML----------------------------
--Joins with Update
--Increase grade 10 marks for cairo students
select * from Student
select * from Course
select * from Stud_Course








--Joins with Insert

--Write query that insert student Id , Std_Name , Grade in 
--Top student table For top student 
create table TopStudent
(
Id int ,
Std_Name varchar(20),
Grade int
)




-------------------------Joins + Delete(self Study)---------------
