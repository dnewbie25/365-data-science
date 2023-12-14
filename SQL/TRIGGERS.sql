use employees;
set autocommit=0;
start transaction;
commit;

delimiter $$
create trigger hire_date_check
before insert on employees 
for each row
begin
 if new.hire_date > date(now()) then
	set new.hire_date = date(now());
    end if;
end $$

delimiter ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

select * from employees where emp_no=999904;

select * from salaries where salary > 89000;

create index salary_index on salaries (salary);

alter table salaries
drop index salary_index;