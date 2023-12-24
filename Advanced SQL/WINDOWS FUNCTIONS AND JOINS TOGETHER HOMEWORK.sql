use employees;

/*Exercise #1:
Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 10500 and 10600 inclusive. Let equal salary values for one and the same employee bear the same rank. Also, allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.*/

select e.emp_no, s.salary, e.hire_date, rank() over (partition by e.emp_no order by s.salary desc) from employees e join salaries s on e.emp_no=s.emp_no
where e.emp_no between 10500 and 10600;

/*
Exercise #2:
Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
*/

select e.emp_no, s.salary, e.hire_date, s.from_date,timestampdiff(year,e.hire_date,s.from_date) as diff, dense_rank() over w as ranking from employees e join salaries s on e.emp_no=s.emp_no
where e.emp_no between 10500 and 10600 and timestampdiff(year,e.hire_date,s.from_date) >= 5
window w as (partition by e.emp_no order by s.salary desc);

-- this is the correct one, it only counts whole years. It doesn't count years by number of days
select e.emp_no, s.salary, e.hire_date, s.from_date,year(s.from_date)-year(e.hire_date)as diff, dense_rank() over w as ranking from employees e join salaries s on e.emp_no=s.emp_no
where e.emp_no between 10500 and 10600 and year(s.from_date)-year(e.hire_date) > 4
window w as (partition by e.emp_no order by s.salary desc);
