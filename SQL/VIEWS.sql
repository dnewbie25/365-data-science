-- SQL VIEWS
use employees;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- run SET sql_mode=(SELECT CONCAT(@@sql_mode,'ONLY_FULL_GROUP_BY','')); to enable full group
select emp_no, from_date, to_date, count(emp_no) as num
from dept_emp
group by emp_no
having num > 1;

drop view if exists avg_manager_salaries;
CREATE OR REPLACE VIEW avg_manager_salaries AS
    SELECT 
        avg(s.salary)
    FROM
        titles t
            INNER JOIN
        salaries s ON t.emp_no = s.emp_no
	where t.title = 'Manager';

select * from avg_manager_salaries;