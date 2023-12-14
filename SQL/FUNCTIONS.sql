use employees;

drop function if exists f_emp_avg_salary;	

delimiter $$
create function f_emp_avg_salary (p_emp_no int) returns decimal(10,2) -- se especifica el DATA TYPE de la variable a retornar, decimal en este caso
DETERMINISTIC -- DETERMINISTIC NO SQL READS SQL DATA se debe ver cual sirve para que las funciones no arrojen el error 1418
begin
declare v_avg_salary decimal(10,2); -- se declara la variable de salida
begin
declare v_avg_salary2 decimal(10,2);
end;
select avg(s.salary)
into v_avg_salary -- debe usarse el INTO que apunte a la variable de salida 
from employees e inner join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;

return v_avg_salary; -- se retorna la variable de salida
end $$
delimiter ;

select f_emp_avg_salary(11300) as salario; -- así se ejecuta una función definida por el usuario

drop function if exists emp_info;
delimiter $$
create function emp_info (p_first_name varchar(255), p_last_name varchar(255)) returns int 
deterministic
begin
declare v_emp_salary int;
select s.salary
into v_emp_salary
from employees e
inner join salaries s on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name
order by s.from_date desc
limit 1;
return v_emp_salary;
end $$
delimiter ;

select emp_info("Aruna","Journel");

select e.emp_no, s.salary, max(s.from_date) as d
from employees e
inner join salaries s on e.emp_no = s.emp_no
group by e.emp_no,s.salary
having e.emp_no = 10789
order by e.emp_no, d desc;

select * from employees where year(hire_date) = 2000 order by first_name asc;

select * from dept_emp;

select e.gender, avg(s.salary),de.dept_name from employees e join salaries s on e.emp_no = s.emp_no join dept_emp d on d.emp_no = e.emp_no
join departments de on d.dept_no = de.dept_no
group by e.gender, de.dept_name;