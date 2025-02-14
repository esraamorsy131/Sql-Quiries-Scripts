declare c1 cursor
for select st_id,st_fname
	from Student
	where st_address='cairo'
for read only       

declare @id int,@name varchar(10)
open c1
fetch c1 into @id,@name   --counter=1
while @@FETCH_STATUS=0
	begin
		select @id,@name
		fetch c1 into @id,@name  --counter++
	end
close c1
deallocate c1

------->
-->Array  --> one cell --->string  [ahmed,ali,amr,fady.....]
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

--->
declare c1 cursor
for select salary from  instructor
for update
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal>=3000
			update Instructor
				set salary=@sal*1.20
			where current of c1
		else if @sal<3000
			update Instructor
				set salary=@sal*1.10
			where current of c1
		else
			delete from Instructor
			where current of c1
	fetch c1 into @sal
	end
close c1
deallocate c1
--------------------------------------------

declare c1 cursor
for select st_fname from student
for update
declare @name1 varchar(20),@name2 varchar(20),@count int=0
open c1
fetch c1 into @name1
while @@FETCH_STATUS=0
	begin
	   fetch c1 into @name2
		if @name1='ahmed' and @name2='Amr'
			set @count+=1
	end
select @count
close c1
deallocate c1
-------------------------------------------
--types of tables
--Physical table
create table exam
(
 eid int,
 edec varchar(10),
 edate date
)



--variable table
declare @exam table
(
 eid int,
 edec varchar(10),
 edate date
)

--local tables
create table #exam
(
 eid int,
 edec varchar(10),
 edate date
)

--global tables
create table ##exam
(
 eid int,
 edec varchar(10),
 edate date
)



create view ITIstuds
as
	select * from student

--calling
select * from ITIstuds

alter view vcairo(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='cairo'

--calling
select * from vcairo

select sname from vcairo




alter schema HR transfer vcairo

select * from HR.vcairo

alter schema dbo transfer hr.vcairo

drop view vcairo

create view valex(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='alex'

select * from valex

create view vcairo_alex
as
	select * from valex
	union
	select * from vcairo

select * from vcairo_alex

--complex queries
alter view vjoin(sid,sname,did,dname)
with encryption
as
	select st_id,st_fname,d.dept_id,dept_name
	from Student S inner join Department d	
		on d.Dept_Id =s.Dept_Id

select * from vjoin

select sname,dname from vjoin

sp_helptext 'vjoin'

create view vgrades
as
	select sname,dname,grade 
	from vjoin v inner join Stud_Course sc
	on v.sid = sc.St_Id

select * from vgrades

--DML   Views
---->view    one table
alter view valex(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='alex'
with check option


insert into valex
values(98,'ahmed','alex')

insert into valex
values(999,'ahmed','mansoura')

select * from valex


---->view     multi tables
create view vjoin(sid,sname,did,dname)
as
	select st_id,st_fname,d.dept_id,dept_name
	from Student S inner join Department d	
		on d.Dept_Id =s.Dept_Id

--Delete XXXXXXXXX
--insert   update
insert into vjoin(sid,sname)
values(93,'ali')

insert into vjoin(did,dname)
values(800,'could')

update vjoin
	set sname='eman'
where sid=1

insert into vjoin
values(93,'ali',800,'could')

update vjoin
	set sname='eman',dname='HR'
where sid=1
--------------------------------------------------------------
--Merge
create table lastt
(
 Xid int,
 Xname varchar(20),
 Xval int
)

create table Dailyt
(
 Yid int,
 Yname varchar(20),
 Yval int
)

Merge into Lastt as T
using Dailyt     as S
On T.Xid = S.Yid

when Matched Then
	Update
		set T.Xval = S.Yval
When Not Matched Then
	Insert
	values(S.Yid, S.Yname , S.Yval) 
	
output $action;

-->cursor
-->types of tables
-->rollup  cub groupingSets pivot
-->view
-->merge
-->XML
-->types of backups

--->XML
-------------Data Transformation
--for XML  ====> query[data] ====>XML
--(raw    auto    explicit    path)

select * from Student
for xml raw('student'),elements,root('students')

--open XML ====> XML ============>data[table]
------------------------------------------------
--types of backups
--full backup
--differential backup
--transaction Log backup

.mdf
.ldf



























