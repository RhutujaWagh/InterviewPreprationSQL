select * from employees;
select * from departments;

/*
	Problem statement1: (“WHERE” clause without “group by”)
	Write an SQL query to get details of all employees where the employee belongs to the “IT” department 
	and emp_name starts with ‘a/A’.
*/
select employees.first_name,employees.last_name,employees.salary,departments.department_name
from employees
inner join departments
on employees.department_id = departments.department_id
where first_name like 'A%' and department_name = 'IT'

/*
	Problem statement2: (“WHERE” clause with “group by”)
	Write an SQL query to get emp_name, emp_salary, and dept_name with maximum salary in each department.
*/
select departments.department_name,employees.first_name,employees.last_name,employees.salary as max_salary
from employees
inner join departments
on employees.department_id = departments.department_id
where employees.salary 
in
(
	select max(salary) as salary
	from employees
	inner join departments
	on employees.department_id = departments.department_id
	group by departments.department_name
	order by salary

)

/*
	Problem statement3: (“HAVING” clause)
	Write an SQL query to get dept_name and the sum of amount (salary of all employees)
	in each department must be greater than 50000.
*/

select departments.department_name,sum(employees.salary)
from employees
inner join departments
on employees.department_id = departments.department_id
group by departments.department_name
having sum(employees.salary)>50000

commit

