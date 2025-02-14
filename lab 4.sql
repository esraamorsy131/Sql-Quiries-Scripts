select d.Dependent_name , d.Sex
from Employee e inner join Dependent d
on e.SSN = d.ESSN
where e.Sex = 'F' and d.Sex = 'f'

union 

select d.Dependent_name , d.Sex
from Employee e inner join Dependent d
on e.SSN = d.ESSN
where e.Sex = 'M' and d.Sex = 'M'



select p.Pname , SUM(Hours) as 'Total Hours per week'
from Project p inner join Works_for w 
on p.Pnumber = w.Pno 
group by p.Pname


select d.*  
from Departments d inner join Employee e
on d.Dnum = e.Dno 
WHERE ssn = (select MIN(SSN) from Employee)


 
select Dname , MAX(salary) as ' max sal' , MIN (salary) as ' min sal' , AVG(salary) as ' avg sal'
from Departments dept inner join Employee e
on dept.Dnum = e.Dno 
group by Dname

select concat(' ' , e.Fname , e.Lname) as ' Fullname'
from Departments dept inner join Employee e
on dept.MGRSSN = e.SSN 
where MGRSSN not in (select distinct ESSN from Dependent)


select  dept.Dname , dept.Dnum , COUNT(SSN) ' Count Of Employee' , AVG(salary) as 'Average Sal'
from Departments dept inner join Employee e
on dept.Dnum = e.Dno
group by dept.Dname , dept.Dnum
Having AVG(salary) < (select AVG(salary) from Employee)


select max(salary) from Employee
union
select max(salary) 
from Employee
where salary not in (select MAX(salary) from Employee)




SELECT distinct concat(' ' , e.Fname , e.Lname) as ' Fullname' , e.SSN 
FROM Employee e inner join Dependent d
on e.SSN = d.ESSN 
where exists ( select ESSN FROM Dependent)



select concat(' ' , e.Fname , e.Lname) as ' Fullname'
from Employee e inner join Dependent d
on e.SSN = d.ESSN 
where concat(' ' , e.Fname , e.Lname) in (select d.Dependent_name from Dependent)



insert into Departments values
('Dept IT' , 100 , 112233 , 11/01/2006 )

update Departments
set MGRSSN = 968574
where Dnum= 100
update Departments
set MGRSSN = 102672
where Dnum = 20
update Employee 
set Superssn = 102672
where SSN = 102660

delete from Dependent where ESSN = 223344
update Departments set MGRSSN = 102672 where MGRSSN = 223344
update Employee set Superssn = 102672  where Superssn = 223344
delete from Works_for  where ESSn = 223344
delete from Employee  where SSN = 223344


update Employee 
set Salary = Salary * 1.3 
where SSN in ( select SSN 
               from Employee e inner join Works_for w
			   on e.SSN = w.ESSn 
			   inner join Project p 
			   on p.Dnum = w.Pno
			   where p.Pname = 'AL Rabwah')

