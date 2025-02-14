 create table department (
DeptNo  int primary key,
DeptName varchar(50) ,
location varchar(10)
)

insert into department  values
(1 , 'Research' , 'NY'),
(2 , 'Accounting' , 'DS'),
(3 , 'Marketing' , 'kw')



sp_addtype locc , 'nchar(2)'

create default def1 as 'NY'

create rule r2 as @x in ('NY' , 'DS' , 'KW')

sp_bindrule r2, locc

sp_bindefault def1 , locc

sp_bindrule r2, 'department.location'

--------------------------------------------------------


create table employee(
Emp_no int primary key,
Emp_fname varchar(50) not null,
Emp_lname varchar(50) not null,
Dept_no int ,
salary bigint unique
constraint c1 foreign key (Dept_no) references department(DeptNo)
)

insert into employee values
(25348  , 'Mathew' , 'Smith' , 3 , 2500),
(10102 , 'Ann' ,'Jones' , 3 , 3000),
(18316 , 'john' , 'Barrimore' , 1 , 2400)

create rule Rs as @x < 6000

sp_bindrule Rs , 'employee.salary'


insert into project2 values
(1  , 'Apollo'  , 120000),
(2 , 'Gemini'  ,  95000),
(3 , 'Mercury' , 185600)


insert into work_on2  (EMP_NO , PROJ_NO , JOB )
values
(10102  , 1 , 'Analyst'),
(10102  , 3  ,'Manager'),
(25348  , 2 , 'clerk' )


INSERT INTO WORK_ON2 (EMP_NO)
VALUES (11111)

update work_on2
set emp_no = 11111
where emp_no = 10102

update employee
set emp_no = 11111
where emp_no = 10102

delete from employee
where Emp_no = 10102

alter table employee 
add  telephone_number bigint 

alter table employee
drop column telephone_number


create schema company

create schema HR

Alter schema company transfer department

Alter schema HR transfer employee

create synonym emp
for hr.employee

select * from employee
select * from emp
select * from humanresources.employee
select * from humanresources.employee

update project2 p inner join work_on2 w
       on p.project_no = w.proj_no
set budget = budget *1.1
where emp_no = 10102

update project2 
set budget = budget*1.1
from project2
 inner join WORK_ON2 
       on  project_no = proj_no
where emp_no = 10102 and job = ' manager'


update company.department  
set deptname = 'sales'
from company.department 
inner join emp
on deptno = dept_no
where emp.Emp_fname = 'john' 

update WORK_ON2
set ENTER_DATE = '12-12-2007'
from WORK_ON2
inner join emp
on WORK_ON2.EMP_NO = emp.Emp_no
inner join company.department 
on emp.Dept_no = company.department.DeptNo
where company.department.location = 'kw'
------------------------------------------------------------------------


create  nonclustered index i on department(manager_hiredate)

create unique index i2 on student(st_age)

