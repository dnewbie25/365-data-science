use employees;

-- subqueries with IN and WHERE
select * from dept_manager where emp_no in (select emp_no from employees where hire_date between '1990-01-01' and '1995-01-01'); 

-- select the entire info of all employees whose job title is "Assistant Engineer"

select * from employees e where exists (select title from titles t where e.emp_no = t.emp_no and t.title='Assistant Engineer');

-- subqueries with SELECT and FROM

drop table if exists emp_manager;
create table emp_manager (
	emp_no int not null,
    dept_no char(4) default null,
    manager_no int not null
);

select * from emp_manager;


/* ejemplo antes de continuar. Asignar el numero 110022 como manager a todos los empleados desde el 10001 al 10020
y asignar el numero 110039 como manager a todos los empleados desde el 10021 al 10040*/

select A.* from
(SELECT 
    e.emp_no AS employee_id,
    MIN(dm.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_id
FROM
    employees e
        JOIN
    dept_emp dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no) as A
UNION 
select B.* from
(SELECT 
    e.emp_no AS employee_id,
    MIN(dm.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_id
FROM
    employees e
        JOIN
    dept_emp dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 10020
GROUP BY e.emp_no
ORDER BY e.emp_no limit 20) as B

UNION
select C.* from
(SELECT 
    e.emp_no AS employee_id,
    MIN(dm.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110039) AS manager_id
FROM
    employees e
        JOIN
    dept_emp dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no = 110022
GROUP BY e.emp_no
ORDER BY e.emp_no) as C
UNION 
select D.* from
(SELECT 
    e.emp_no AS employee_id,
    MIN(dm.dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_id
FROM
    employees e
        JOIN
    dept_emp dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no = 110039
GROUP BY e.emp_no
ORDER BY e.emp_no) as D;
