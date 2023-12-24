use employees;

/*Exercise #1:
Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest.*/
select emp_no, salary, row_number() over w as ranking from salaries where emp_no = 10560 window w as (partition by emp_no order by salary desc);

/*Exercise #2:
Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company.
 */
 select e.emp_no, count(s.salary) as contracts from dept_manager e join salaries s on e.emp_no=s.emp_no group by e.emp_no;
 
 /*Exercise #3:
Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed.*/
select emp_no, salary, rank() over (partition by emp_no order by salary desc) as ranking from salaries where emp_no=10560;

/*Exercise #4:
Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.
*/
select emp_no, salary, dense_rank() over (partition by emp_no order by salary desc) as ranking from salaries where emp_no=10560;
