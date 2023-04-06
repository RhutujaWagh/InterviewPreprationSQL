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
on e.job_id = j.job_id;

--3. Write a SQL query to create an empty table with the same structure as some other table.

create table jobDetails 
as 
select * 
from jobs 
where 1 = 2;

--4. Write a SQL query to fetch common records between two tables?

select e.first_name ,e.last_name,d.department_name
from employees e
inner join departments d
on e.department_id = d.department_id;

select employee_id,first_name,last_name from employees
union all
select employee_id,first_name,last_name from dependents
order by employee_id;

select employee_id,last_name from employees
union 
select employee_id,last_name from dependents
EXCEPT
select employee_id,last_name from employees
intersect
select employee_id,last_name from dependents;


--5. Write a query to fetch the EmpFname from the EmployeeInfo table in 
-- upper case and use the ALIAS name as EmpName.

select upper(first_name) as EmpName from employees;

--6. Write a query to get the current date.

select current_date;
select current_time;

--7. Write q query to find all the employees whose salary is between 50000 to 100000.

select first_name,last_name,salary from employees where salary between 5000 and 25000 order by salary;

--8. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. 
-- The first name and the last name must be separated with space.

select (first_name||' '||last_name) AS Full_name from employees;

-- 9. Write a SQL query to retrieve employee details from EmployeeInfo table 
-- who have a date of joining in the Employee table.

insert into employees values(207,'rhutuja','wagh','abc@gmail.com','547.145.4621',null,2,1576,205,4)

select first_name,last_name,salary,hire_date from employees where hire_date is not null;

alter table employees alter column hire_date drop not null;------****************************------

--10. Write An SQL Query To Fetch “FIRST_NAME” From employee Table Using The Alias Name As <WORKER_NAME>?

select first_name as worker_name from employees;

--11. Write An SQL Query To Fetch Unique Values Of department From employee Table.

select distinct(department_id) from employees order by department_id;

-- 12. Write An SQL Query To Find The Position Of The Alphabet (‘n’) 
-- In The First Name Column ‘steven’ From Worker Table.

select position('a' in first_name),first_name from employees;

--13. Write An SQL Query To Print The DEPARTMENT From Worker Table After Removing 
-- White Spaces From The Left Side.

select length(LTRIM(first_name)),first_name from employees;

--14. Write An SQL Query To Print All EMPLOYEE Details From The EMPLOYEES Table Order By 
-- FIRST_NAME Ascending And DEPARTMENT Descending.

select first_name ,department_id from employees order by LTRIM(first_name) ASC,department_id DESC;

--15. Write An SQL Query To Print Details Of The Employees Whose FIRST_NAME Contains ‘A’?

select first_name from employees where upper(first_name) like '%A%' order by first_name;

--16. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘n’ 
-- And Contains Six Alphabets.

select first_name from employees where first_name like '_____n';

--17. Write An SQL Query To Fetch Worker Names With Salaries >= 50000 And <= 100000.

select first_name,last_name,salary from employees where salary >= 5000 and salary<=25000 order by salary;

--18. Write An SQL Query To Print Details Of The Workers Who Are Also 'Human Resources'.

select e.first_name,e.last_name,d.department_name from employees e
inner join departments d
on e.department_id = d.department_id
where d.department_name = 'Human Resources';

--19. Write An SQL Query To Clone A New Table From Another Table.
create table jobdetails as select * from jobs;
select * from jobdetails

--19.Write a SQL query to create an empty table with the same structure as some other table.
create table emptyjob as select * from jobs where 1 = 2
select * from emptyjob

--20. Write An SQL Query To Fetch The List Of Employees With The Same Salary.

select first_name,last_name,salary from employees where salary not in (select e.salary from employees e group by e.salary having count(salary)>1) order by salary;

select first_name,last_name,salary ,length(cast(salary as text)) from employees where length(cast(salary as text)) >= 6

--21. Write An SQL Query To Show The Second Highest Salary From A Table.
select max(salary) from employees where salary not in (select max(salary) from employees)
select max(salary) from employees where salary <> (select max(salary) from employees)
select max(salary) from employees where salary < (select max(salary) from employees)
select max(salary) from employees where salary = (select max(salary) from employees)
select max(salary) from employees where salary > (select max(salary) from employees)

select first_name,salary, DENSE_RANK() over(order by salary desc) as Rank
from Employees

select first_name,salary, RANK() over(order by salary desc) as Rank
from Employees

select R.first_name,R.salary from (select first_name,salary,Row_number() over(order by salary desc) as Rank
from Employees)R where R.rank = 3

select first_name,salary,lead(salary) over(order by salary desc) from employees
select first_name,salary,salary-lead(salary) over(order by salary desc) from employees

select first_name,salary,lag(salary,1,0) over(order by salary desc) from employees
select first_name,salary,salary-lag(salary) over(order by salary desc) from employees

--23. What is a view in SQL?
create view empSalaryRank AS
select first_name,salary, DENSE_RANK() over(order by salary desc) as Rank
from Employees;

select * from empSalaryRank where rank = 3;

--24. How we can update the view?
create or replace view empSalaryRank AS
select first_name,salary, RANK() over(order by salary desc) as Rank
from Employees;

--25. Explain the working of SQL Privileges?
grant all 
on employees
to postgres;

revoke all 
on employees
from postgres;

--26. Get employee details from employee table whose hiring year is “1994”

select emp.first_name,emp.last_name,emp.hire_date from 
(select first_name,last_name,hire_date,extract(year from hire_date) as year from employees)emp
where emp.year = 1994;

--27. How to remove duplicate rows from table?

insert into employees values(209,'rhutuja','wagh','abc@gmail.com','547.145.4621',null,2,1576,205,4)

delete from employees where employee_id in(select max(employee_id),first_name from employees group by (first_name) having count(TRIM(first_name))>1)


select * from employees;

--28.How to add Email validation using single SQL Statement

alter table employees add constraint email check(email like '%@%.%') ------****************************------

insert into employees values(210,'ritu','wagh','abc@gmail.com','547.145.4621',null,2,1576,205,4)

--29.How to calculate number of rows in table without using count function?

SELECT count(column_name)
  FROM information_schema.columns
 WHERE table_name = 'employees';
 
 --30.Will following statement give Divide by Zero error?
 
 select 0/null;
 select null/0;
    
--31. Write an SQL query to find the maximum, minimum, and average salary of the employees.

select max(Salary),min(salary),avg(salary) from employees;

--32. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.

SELECT Employee_Id,
Salary+8000 as TotalSalary 
FROM Employees;

--33. write a query for adding default constriant

alter table employees alter column salary set default 0;------****************************------
alter table employees modify columns salary default 0;

--34. case function
select first_name,case when first_name like '%rhutuja%' then 'babu' else 'no babu' end new_name from employees;

select first_name,last_name,
CASE 
WHEN last_name like '%wagh%' THEN 'cutee' 
WHEN first_name like '%rakesh%' THEN 'pillu'
ELSE 'no change'
END
from employees

--35. What Is The SQL Query Used To Fetch Alternate Records From A Table?
select * from employees where employee_id % 2 = 0;

select * from employees where employee_id % 2 <> 0;

select * from employees where employee_id % 2 = 1;

--36.What Is The SQL Query Used To Fetch The Common Records From Two Tables?

select e.first_name,salary from employees e 
inner join departments d 
on e.department_id = d.department_id

--37.What Is The SQL Query Used To Find Duplicate Rows In Table?

select first_name,count(salary),salary from employees group by first_name,salary having count(salary)>1;

select first_name,salary from employees where first_name in (select first_name from employees group by first_name having count(salary)>1) order by 2;






commit



