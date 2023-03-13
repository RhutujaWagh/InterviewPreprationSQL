--1. Write a SQL query to fetch the count of employees that job_title 'Public Accountant'? 

select first_name,last_name,job_id 
from employees 
where job_id = 
(
	select job_id 
	from jobs
	where job_title = 'Public Accountant'
)

--2. Write a query to fetch employee names and salary records. 
--Return job even if the max_salary record is the employee.

select e.first_name,e.last_name,j.max_salary 
from employees e
left join jobs j
on e.job_id = j.job_id

--3. Write a SQL query to create an empty table with the same structure as some other table.

create table jobDetails 
as 
select * 
from jobs 
where 1 = 2 

--4. Write a SQL query to fetch common records between two tables?

select e.first_name ,e.last_name,d.department_name
from employees e
inner join departments d
on e.department_id = d.department_id

select employee_id,first_name,last_name from employees
union all
select employee_id,first_name,last_name from dependents
order by employee_id 

select employee_id,last_name from employees
union 
select employee_id,last_name from dependents
EXCEPT
select employee_id,last_name from employees
intersect
select employee_id,last_name from dependents

commit



