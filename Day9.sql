
create Proc getstuds
as
	select * from student

--calling
getstuds
execute getstuds
exec getstuds

alter Proc getstbyadd @city varchar(20)
with encryption
as
	select st_id,st_fname
	from Student
	where St_Address=@city

sp_helptext 'getstbyadd'

getstbyadd 'cairo'
getstbyadd 'alex'

alter schema hr transfer getsbyadd

hr.getstbyadd

alter schema dbo transfer hr.getsbyadd

drop proc getstbyadd

--DML   errors

alter Proc Deltopic @tid int
as
if not exists(select top_id from course where top_id=@tid)
	delete from topic where top_id=@tid
else
	select 'table has relationship'

Deltopic 2

--SP   Parameters    return values
alter Proc sumdata @x int=200 , @y int=100
as
	select @x+@y

sumdata 4,8  -->passing Parameters by Position
sumdata @y=9,@x=2 --->calling Parameters by name
sumdata 3
sumdata
-----------------------------------------------
--return SP
create Proc getstbyadd @city varchar(20)
as
	select st_id,st_fname
	from Student
	where St_Address=@city

--calling
declare @t table(x int, y varchar(20))
	insert into @t
	execute getstbyadd 'cairo'
select * from @t
select count(*) from @t

insert into person1
execute getstbyadd 'cairo'

----------------scalar function
alter Proc getdata @id int
as
	declare @age int
		select @age=st_age from Student
		where st_id=@id
	return @age

declare @x int
execute @x=getdata 3
select @x


alter Proc getdata @id int,@age int output,@name varchar(20) output
as
		select @age=st_age,@name=st_fname from Student
		where st_id=@id

declare @x int,@y varchar(20)
execute getdata 1,@x output,@y output
select @x,@y
--------------------------------------------------
alter Proc getdata @z int output,@name varchar(20) output
as
		select @z=st_age,@name=st_fname from Student
		where st_id=@z 

declare @x int=4,@y varchar(20)
execute getdata @x output,@y output
select @x,@y
-----------------------------------------------
--dynamic query
create Proc getvalues @col varchar(10),@t varchar(10)
as
	execute('select '+@col+' from '+@t)

getvalues 'salary','instructor'
-----------------------------------------------------------
--types of SP
---->built-in SP
sp_bindrule  sp_unbindefault  sp_helptext  sp_xml_preparedocumnet sp_addtype sp_helpconstraint
sp_who

---->user defined SP
sumdata  getstuds   getsbyadd

---->Trigger
-----Special type of SP
-----automatic call
-----can't call
-----can't take parameters
-----auto firing according actions
-----triggers table [insert   update  delete] log ok      [select truncate]  XXXX
--levels    server   db   schema  object

--triggers --tables

create trigger tr_1
on student
after insert
as
	select 'welcome to ITI'

insert into student(st_id,st_fname)
values(22,'ahmed')

create trigger tr_2
on student
for update
as
	select getdate(),suser_name(),db_name(),host_name()

update Student
	set st_age+=1

create trigger tr_3
on student
instead of delete
as
	select 'not allowed'

delete from Student where st_id=22

create trigger tr_4
on department
instead of insert , update , delete
as
	select 'not allowed for user= '+suser_name()

update Department
	set dept_name='cloud'
where Dept_Id=20

drop trigger tr_4

alter table department disable trigger tr_4
alter table department enable trigger tr_4

create trigger tr_5
on course
after update
as
	if update(crs_name)
		select 'welcome to ITI'

update course
	set Crs_Duration=100
where crs_id=200

----------------------------------------
create trigger tr7
on course
after update
as
	select * from inserted
	select * from deleted

update course
	set crs_name='html',crs_duration=80,top_id=4
where crs_id=100

update course
	set crs_name='node',crs_duration=100,top_id=1
where crs_id=200

create trigger tr_8
on course
instead of delete
as
	select 'not allowed to delete course name= '+(select crs_name from deleted)

delete from course where crs_id=1200
-------------------------------------------------------
create trigger tr_88
on student
instead of insert
as	
	if format(getdate(),'dddd')='friday'
		select 'not allowed'
	else
		insert into student
		select * from inserted

create trigger tr_88
on student
after insert
as	
	if format(getdate(),'dddd')='friday'
		begin
			select 'not allowed'
			delete from Student where st_id=(select st_id from inserted)
		end

---------------------------------------
create table history_audit
(
 _user varchar(100),
 _date  date,
 _oldid int,
 _newid int,
 _ActionNote varchar(100)
)

create trigger tr_10
on topic
instead of update
as
	if update(top_id)
		begin
			declare @old int,@new int
				select @old=top_id from deleted
				select @new=top_id from inserted
			insert into history_Audit
			values(suser_name(),getdate(),@old,@new,'update topic table')
		end

create database ITISnap1
on
(
 name='iti', --pointer mdf
 filename='g:\snap1.ss'
)
as snapshot of ITI  --db name

select * from Student

















