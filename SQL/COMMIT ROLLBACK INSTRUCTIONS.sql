
set autocommit=0;
start transaction; -- estas dos son RENECESARIAS PARA EL COMMIT
use employees;

select * from departments_dup order by dept_no;
commit;
update departments_dup
set 
	dept_no = 'd011',
    dept_name = 'Quality Control';
select * from departments_dup;
commit;
delete dept_manager from departments_dup;
rollback;

commit;

update departments_dup
set dept_name='Data Analysis'
where dept_no='d010';