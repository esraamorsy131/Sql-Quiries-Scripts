SELECT Dnum , Dname , CONCAT_WS (' ' , e.Fname , e.Lname) Fullname
from employee e , Departments d 
where e.SSN = d.MGRSSN 


select  Dname , Pname
from Departments d inner join Project p
on d.Dnum = p.Dnum 

select CONCAT_WS (' ' , e.Fname , e.Lname) as 'Full Name' , de.*
from Employee e right outer join Dependent de
on e.SSN = de.ESSN

SELECT Pname , Pnumber, Plocation 
FROM Project
WHERE CITY in ('CAIRO' , 'ALEX')

select *
from Project
where Pname like'a%'

select CONCAT_WS (' ' , e.Fname , e.Lname) as 'Full Name'
from employee e inner join  Departments d 
on e.Dno = d.Dnum 
where d.Dnum = 30 and e.Salary  between 1000 and 2000

select CONCAT_WS (' ' , e.Fname , e.Lname) as 'Full Name'
from employee e inner join Works_for w
on e.SSN = w.ESSn and e.Dno = 10 
inner join Project p
on p.Pnumber = w.Pno
where w.Hours >= 10 and p.Pname = 'AL Rabwah'

select CONCAT_WS (' ' , x.Fname , x.Lname) as 'Full Name'
from employee x inner join employee y 
on   y.SSN= x.Superssn
and  y.SSN= 223344 

select  CONCAT_WS (' ' , e.Fname , e.Lname) as 'Full Name' , p.Pname
from employee e , Works_for w  , project p
where e.SSN = w.ESSn and w.Pno = p.Pnumber 
order by p.Pname

select p.Pname , p.Pnumber , d.Dname , e.Address , e.Bdate
from Employee e inner join Departments d 
on  e.SSN = d.MGRSSN 
inner join Project p 
on d.Dnum = p.Dnum 
where city = 'cairo'


select e.Fname , e.Lname , e.Address , e.Bdate , e.Salary , e.Sex, d.[MGRStart Date]
from employee e , Departments d 
where e.SSN = d.MGRSSN 

select e.* , dep.*
from Employee e left outer join  Dependent dep 
on e.SSN = dep.ESSN  

insert into Employee values 
('esraa' , 'morsy' , 102672 , 1997-08-23 , '261waadimeloukst' , 'F' ,30000 , 112233 , 30)

insert into Employee (Fname , Lname , SSN ,Bdate ,  Address , Sex , Dno)
values 
('ahmed' , 'mohamed' , 102660 , 1997-08-23 , '221waadimeloukst' , 'M' , 30)


update Employee
set Salary = Salary*1.2
where SSN = 102672 

