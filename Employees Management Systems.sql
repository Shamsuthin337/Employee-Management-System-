-- Employees Management DB
-- Database: MySQL


-- 1.Database selection

create database EmployeesmanagementDB;
use EmployeesmanagementDB;

-- 2.Create tables

create table Employees(
	Employee_id int primary key auto_increment,
    Employee_name varchar(20),
    Employee_gender enum("M","F"),
    Employee_contact varchar(15),
    Employee_email varchar(20)
);

create table Departments(
	Department_id int,
    Department_name varchar(25)
);
    
create table Employee_performance(
	performance_id int primary key,
    employee_id int,
    rating int,
    bonus int
);

-- 3.Insert sample data  

insert into Departments(Department_id,Department_name)
values (1,"HR"),
(2,"IT"),
(3,"SALES"),
(4,"FINANCE");

insert into Employee_performance(performance_id,employee_id,rating,bonus)
values (1,1,4,40000),
(2,2,5,50000),
(3,3,4,40000),
(4,4,4,40000),
(5,5,5,50000),
(6,6,3,30000);
delimiter $$

create procedure addEmployees(
Employee_name varchar(20),
Employee_gender enum("M","F"),
Employee_contact varchar(15),
Employee_email varchar(20),
Department_id int
)

	begin
		insert into Employees(Employee_name,Employee_gender,Employee_contact,Employee_email,Department_id)
        values (Employee_name,Employee_gender,Employee_contact,Employee_email,Department_id);
	end $$
delimiter ;

-- 4.Stored procedure 

call addEmployees("siva","M","+917392849938","siva@gmail.com","2");

-- 5. select statements

select * from Employees;
select * from Departments;
select * from Employee_performance;

-- 6.Analysis queries 

-- left join concept--

select 
	e.Employee_id,
	e.Employee_name,
	d.Department_name,
    ep.rating,
    ep.salary,
    ep.bonus
	from Employees as e
left join Departments as d 
	on e.Department_id = d.Department_id
left join Employee_performance as ep
	on e.Employee_id = ep.employee_id;

-- department counts --
    
select 
	d.Department_name,
		count(e.Employee_id) as total_employees
			from Departments d
		left join Employees e 
			on d.Department_id = e.Department_id
		group by d.Department_id, d.Department_name;
 
 -- department average salary --
 
select 
	d.Department_name,
		avg(ep.salary) as average_salary
			from Departments d 
		left join Employees e
			on d.Department_id = e.Department_id
		left join employee_performance ep
			on e.Employee_id = ep.employee_id 
		group by d.Department_id, d.Department_name;

-- highest salary of employee --

select 
	e.Employee_id,
    e.Employee_name,
    ep.salary
		from Employees e 
	join employee_performance ep 
		on e.Employee_id = ep.employee_id
	where ep.salary = (select max(salary)
		from employee_performance
);

-- salary ranking --

select
	e.Employee_id,
    e.Employee_name,
    ep.salary
		from Employees e 
	join employee_performance ep
		on e.Employee_id = ep.employee_id
	order by ep.salary desc;
    
-- Having concept --

select 
	d.Department_name,
    avg(ep.salary) as average_salary
		from Departments d 
	join Employees e 
		on d.Department_id = e.Department_id 
	join employee_performance ep 
		on e.Employee_id = ep.employee_id
	group by d.Department_id, d.Department_name
    having avg(ep.salary) > 450000;
    
-- Department wise salary --

select 
	d.Department_name,
    sum(ep.salary) as total_salary
		from Departments d 
	join Employees e 
		on d.Department_id = e.Department_id 
	join employee_performance ep
		on e.Employee_id = ep.employee_id
	group by d.Department_id, d.Department_name
    order by total_salary desc;
    


    


