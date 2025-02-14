   select count(st_age)
from Student

select distinct Ins_Name
from Instructor





select St_Id , ISNULL (st_fname + ' ' + st_lname , ' ') as ' Fullname ', ISNULL (Dept_Name , ' ' ) as ' Dept name'
from Student  s inner join department d
on s.Dept_Id = d.Dept_Id







select i.Ins_Name , d.Dept_Name 
from Department d right outer join Instructor i 
on d.Dept_Id = i.Dept_Id 


select iSNULL (st_fname + ' ' + st_lname , ' ') as ' Fullname ' , c.Crs_Name 
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id   inner join Course c 
on sc.Crs_Id = c.Crs_Id 
where sc.Grade is not null 
order by s.St_Id

select  t.Top_Name , COUNT(crs_id) as 'NO OF Courses'
from  Topic t inner join Course c
on t.Top_Id = c.Top_Id
group by t.Top_Name

select MAX(salary) as 'Inst Max Sal' , MIN(salary) as 'Inst Max Sal'
from Instructor 


select Ins_Name , Salary
from Instructor
where salary < (select AVG(salary) from Instructor)

select d.Dept_Name , MIN(salary) as 'Salary'
from Department d inner join Instructor i
on d.Dept_Id = i.Dept_Id
group by d.Dept_Name 
Having min(Salary) = (select MIN(salary) from Instructor)


select top(2) salary
from Instructor

select Ins_Name , coalesce(convert (varchar(10),salary) , 'bonus')
from Instructor

select AVG(salary)
from Instructor  


select x.St_Fname , y.St_Id as 'Supervisor Id' ,(y.St_Fname +' ' + y.St_Lname) as 'Supervisor Name' , Y.St_Address as 'Supervisor Address' , Y.St_Age as' Supervisor Age' ,
y.Dept_Id as 'Supervisor Dept Id' 
from Student x , student y
where y.St_Id = x.St_super

select *
from (select Dept_Name , Salary, dense_rank() over (partition by d.dept_name order by salary desc) as DN
      from Department d inner join  Instructor i
		          on d.Dept_Id = i.Dept_Id) as Tab1
where DN = 1 or DN = 2



select *
from (select st_id , st_fname , Dept_Id ,ROW_NUMBER() over (partition by dept_id order by st_id asc) as RN
        From student ) as newtable
where RN = 1

---------------------------------------------------------------------------------------------------------------------

select sales.SalesOrderHeader.SalesOrderID , sales.SalesOrderHeader.ShipDate
from sales.SalesOrderHeader 
where Sales.SalesOrderHeader.OrderDate between '7-28-2002' and '7-29-2014'

select Production.Product.Name , Production.Product.ProductID
from Production.Product
where Production.Product.StandardCost < 110.00

select Production.product.ProductID , Production.product.Name
from Production.Product
where Production.product.Weight is Null

select Production.Product.Name , Production.Product.ProductID
from Production.Product
where Production.Product.Color = 'silver' or Production.Product.Color = 'red' or Production.Product.Color = 'black'

select Production.Product.Name , Production.Product.ProductID
from Production.Product
where Production.Product.Name like 'a%'

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select Production.ProductDescription.Description
from Production.ProductDescription
where Production.ProductDescription.Description like '%_%'


select SUM(sales.SalesOrderHeader.TotalDue) , sales.SalesOrderHeader.OrderDate
from sales.SalesOrderHeader 
where sales.SalesOrderHeader.OrderDate between '7-1-2001' and '7-31-2014'
group by sales.SalesOrderHeader.OrderDate


select distinct HumanResources.Employee.HireDate
from HumanResources.Employee

select distinct avg(Production.Product.ListPrice) as 'Avg List Price'
from Production.Product

select CONCAT_WS (' ' , 'the' , Production.Product.Name  , 'is only!', Production.Product.ListPrice) as 'product price'
from Production.Product
where Production.Product.ListPrice between 100 and 120
order by Production.Product.ListPrice asc


insert into store_Archive
select sales.Store.rowguid , Sales.Store.SalesPersonID , Sales.Store.Demographics
from sales.Store


insert into storearchive
select sales.Store.rowguid , Sales.Store.SalesPersonID , Sales.Store.Demographics
from sales.Store
where 1 = 2


select format(getdate() , 'dd-MM-yyy')
union 
select convert(varchar(20) , getdate())















select St_Id , ISNULL (st_fname + ' ' + st_lname , ' ') as ' Fullname ', ISNULL (Dept_Name , ' ' ) as ' Dept name'
from Student  s inner join department d
on s.Dept_Id = d.Dept_Id

select *
from (select st_id , st_fname , Dept_Id ,ROW_NUMBER() over (partition by dept_id order by newid() asc) as RN
        From student ) as newtable



UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select Production.ProductDescription.Description
from Production.ProductDescription
where Production.ProductDescription.Description like '%[_]%'

select  avg (distinct Production.Product.ListPrice) as 'Avg List Price'
from Production.Product


select CONCAT_WS (' ' , 'the' , Production.Product.Name  , 'is only!', Production.Product.ListPrice) as 'product price'
from Production.Product
where Production.Product.ListPrice between 100 and 120
order by Production.Product.ListPrice asc

insert into storearchive
select sales.Store.rowguid , Sales.Store.SalesPersonID , Sales.Store.Demographics
from sales.Store
where 1 = 2