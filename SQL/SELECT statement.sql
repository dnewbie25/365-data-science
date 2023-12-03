use employees;

select dept_no from departments;
select * from employees where first_name='Elvis';
select * from employees where (first_name='Kellie' or first_name='Aruna') and gender='M';

select * from employees where first_name in ('Denis','Elvis');

select * from employees where first_name not in ('Jacob','Mark','John');
select count(emp_no) from employees;

select * from employees where first_name like ('Mark%');
select * from employees where hire_date like ('2000%');
select * from employees where emp_no like ('1000_');

select * from employees where first_name like ('%jack%');
select * from employees where first_name not like ('%jack%');

select * from salaries;
select * from salaries where salary between 66000 and 70000;
select * from employees where emp_no not between 10004 and 10012;
select * from departments where dept_no between 'd003'and 'd006';
select * from departments where dept_name is null;


select * from employees where gender='F' and hire_date >= '2000-01-01';

select * from salaries where salary > 150000;


select distinct gender from employees;

select count(salary) from salaries where salary >= 100000;

select count(*) from titles where title = 'manager';

select * from employees order by hire_date asc;

select salary, count(emp_no) as emps_with_same_salary from salaries where salary > 80000 group by salary order by salary asc;

select emp_no, avg(salary) from salaries group by emp_no having avg(salary)>120000 order by emp_no;

select emp_no, count(from_date) from dept_emp where from_date>= '2000-01-01' group by emp_no having count(from_date)>1 order by emp_no;

select * from titles limit 10;
select emp_no from titles;
insert into employees values (999903,'1977-09-14','Johnatahn','Creek','M','1999-01-01');
insert into titles (emp_no,title,from_date) values (999903,'Senior Engineer','1997-10-01');
select * from dept_emp;
insert into dept_emp values (999903,'d005','1997-10-01','9999-01-01');

select * from departments;
insert into departments values ('d010','Business Analysis');

select * from employees where emp_no=999903;

set autocommit=0;
start transaction;

commit;
delete from employees where emp_no=999903;
rollback;

select * from departments;
commit;
delete from departments where dept_no='d010';
