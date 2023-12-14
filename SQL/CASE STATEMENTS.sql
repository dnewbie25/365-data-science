use employees;

select e.emp_no, e.first_name, e.last_name,
case d.emp_no
	when d.emp_no then 'Manager'
    else 'Employee'
end as is_manager 
from employees e 
left join dept_manager d on d.emp_no = e.emp_no
where e.emp_no > 109990
;

select d.emp_no, e.first_name, e.last_name, max(s.salary) - min(s.salary) as difference,
case
	when max(s.salary) - min(s.salary) > 30000 then 'More than 30k'
    when max(s.salary) - min(s.salary) < 30000 then 'Less than 30k'
    else 'Exactly 30k'
end as raise
from dept_manager d
left join employees e on d.emp_no = e.emp_no
inner join salaries s on s.emp_no = d.emp_no
group by d.emp_no;

select e.emp_no, e.first_name, e.last_name,
case 
	when max(d.to_date) > sysdate()  then 'Still employees'
    else 'Not an employee anymore'
end as still_employed
from dept_emp d
inner join employees e on d.emp_no = e.emp_no
group by emp_no
limit 100;