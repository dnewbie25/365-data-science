use employees;

SELECT 
    emp_no, salary,
    row_number() over (partition by emp_no order by salary desc) as row_num
FROM
    salaries;
    
select
emp_no, dept_no, row_number() over (order by emp_no asc) as man_num
from dept_manager;

select
emp_no, first_name, last_name, row_number() over (partition by first_name order by last_name asc) as name_numeration
from employees;

select dm.emp_no, dm.dept_no, s.from_date, s.salary, row_number() over () as row_num, row_number() over (partition by emp_no order by salary asc) as managaer_row_num
from dept_manager dm inner join salaries s on dm.emp_no = s.emp_no;

select dm.emp_no, dm.dept_no, s.from_date, s.salary, row_number() over (partition by emp_no order by salary asc) as row_num, row_number() over (partition by emp_no order by salary desc) as managaer_row_num
from dept_manager dm inner join salaries s on dm.emp_no = s.emp_no;