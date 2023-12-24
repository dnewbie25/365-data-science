use employees;

SELECT 
    d.dept_no, d.dept_name, dm.emp_no, rank() over s as department_salary_ranking, s.salary, s.from_date as salary_from_date,
    s.to_date as salary_to_date, dm.from_date as dept_manager_from_date, dm.to_date as dept_manager_to_date
FROM
    departments d
    join
    dept_manager dm on d.dept_no=dm.dept_no
    join
    salaries s on dm.emp_no = s.emp_no
window s as (partition by dm.emp_no order by salary desc);

