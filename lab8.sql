-----Q1-------------------------------------
create view v_stud
as
   select CONCAT_WS('' ,s.St_Fname , s.St_Lname) as 'Full Name' , c.Crs_Name
    from student s inner join Stud_Course sc 
     on s.St_Id = sc.St_Id and sc.Grade =60
     inner join Course c
      on c.Crs_Id =sc.Crs_Id

-----Q2--------------------------------------------
use iti;
Alter view v_managers
with encryption 
as 
    select i.Ins_Name , t.Top_Name, c.Crs_Name 
	from Department d inner join Instructor i
	on i.Ins_Id = d.Dept_Manager
	inner join Ins_Course ic
	on ic.Ins_Id = i.Ins_Id
	inner join Course c
	on ic.Crs_Id = c.Crs_Id
	inner join topic t
	on t.Top_Id = c.Top_Id
------------Q3--------------------
create view v_dept_ins
as 
    select d.Dept_Name , i.Ins_Name
	from Department d inner join Instructor i
	on d.Dept_Id =i.Dept_Id
	where d.Dept_Name in ('SD' , 'Java')

-------------------Q4------------------
create view v1
as 
    select *
	from Student
	where St_Address in ('alex' , 'cairo')
with check option

update v1 
set St_Address = 'Tanta'
where st_address = 'alex'
-------------Q5---------------
USE SD;
create view v2 
as 
   select p.project_name , count(e.Emp_no) as 'No of employee'
   from project2 p inner join WORK_ON2 w
   on p.project_no = w.PROJ_NO
   inner join hr.employee e
   on w.EMP_NO = e.Emp_no
   group by p.project_name

------------------Q6--------------------------
create table DT (user_id int , Daily_Transactions int)
create table LT (user_id int , Last_Transactions int)

merge into DT AS T
USING LT AS S
on T.user_id = S.user_id
WHEN matched then
     update 
	 set T.Daily_Transactions = S.Last_Transactions
WHEN not matched then
     insert
	 values(S.user_id , S.Last_Transactions);
----------------------Q7--------------------------------
USE Company_SD;
declare c2 cursor
for select salary from  Employee
for update
declare @sal int
open c2
fetch c2 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal < 3000
			update Employee
				set salary=@sal*1.10
			where current of c2
		else if @sal>=3000
			update Employee
				set salary=@sal*1.20
			where current of c2
		
	fetch c2 into @sal
	end
close c2
deallocate c2
----------------------Q8----------------------
USE ITI;
declare c1 cursor
for select d.Dept_Name , i.Ins_Name AS 'MGRname'
    from Department d inner join Instructor i 
	on d.Dept_Manager = i.Ins_Id
for read only

declare @Dname varchar(10),@MGRname varchar(10)
open c1
fetch c1 into @Dname,@MGRname   
while @@FETCH_STATUS=0
	begin
		select @Dname,@MGRname
		fetch c1 into @Dname,@MGRname  
	end
close c1
deallocate c1

---------------------Q9-------------------------
declare c1 cursor
for select distinct st_fname from Student
	where st_fname is not null
for read only

declare @name varchar(20),@all_names varchar(300)=''
open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		set @all_names=concat(@all_names,' , ',@name) 
		fetch c1 into @name
	end
select @all_names
close c1
deallocate c1

----------------Q10------------------------------------
backup database SD
to disk='D:\Esraa'
-----------------Q13------------------------------
Create SEQUENCE MySequence
START WITH 1
INCREMENT BY 1
MinValue 1
MaxValue 5
NO CYCLE;

create TABLE TAB1
(ID int,
FullName nvarchar(100) NOT NULL);

create TABLE TAB2
(ID int,
FullName nvarchar(100) NOT NULL);

INSERT into TAB1
VALUES (NEXT VALUE FOR MySequence, 'ESRAA')

INSERT into TAB2
VALUES (NEXT VALUE FOR MySequence, 'ESRAA')

select * from TAB1
select * from TAB2

select name,minimum_value,maximum_value,current_value,is_cycling
from sys.sequences
where name='Mysequence'
------------------Q14----------------------------------------
USE Adventureworks2012;

select*
from HumanResources.Employee
for xml raw('Employee')


select*
from HumanResources.Employee
for xml raw('Employee'),elements

------------------Q15----------------------------------------
use ITI;
select d.Dept_Name , i.Ins_Name
from Department d inner join Instructor i
on d.Dept_Id = i.Dept_Id

for xml auto,elements


select d.Dept_Name "@Dname" , 
        i.Ins_Name  "Instructor/ins_name"

from Department d inner join Instructor i
on d.Dept_Id = i.Dept_Id

for xml path('Department'),root('Departments')

------------------Q16----------------------------------------
use Company_SD;

create table customers(
FirstName varchar(20),
Zipcode int ,
OrderId int,
Item_ordered varchar(20)
)


declare @docs xml ='<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'

declare @handler int
Exec sp_xml_preparedocument @handler output , @docs

Insert into customers
select *
from openxml(@handler , '//customer')
with(FirstName varchar(20)'@FirstName',
     Zipcode int '@Zipcode',
     OrderId int 'order/@ID',
     Item_ordered varchar(20) 'order'
	 )
Exec sp_xml_removedocument @handler

-------------------------------------------------------------
Part2

-----------------Q1---------------
use SD;
create view v_clerk
as 
   select E.Emp_no , P.project_no, W.ENTER_DATE
   from hr.employee e inner join work_on2 W
   ON E.Emp_no = W.EMP_NO AND JOB ='CLERK'
   INNER JOIN project2 P
   ON P.project_no = W.PROJ_NO

---------------Q2----------------------------
create view v_without_budget
as 
   select *
   from project2
   where budget is NULL

-----------------Q3-----------------------------
create view v_count
as 
   select p.project_name , count(job) as 'No of jobs'
   from project2 p inner join WORK_ON2 w
   on p.project_no = w.PROJ_NO
   group by p.project_name

-------------------Q4------------------------------
create view v_project_p2
as
   select Emp_no 
   from v_clerk
   where project_no = 2
------------------------Q5-------------------------
Alter view v_without_budget
as 
    select *
	from project2
	where project_no in (1,2)

-----------------Q6----------------------------------
drop view v_clerk
drop view v_count
---------------------Q7-------------------------------
create view v_dpt2
as 
    select e.Emp_no , e.Emp_lname
	from hr.employee e 
	where e.Dept_no =2

--------------------Q8---------------------------
select emp_lname
from v_dpt2
where Emp_lname like '%j%'

---------------------Q9--------------------------

create view v_dept2
as 
    select d.DeptNo , d.DeptName
	from company.department d 

---------------------Q10----------------------------
insert into v_dept2 (DeptNo , DeptName)
values(4 , 'development')

-----------------------Q11-------------------------
create view v_2006_check
as
  select e.Emp_no , p.project_no , w.ENTER_DATE
  from hr.employee e inner join WORK_ON2 w
  on e.Emp_no = w.EMP_NO and  
  ENTER_DATE between '2006/1/1' and '2006/12/31'
  inner join project2 p
  on p.project_no = w.PROJ_NO 

