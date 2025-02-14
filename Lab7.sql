
create function Months (@D Date)
returns varchar(20)
    begin 
	     declare @month varchar(20)
		 select @month = DATENAME(mm,@D)
		 return @month
	end

select dbo.months('05-20-1997')
select dbo.months(getdate())
--------------------------------------------------------------
alter function range (@x int , @y int)
returns @t table
        ( integer int)
as 
begin 
     declare @z int
	 set @z = @x+1
      while  @z < @y
         begin 
		   insert into @t values(@z)
		   set @z+=1
		  end 
      return
end  
select * from range(1,10)

 -------------------------------------------------------------------------
create function stdata (@stid  int )
returns table
as 
return 
(select CONCAT_WS(' ' , s.St_Fname , s.St_Lname) as 'Full name' , d.Dept_Name
                       from Student s inner join Department d
                             on s.Dept_Id = d.Dept_Id and s.St_Id = @stid
)


 select *  from dbo.stdata(10)
---------------------------------------------------------------------------------
 create function name (@stid  int)
 returns varchar(50)
      begin

	      declare @message varchar(50) 
		  select @message = 
		            case
					    when St_Fname is null and St_Lname is null then 'Fisrtname and lastname are null'
						when  St_Fname is null then 'Fisrtname  is null'
						when  St_Lname is null then 'lastname is null'
						else   ' fname is null and lname are not null  '
					end
					
           from Student
		   where St_Id = @stid		  
		   return @message

	  end

select dbo.name(5)
------------------------------------------------------------------------------------------

alter function Mgr(@mgrid int)
returns table
as
return
(select d.Dept_Name , i.Ins_Name , d.Manager_hiredate
from Instructor i inner join Department d 
on  i.Ins_Id = d.Dept_Manager and d.Dept_Manager =@mgrid
)

select*from dbo.Mgr(1)
---------------------------------------------------------------------------------------
create function getname(@format varchar(20))
returns @t table
           (name varchar(50)
		   )
                    
as
begin
  if @format = 'first name'
		insert into @t 
		select  isnull(st_fname , 'nodata')
		from student s
 else 
  if @format = ' Last name'
		 insert into @t 
		 select  isnull(st_lname , 'nodata')
		 from student s
 else 
  if @format = 'Full name'
		 insert into @t 
		 select  isnull(st_fname , 'nodata') +' ' + isnull(st_lname , 'nodata')
		from student s
 return
end

select * from getname('full name')
-----------------------------------------------------------------------------------------------

select s.St_Id , substring(s.St_Fname , 1 , len(st_fname)-1)
from student s

delete 
from Stud_Course 
where Grade IN  (select grade
from Stud_Course sc inner join Student s
on s.St_Id = sc.St_Id 
inner join Department d
on d.Dept_Id = s.St_Id and d.Dept_Name = 'SD')

---------------------------------------------------------------------------------------
-------BONUS-----


create table employee(
id int identity(1,1),
ename varchar(20),
egender varchar(10),
hid  hierarchyid
)


insert into employee values
( 'ahmed' , 'M' , hierarchyid::GetRoot()),
( 'SALMA' , 'F' , hierarchyid::GetRoot()),
( 'HESHAM' , 'M' , hierarchyid::GetRoot()),
( 'YOMNA', 'f' , hierarchyid::GetRoot())


select ename , egender , hid
from employee


--------------------------------------------------------------------


declare @x int 
  set @x = 3000
	while
	   @x <= 6000
	   begin
	     insert into student (St_Id , St_Fname , St_Lname) values (@x , 'JAN' , 'SMITH')
		 set @x+=1

	    
	   end 
