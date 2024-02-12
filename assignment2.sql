create database payroll_db;
Go

use payroll_db;
create table employee 
(emp_id int Primary key,
First_Name varchar(100) not null,
Last_Name varchar(100) not null,
D_o_b datetime not null,
Address varchar(300) not null,
contact_num char(10),
Email char(10),
HireDate date,
DesignationId int not null,
Departmentid int not null);

alter table employee alter column D_o_b date not null;
alter table employee alter column Email varchar(100) not null;
select * from sys.tables;
select * from employee;

insert into employee values
(12,'Rahul','Sharma','1995-12-22','Mumbai','1123364567','rahul@gmail.com','2021-02-21',1,1),
(2,'Rohit','Sharma','1995-12-22','Mumbai','1651613131','rohit@gmail.com','2021-02-21',2,3),
(3,'Virat','Kohli','1995-12-22','Mumbai','1123364567','rahul@gmail.com','2021-12-21',4,2),
(4,'Dhoni','Singh','1991-12-22','Ranchi','5165165164','dhoni@gmail.com','2021-01-21',4,5),
(6,'Rahul','Sharma','1995-12-22','Mumbai','1123364567','rahul@gmail.com','2021-10-21',1,1),
(7,'Rohit','Sharma','1995-12-22','Kolkata','1651613131','rohit@gmail.com','2021-05-21',2,3),
(8,'Virat','Kohli','1995-12-22','Delhi','1123364567','rahul@gmail.com','2021-04-21',4,2),
(9,'Dhoni','Singh','1991-12-22','Ranchi','5165165164','dhoni@gmail.com','2021-02-21',3,1);

create table Designation
(DesignationId int primary key,
Desiganiton_name varchar(100) not null);


alter table employee add constraint Fk_designation foreign key (designationId) references Designation(DesignationId);

create table department
(Department_id int Primary key,
Department_name varchar(100) not null,
Manager_id int);

alter table employee add constraint Fk_departmentId foreign key (Departmentid) references department(Department_id);

alter table department add constraint Fk_Manager foreign key (Manager_id) references employee(emp_id);

create table salary
(salary_id int primary key,
Employee_id int Constraint Fk_employee foreign key references Employee(emp_id),
Payroll_id int not null,
basic_sal decimal(12,2) not null,
allowances decimal(12,2) not null,
deductions decimal(12,2) not null,
net_salary decimal(12,2) not null);

create table pay_roll
(payroll_id int primary key,
start_date date not null,
end_date date not null);


alter table salary add constraint fk_payroll foreign key (payroll_id) references pay_roll(payroll_id);


create table attendence 
(Attendence_id int primary key,
Emp_id int Constraint Fk_Employee_Attendence foreign key references employee(emp_id),
Attendence_date date not null,
Clock_in time not null,
Clock_out time not null);

create table leaves
(leave_id int primary key,
Emp_id int Constraint Fk_Employee_leave foreign key references employee(emp_id),
leave_type varchar(100) not null,
start_date date not null,
end_date date not null);

create table training
(training_id int primary key,
training_name varchar(200) not null,
Description varchar(1000) not null,
Trainer varchar(100) not null,
start_date date not null,
end_date date not null);

alter table training add employee_id int constraint fk_employee_t foreign key references employee(emp_id); 
alter table department alter column manager_id int null;

insert into Designation values
(1,'Regional Manager'),
(2,'Manager'),
(3,'Associate'),
(4,'Senior Manager');

select * from employee;

 
insert into department(Department_id,Department_name) values
(1,'HR'),
(2,'Backend Engineer'),
(3,'Testing Engineer'),
(4,'Frontend Engineer'),
(5,'Sales');

insert into attendence values
(2,2,GETDATE(),'09:00:00','18:00:00'),
(3,4,GETDATE(),'09:00:00','18:00:00'),
(4,4,GETDATE(),'09:00:00','18:00:00'),
(5,6,GETDATE(),'09:00:00','18:00:00');

insert into leaves values
(1,1,'Planned','2023-12-26','2024-01-05'),
(2,3,'Planned','2023-12-26','2024-01-05'),
(3,4,'Planned','2023-12-29','2024-01-08'),
(4,7,'Planned','2023-12-21','2024-01-01'),
(5,2,'Sick','2023-12-28','2024-01-05');

alter table leaves alter column Emp_id int not null;

select * from employee;

insert into pay_roll values
(1,'2023-11-01','2023-12-01'),
(2,'2023-10-01','2023-11-01'),
(3,'2023-09-01','2023-10-01'),
(4,'2023-08-01','2023-09-01'),
(5,'2023-07-01','2023-08-01'),
(6,'2023-06-01','2023-07-01');

insert into salary values
(1,1,1,100000,10000,19000,100000+10000-19000),
(2,2,1,100000,23000,20000,100000+23000-20000),
(3,1,2,100000,10000,19000,100000+10000-19000),
(4,3,1,100000,23000,20000,100000+23000-20000),
(5,4,1,100000,10000,19000,100000+10000-19000),
(6,7,1,100000,23000,20000,100000+23000-20000);

insert into training values
(1,'.Net','Will train you with concept of .Net','Sachin','2024-02-12','2024-04-12',1),
(2,'Spring Boot ','Will train you with concept of Spring Boot','Akhil','2024-02-12','2024-04-12',2),
(3,'Node Js','Will train you with concept of Node js','Sudesh','2024-02-12','2024-04-12',4),
(4,'Java','Will train you with concept of Java and advance Java','ManMohan','2024-02-12','2024-04-12',8),
(5,'Mongo Db','Will train you with concept of Mongo.Db','Amit','2024-02-12','2024-04-12',6),
(6,'Sql','Will train you with concept of Sql','Sam','2024-02-12','2024-04-12',7);


--query to get monthly salary if annaul salary is given
select employee_id,net_salary/12 from salary;
Go
--even row in employee table
create Function EvenRow()
Returns @Table Table
(emp_id int,
First_Name varchar(100),
Last_Name varchar(100) ,
D_o_b date ,
Address varchar(300) ,
contact_num char(10),
Email varchar(200),
HireDate date,
DesignationId int,
Departmentid int,
Row_Num int)
As
Begin
	Insert into @Table
	Select *,ROW_NUMBER() Over(Order by (select null))
	from employee;
	Return
End

with cte_evenRow As
(select First_name, (ROW_NUMBER() over(Order by (select null)))as row
from employee)
select * from cte_evenRow where row % 2 = 0;

select * from employee;

select top 50 percent * from employee order by First_Name desc;

select * from EvenRow() where ROW_NUM % 2 = 0;

--query to fetch last 5 elements
select top(5)* from EvenRow() order by Row_Num desc;
--query to fetch last record from the table
select Top(1)* from EvenRow() order by Row_Num desc;
--query to fetch last 50% from the table
select * from EvenRow() where Row_Num > (select count(*) from EvenRow())/2;
--query to distict value from the table with using distinct keyword
select First_Name,Last_Name,D_o_b,Address from employee group by First_Name,Last_Name,D_o_b,Address;
--query to validate email 


--Retrieve employee information along with their department names and designations
select con.*,des.Desiganiton_name from (select e.*,d.Department_name from employee e
inner join department d on e.Departmentid = d.Department_id) con
inner join Designation des on con.DesignationId = des.DesignationId;

--LEFT JOIN query:
--Retrieve all employees and their corresponding salaries, if available
select e.*,s.net_salary from employee e left outer join salary s on s.Employee_id = e.emp_id;

--RIGHT JOIN query:
--Retrieve all salaries and the corresponding employee names, if available
select e.*,s.net_salary from salary s right outer join employee e on s.Employee_id = e.emp_id;

--SELF JOIN query:
--Retrieve the names of employees and their respective managers
select CONCAT(con.full_name,' manager is : ',e1.First_Name,' ',e1.Last_Name) as Relation from
(select CONCAT(e.First_Name ,' ', e.Last_Name) as full_name,d.Manager_id as manager_id from employee e inner join department d on e.DesignationId = d.Department_id) 
con inner join employee e1 on con.manager_id = e1.emp_id;
GO

--Query using the CalculateAge function to retrieve the age of employees
create or alter Function CalculateAge(@emp_id int)
Returns int
As
Begin
	Declare @age int;
	select @age = DATEDIFF(year,e.D_o_b,GETDATE()) from employee e;
	Return @age;
End
Go

select Dbo.CalculateAge(1) as age;
Go

--Query using a custom function to calculate the total salary for an employee
create or alter Function Custom_Net_Salary(@emp_id int)
Returns decimal
As
Begin
	Declare @full_salary decimal
	select @full_salary = s.net_salary from employee e inner join salary s
	on s.Employee_id = e.emp_id where e.emp_id =  @emp_id;
	Return @full_salary
End
Go


select Dbo.Custom_Net_Salary(1) as salary;
Go

--Query using a function to get the number of employees in a specific department
create function Department_Count(@dept_id int)
Returns int
As
Begin
	Declare @Total_emp int;
	Select @Total_emp = count(*) from employee e inner join department d on d.Department_id = e.Departmentid where 
	e.Departmentid = @dept_id;
	Return @Total_emp
End
Go

alter function Get_DepartMentEmployeeCount()
Returns @Table Table
(id int,Department_Name varchar(50),count int)
As
Begin
	Insert into @Table
	Select d.Department_id,d.Department_name,count(*) from employee e inner join department d on d.Department_id = e.Departmentid group by d.Department_id,d.Department_name;
	Return
End
Go

select Dbo.Department_Count(2) as count;
Go

select * from Dbo.Get_DepartMentEmployeeCount();
Go


--Query using a function to get the number of leaves taken by an employee
create or alter Function Num_Leaves_Emp(@emp_id int)
Returns int
As
Begin
	Declare @leaves int
	select @leaves = DATEDIFF(DAY,l.start_date,end_date) from employee e inner join leaves l on e.emp_id = l.Emp_id; 
	Return @leaves;
end
Go

select dbo.Num_Leaves_Emp(1) as Leave;
Go

--Assuming we want to create a stored procedure to calculate the total salary for a specific employee based on their EmployeeID and a provided PayrollPeriodID.(handle exceptions in SP)
create or alter Proc Total_Salary
(@emp_id int,@payroll_id int)
As
Begin try
	select (s.net_salary*conn.Date_Diff)/30 as get_salary from (select DATEDIFF(Day,p.start_date,p.end_date) as 
	Date_Diff,e.emp_id as emp from employee e inner join pay_roll p on e.emp_id = @emp_id And p.payroll_id = @payroll_id) conn
	inner join salary s on s.Employee_id = conn.emp;
End try
Begin catch
	select Error_message(),Error_Line() as Error;
End catch
Go

Execute Total_Salary 1,1;
Go

--Write a Stored Procedure to validate username and password raise error if the data already present.
--create a stored procedure that will take the Employee ID of a person and checks if it is in the table.
--There are two conditions
--It will create a new record if the Employee ID is not stored in the table
--If the record is already in the table, it will update that
create or alter proc Employee_Exists
(@emp_id int ,
@First_Name varchar(100) ,
@Last_Name varchar(100) not null,
@D_o_b datetime not null,
@Address varchar(300) not null,
@contact_num char(10),
@Email char(10),
@HireDate date,
@DesignationId int,
@Departmentid int )
As
Begin try
	if Exists(select * from employee where emp_id = @Emp_id)
	Begin
		update employee set first_name = @FirstName,@last_name = @last_name,Dob= @Dob
		,Address = @Address,Contact_num = @contact_num,Email = @Email,HireDate = @HireDate,DesignationId = @DesignationId,
		DepartmentId = @DepartmentId;
	End
	else 
		RAISERROR('Person does not exists',12,1)
End try
Begin catch
	Print Error_Message();
End catch
Go

Exec Employee_Exists 100
Go
	
Create or alter proc update_employee
(@emp_id int,@Address varchar(50),@email varchar(50))
As
Begin try
	if Exists(select * from employee where emp_id = @emp_id)
	update employee set Address = @Address,email = @email where emp_id = @emp_id; 
	else 
		RAISERROR('Person does not exists', 16,1)
End try
Begin catch
	Select ERROR_MESSAGE() as error_message,ERROR_SEVERITY() as severity,ERROR_STATE() as state;
end catch
Go

Exec update_employee 100,'Australia','Sachin123@gmail.com';
Select * from employee;
Go

--Query using the EmployeeDetails view to get employee details along with department and manager information
create or alter view Employee_manager_view as
select conn.*,e1.First_Name as Manager_name from(select e.*,d.Manager_id ,d.Department_name from employee e inner join department d on d.Department_id = e.Departmentid) conn 
inner join employee e1 on conn.Manager_id = e1.emp_id;
Go

Select * from Employee_manager_view;
Go

--Query using a view to get employees who have taken leaves within a specific date range//
create or alter view employee_leave as
select e.emp_id,Concat(e.first_name,e.Last_Name) as FullName,l.start_date,l.end_date
from employee e inner join leaves l on l.Emp_id = e.emp_id;
Go

select * from employee_leave;
Go

--Query using a view to get employees with their respective department and designation names
create or alter view department_designation as
select con.*,des.Desiganiton_name from (select e.*,d.Department_name from employee e
inner join department d on e.Departmentid = d.Department_id) con
inner join Designation des on con.DesignationId = des.DesignationId;
Go

select * from department_designation
Go

--Query using a view to get employees who are managers along with their department names
create or alter view Employee_manager_view as
select conn.*,e1.First_Name as Manager_name from(select e.*,d.Manager_id ,d.Department_name from employee e inner join department d on d.Department_id = e.Departmentid) conn 
inner join employee e1 on conn.Manager_id = e1.emp_id;
Go

select * from Employee_manager_view;
Go

--Query to get employees who have salaries greater than the average salary in their department
select e.*,s.net_salary from employee e inner join salary s on e.emp_id = s.Employee_id
where (select AVG(net_salary) from salary) < s.net_salary;
Go

--Query to retrieve employees who have taken leaves longer than the average leave duration
select e.*,DATEDIFF(day,l.start_date,l.end_date) as leaves_no from employee e inner join leaves l on e.emp_id = l.Emp_id
where (select AVG(DATEDIFF(day,start_date,end_date)) from leaves) < DATEDIFF(day,l.start_date,l.end_date);
Go

--Query to get employees whose salary is within 10% of the highest salary in their department
select top 10 percent e.*,s.net_salary from employee e inner join salary s on e.emp_id = s.Employee_id 
order by s.net_salary desc;
Go

--Trigger to automatically update the HireDate of an employee when their record is inserted
create or alter Trigger New_Joining
on employee
After Insert
As
Begin
	Declare @new_id int;
	select @new_id = emp_id from inserted;
	update employee set HireDate = GetDate() where emp_id = @new_id;
	Print 'Updated'
end
Go




--Trigger to update the ModifiedDate of an employee when their record is updated


--Trigger to delete salary records of an employee when they are deleted from the Employee table
create trigger employee_delete
on employee
Instead of delete
As
Begin
	Declare @emp_id int
	select @emp_id = emp_id from deleted;
	delete from salary where Employee_id = @emp_id;
	Print 'Deleted'
end
Go



Alter table salary drop constraint Fk_employee;
Alter table salary add constraint Fk_employee foreign key (Employee_id) references employee(emp_id) on delete cascade;
Go



--Trigger to enforce a constraint where the EndDate of a leave must be greater than or equal to the StartDate
create Trigger Enforce_constraint_trigger
on leaves 
Instead of Insert
As
Begin
	if(select end_date from leaves) >= (select end_date from leaves)
	Print 'Well Done'
	else 
	RAISERROR('Wrong input',12,1);
End

--Trigger to automatically insert a new record in the Salary table with default values when a new employee is
--added to the Employee table


--Query using a cursor to fetch and display all employees' names
Declare @emp_id int;

Declare Product_Cursor Cursor for
select emp_id from employee;

Open Product_Cursor
Fetch next from product_cursor into @emp_id;
while(@@FETCH_STATUS = 0)
Begin 
	select * from employee where emp_id = @emp_id;
	Fetch next from product_cursor into @emp_id;
end

Close Product_Cursor
Deallocate Product_cursor
Go

--2 Query using a cursor to update the basic salary of all employees by a certain percentage
Declare @emp_id int

Declare Salary_update_cursor Cursor for
select emp_id from employee;

Open Salary_update_cursor
Fetch next from Salary_update_cursor into @emp_id
while(@@FETCH_STATUS = 0)
Begin 
	if Exists(select * from salary where Employee_id = @emp_id)
	Begin
		update salary set net_salary *= 1.1,basic_sal *= 1.1,allowances *= 1.1,deductions *= 1.1 
		where Employee_id = @emp_id;
		select e.*,s.net_salary from employee e inner join salary s on e.emp_id = s.Employee_id where 
		e.emp_id = @emp_id;
	End
	Fetch next from salary_update_cursor into @emp_id
End
Close salary_update_cursor
DeAllocate salary_update_cursor
Go

--we can use join commands we if want to do upper operations faster
update salary set net_salary *= 1.1,basic_sal *= 1.1,allowances *= 1.1,deductions *= 1.1
from salary s inner join employee e on s.Employee_id = e.emp_id;
select e.*,s.net_salary from employee e inner join salary s on e.emp_id = s.Employee_id
Go

--3 Query using a cursor to delete all employees who have left the organization


--4Query using a cursor to update employee designations based on their years of service
Declare @emp_id int
Declare @emp_designation varchar(50)
Declare @period int

Declare designation_cursor Cursor for
select emp_id from employee;

Open designation_cursor 
Fetch next from designation_cursor into @emp_id

while(@@FETCH_STATUS = 0)
Begin
	select @emp_designation = d.Desiganiton_name,@period = DATEDIFF(year,e.HireDate,GETDATE())
	from employee e inner join Designation d 
	on d.DesignationId = e.DesignationId where e.emp_id = @emp_id;
	if(@emp_designation = 'Regional Manager') AND (@period >  3)
	Begin 
		update employee set Departmentid = 4;
	End
	else if(@emp_designation = 'Manager') AND (@period >  3)
	update employee set Departmentid = 1;
	else if(@emp_designation = 'Associate') And (@period > 2)
	update employee set Departmentid = 2;
	else
		Print 'No promotion';
Begin
Select e.*,d.Desiganiton_name from employee e inner join Designation d on e.DesignationId = d.DesignationId
where e.emp_id = @emp_id;
end
Fetch next from designation_cursor into @emp_id
End
Close designation_cursor
Deallocate designation_cursor
Go

--5 Query using a cursor to calculate the total salary for each employee and display the results
Declare @emp_id int
Declare @basic_sal decimal
Declare @allowances decimal
Declare @deduction decimal
Declare @net_salary decimal

Declare Total_salary_cursor Cursor for
select emp_id from employee
Open Total_salary_cursor
Fetch next from Total_salary_cursor into @emp_id
while(@@FETCH_STATUS = 0)
Begin
	select @basic_sal = basic_sal,@allowances = allowances,@deduction = deductions 
	from salary where Employee_id = @emp_id;
	update salary set net_salary = @basic_sal + @allowances - @deduction where Employee_id = @emp_id;
	select e.*,s.net_salary from employee e inner join salary s on e.emp_id = s.Employee_id
	where e.emp_id = @emp_id;
	select @net_salary = net_salary from salary where Employee_id = @emp_id;
	Print 'update salary of the emp id : ' + Cast(@emp_id as varchar(50)) +' is '+ 
	cast(@net_salary as varchar(50));
	Fetch next from Total_salary_cursor into @emp_id;
End

Close Total_salary_cursor
Deallocate Total_salary_cursor
Go





--6 Cursor to update the salary of employees based on their performance rating:
--Suppose we have an EmployeePerformance table that contains the EmployeeID and their corresponding 
--PerformanceRating.
--We want to update the salary of employees based on their PerformanceRating.
--Employees with a PerformanceRating of 'Excellent' will receive a 10% salary increase,
--Good' will receive a 5% increase, and 'Average' will receive a 2% increase


Declare @emp_id int
Declare @your_rating int
Declare @salary decimal

Declare Performance_bonus_cursor Cursor for
select emp_id from employee

Open Performance_bonus_cursor
fetch next from Performance_bonus_cursor into @emp_id
while(@@FETCH_STATUS = 0)
Begin
	select @your_rating = p.rating from employee e inner join PerformanceRating p on e.emp_id = p.Employee_id
	where e.emp_id = @emp_id
	if(@your_rating <= 3)
	update salary set net_salary *= 1.02,allowances *= 1.02,deductions *= 1.02,basic_sal *= 1.02 where
	Employee_id = @emp_id
	else if(@your_rating = 4)
	update salary set net_salary *= 1.05,allowances *= 1.05,deductions *= 1.05,basic_sal *= 1.05 where
	Employee_id = @emp_id
	else if(@your_rating = 5)
	update salary set net_salary *= 1.1,allowances *= 1.1,deductions *= 1.1,basic_sal *= 1.1 where
	Employee_id = @emp_id
	select @salary = net_salary from salary where Employee_id = @emp_id;
	Print 'salary of employee_id: ' + Cast(@emp_id as varchar(50)) + ' is ' + Cast(@salary as varchar(50));
	Fetch next from Performance_bonus_cursor into @emp_id
End

Close Performance_bonus_cursor
Deallocate Performance_bonus_cursor
Go


	
--waise hi
use payroll_db;
alter table employee alter column departmentId int null;
select * from department
insert into department values
(6,'Default',1);
select * from employee;
insert into employee(emp_id,First_Name,Last_Name,D_o_b,Address,contact_num,email,HireDate,DesignationId) values
(14,'Kamlesh','Sharma','1995-08-14','India','1236547895','kamlesh12@gmail.com','2023-10-21',4);
GO



--7 Cursor to assign a default department for employees who don't have one:
--Suppose we have a Department table with a default department (DepartmentID = 1) representing employees without 
--an assigned department.
--We want to check if any employees have a NULL DepartmentID and assign them to the default department.
Declare @emp_id int
Declare @departmentId int

Declare Default_department_cursor Cursor for
select emp_id from employee;

Open Default_department_cursor
fetch next from Default_department_cursor into @emp_id

while(@@FETCH_STATUS = 0)
Begin
	select @departmentId = departmentId from employee where emp_id = @emp_id;
	select @departmentId
	if @departmentId is null
	Begin
	update employee set Departmentid = 6 where emp_id = @emp_id;
	Print 'entered'
	end
	else 
	Print 'Not entered'
	Fetch next from default_department_cursor into @emp_id;
end;
Close Default_department_cursor
DeAllocate Default_department_cursor
Go

--Query using the IX_Employee_EmployeeID index to retrieve an employee by their ID
drop index [PK__employee__1299A86169628E07] on employee;

create NonClustered Index IX_Employee_EmployeeID
on employee(emp_id);
Go

select * from employee


--Query using an index on the StartDate column to improve performance in searching for leaves within a specific date range
create NonClustered Index StartDate_Index
on leaves(start_date);
Go
--Query using an index on the DepartmentID column to optimize filtering employees by their department
create nonClustered Index DepartmentEmployee_index
on Employee(DepartmentId);
Go
--Query using an index on the NetSalary column to speed up searching for employees with specific salary ranges
create nonClustered Index Salary_search_index
on salary(salary_id)
Go
--Query using an index on the DesignationName column to quickly search for employees with a specific job designation
create nonClustered Index Designation_Name_index
on Designation(Desiganiton_name);
Go


