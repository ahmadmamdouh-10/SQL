------------------------Clustered Index--------------------------








--Create clustered on Sal in table Student 

create table Emp
(
id int primary key,
ename varchar(10),
sal int)

create nonclustered index i1
on Emp(sal)

create nonclustered index i2
on Emp(ename)










-- PK -----Clustered 
-- unique ---unique non clustered 

create unique index i3
on Emp(ename)



------------------SQL sever profiler and tuning advisor---------------

select * from Student




-------------------------System Data bases---------------------------
--Master https://www.sqlshack.com/sql-server-system-databases-the-master-database/
--Model  https://www.sqlshack.com/sql-server-system-databases-model-database/
--Tempdb https://www.sqlshack.com/configuration-operations-restrictions-tempdb-sql-server-system-database/
--Msdb   https://www.sqlshack.com/sql-server-system-databases-msdb-database/


---------------------------------- indexed view  ------------------------------------------
--https://www.sqlshack.com/sql-server-indexed-views/
create view v2
with schemabinding 
as
 select St_Fname
 from dbo.Student
 where St_Address='Cairo'

 --------------------------Cursor----------------------------
 --Create cursor that view student info for alex student 
 declare c1 cursor 
 for
   select St_id , st_Fname 
   from Student
   where St_Address = 'alex'

   for read only 

declare @id int , @name varchar(10)

open c1

fetch c1 into @id , @name

while @@FETCH_STATUS=0
begin

select @id ,@name
fetch c1 into @id , @name

end 
close c1
deallocate c1 








-----------------------------------------------------
--Write cursor query that show student banes in one cell

--[ahmed , amr , mona,.............]

declare c1 cursor
for 
    select ST_Fname 
	from Student
	where St_Fname is not null

declare @fname varchar(10) , @allnames varchar(500)=''
open c1

fetch c1 into @fname
while @@FETCH_STATUS=0
begin
   

   set @allnames = @allnames + ' , ' + @fname
   fetch c1 into @fname
end
select @allnames
close c1
deallocate c1 














--Write a cursor that update instructors salary if salary >3000 
--increase it by 20%
--Else increase it by 10%
declare c1 cursor 
for
   select Salary
   from Employee
for update 

declare @sal int 

open c1
fetch c1 into @sal

while @@FETCH_STATUS=0
begin 
    if (@sal >300)
	   update Employee Set Salary= Salary *1.3
	   where current of c1 
     
	 else 
	    update Employee Set Salary= Salary *1.1
		where current of c1 

		fetch c1 into @sal
end

close c1
deallocate c1 

















 --Write cursor query that show student banes in one cell

--[ahmed , amr , mona,.............]


















-----------------------------Students Task----------------------------
--Count times that amr apper after ahmed in srudent table 
--ahmed then amr
Select * from student 
insert into student values (16 , 'Ahmed' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (17 , 'Amr' , 'Mohmaed' , 'Cairo' , 20 , 20 , NULL)
insert into student values (18 , 'Test' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)

insert into student values (18 , 'Ahmed' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (19 , 'Test' , 'Mohmaed' , 'Cairo' , 23 , 20 , NULL)
insert into student values (20 , 'Amr' , 'Mohmaed' , 'Cairo' , 20 , 20 , NULL)


declare c1 cursor 
for
   select St_Fname 
   from Student
   
for read only

declare @a varchar(20) ='', @Fanme varchar(20) , @c int =0

open c1
fetch c1 into @Fanme

while @@FETCH_STATUS=0
begin 
if (@Fanme ='ahmed')
     set @a = @Fanme

if( @a = 'ahmed' and @Fanme = 'Amr')
  begin 
     set @c +=1
	 set @a=''
  end	
  
 Fetch C1 into @Fanme   


end 
select @c

close c1
deallocate c1





declare c1 cursor 
for
   select St_Fname 
   from Student
 
   
for read only

declare  @fname varchar(10) , @flagH int=0 , @flagM int =1 , @c int =0 

open c1
fetch c1 into @fname

while @@FETCH_STATUS=0
begin 
if ( @fname='ahmed' and @flagM =1)
begin 
     set @flagH = 1
	  set @flagM = 0
end

if( @fname = 'amr' and @flagH =1 )

 begin 
	     set @c +=1
		 set @flagH =0 
		 set @flagM =0 
end 

fetch c1 into @fname
end

select @c

close c1
deallocate c1