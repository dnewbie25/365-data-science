SELECT * FROM employees.dept_emp;
use employees;
select count(distinct dept_no) from dept_emp; 

select * from salaries;
select round(sum(salary),3) from salaries where from_date > 1997-01-01;

select min(emp_no) from employees;
select max(emp_no) from employees;

select avg(salary) from salaries where from_date > 1997-01-01;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

select * from departments_dup;

alter table departments_dup
add column dept_manager varchar(255) null after dept_name;

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');
commit;

-- AQUI EMPIEZA EL COALESCE Y EL IFNULL
select dept_no, ifnull(dept_name, 'Department not provided')
from departments_dup;

select dept_no, dept_name, coalesce(dept_manager,dept_name,'Department not provided') as dept_manager_coalesce
from departments_dup;

select 
ifnull(dept_no, 'n/a') as dept_no,
ifnull(dept_name, 'Department not provided') as dept_name,
coalesce(dept_no, dept_name) as dept_info
from departments_dup;

SELECT

    IFNULL(dept_no, 'N/A') as dept_no,

    IFNULL(dept_name,

            'Department name not provided') AS dept_name,

    COALESCE(dept_no, dept_name) AS dept_info

FROM

    departments_dup

ORDER BY dept_no ASC;

select * from departments_dup;
alter table departments_dup
drop column dept_manager;

alter table departments_dup
change column dept_no dept_no char(4) null;

alter table departments_dup
change column dept_name dept_name varchar(40) null;