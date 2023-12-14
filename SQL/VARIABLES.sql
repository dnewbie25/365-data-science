set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

set @v_emp_no = 0;
call employees.emp_info("Aruna","Journel",@v_emp_no);
select @v_emp_no;

select * from employees.employees where emp_no = 10789;