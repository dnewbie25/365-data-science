use employees;

drop procedure if exists select_employees;

-- create the delimites and the procedure

DELIMITER $$
create procedure select_employees()
begin
	select *
    from employees
    limit 1000
    ;
end $$

DELIMITER ; -- restores ; as the default delimiter

-- invoking the preocedure
call employees.select_employees();

-- si ya se usó la sentencia USE al inicio solo debe usarse (o darle al rayito en el schema)

call select_employees();

-- Create a procedure that will provide the average salary of all employees. Then, call the procedure.

delimiter $$
drop procedure if exists avg_salary_employees;
create procedure avg_salary_employees()
begin
	select avg(salary)
    from salaries
    ;
end $$
delimiter ;

call avg_salary_employees();

drop procedure select_employees;

-- stored procedures with INPUT parameter
drop procedure emp_salary;
delimiter $$
create procedure emp_salary (in p_emp_no int)
begin
select e.first_name, e.last_name, s.salary, s.from_date, s.to_date
from employees e
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no -- here the parameter is used
; 
end $$

delimiter ;
call emp_salary(10003);

drop procedure emp_avg_salary;
delimiter $$
create procedure emp_avg_salary (in p_emp_no int)
begin
select e.first_name, e.last_name, avg(s.salary)
from employees e
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no -- here the parameter is used
group by e.first_name, e.last_name
; 
end $$

delimiter ;
call emp_avg_salary(11300);

-- para retornar un valor se usa OUT

drop procedure emp_avg_salary_out;
delimiter $$
create procedure emp_avg_salary_out (in p_emp_no int, out p_avg_salary decimal(10,2))
begin
select avg(s.salary)
INTO p_avg_salary -- cuando se usa IN y OUT, se debe usar INTO y el nombre de la variable que será el OUT
from employees e
inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no -- here the parameter is used
group by e.first_name, e.last_name
; 
end $$

delimiter ;

-- Create a procedure called "emp_info" that uses as parameters the first and the last name of an individual, and returns their employee number.
drop procedure if exists emp_info;
delimiter $$
create procedure emp_info(in first_name varchar(255), in last_name varchar(255), out employee_no_out int)
begin
select e.emp_no
into employee_no_out
from employees e
where e.first_name = first_name and e.last_name = last_name
;
end $$

delimiter ;
