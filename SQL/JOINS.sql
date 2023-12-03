use employees;

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );
  
  INSERT INTO dept_manager_dup
SELECT * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                            (999905, '2017-01-01'),
                            (999906, '2017-01-01'),
                            (999907, '2017-01-01');
                            
DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES               ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
    
select * from dept_manager_dup;

select * from departments_dup;

-- INNER JOIN

delete from departments_dup where dept_name = 'Public Relations';

select e.emp_no, e.first_name, e.last_name, e.hire_date, d.dept_no
from employees e
inner join
dept_manager_dup d on e.emp_no=d.emp_no;

-- LEFT JOIN

delete from dept_manager_dup where emp_no = '110228';

delete from departments_dup where dept_no = 'd009';

insert into dept_manager_dup values (110228,'d003','1992-03-21','9999-01-01');
insert into departments_dup values ('d009','Customer Service');

select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
left join departments_dup d on m.dept_no = d.dept_no
;

select e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
from employees e
left join dept_manager d on e.emp_no = d.emp_no
where e.last_name = 'Markovitch'
order by d.dept_no desc, e.emp_no
;

-- using WHERE old syntax

select 	e.emp_no, e.first_name, e.last_name, e.hire_date,m.dept_no
from employees e,
dept_manager m
where e.emp_no = m.emp_no;

-- using JOIN and WHERE
select 	e.emp_no, e.first_name, e.last_name, e.hire_date,j.title
from employees e
inner join titles j
on e.emp_no = j.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch';


-- using CROSS JOIN
select m.*, d.*
from dept_manager m
cross join departments d
where d.dept_no = 'd009';

select e.*, d.*
from employees e
cross join departments d
where emp_no < 10011;

-- Combining multiple JOIN statements

select e.first_name, e.last_name, e.hire_date,t.title, dept_manager.from_date, d.dept_name
from employees e
inner join dept_manager dept_manager on e.emp_no = dept_manager.emp_no
inner join titles t on e.emp_no = t.emp_no
inner join departments d on dept_manager.dept_no = d.dept_no;

-- how many male and female managers are in the employees database?
select e.gender, count(m.emp_no)
from employees e 
inner join dept_manager m on e.emp_no = m.emp_no
group by e.gender;

# UNION vs UNION ALL - solution

SELECT

    *

FROM

    (SELECT

        e.emp_no,

            e.first_name,

            e.last_name,

            NULL AS dept_no,

            NULL AS from_date

    FROM

        employees e

    WHERE

        last_name = 'Denis' UNION SELECT

        NULL AS emp_no,

            NULL AS first_name,

            NULL AS last_name,

            dm.dept_no,

            dm.from_date

    FROM

        dept_manager dm) as a

ORDER BY -a.emp_no DESC;