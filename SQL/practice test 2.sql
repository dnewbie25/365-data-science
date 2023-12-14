use employees;

delimiter $$
create procedure last_dept (in p_emp_no int)
begin
select e.emp_no, d.dept_no, d.dept_name
from employees e join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
where e.emp_no = p_emp_no and de.from_date = (select max(from_date) from dept_emp where emp_no = p_emp_no);
end $$

delimiter ;

call last_dept(11345);