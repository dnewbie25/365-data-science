use employees;

SELECT 
    de.emp_no, d.dept_name, s.salary,s.from_date,s.to_date, avg(s.salary) over w as avg_salary_department
FROM
    dept_emp de 
        JOIN
    departments d ON de.dept_no = d.dept_no
    join
    (select emp_no, salary, max(from_date) as from_date,to_date from salaries where from_date > '2000-01-01'
            AND to_date < '2002-01-01' group by emp_no) s on de.emp_no = s.emp_no
group by de.emp_no
window w as (partition by de.dept_no)
;

select emp_no, salary, max(from_date) as from_date,to_date from salaries where to_date > sysdate() group by emp_no;

SELECT 
    de.dept_no,
    s.salary,
    max(s.from_date),
    AVG(s.salary)
FROM
    dept_emp de
        JOIN
    salaries s ON s.emp_no = de.emp_no
group by de.dept_no;