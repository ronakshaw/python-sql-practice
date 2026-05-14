-- stored procedure


create procedure Large_salaries()
select *
from employee_salary
where salary >= 50000;

call Large_salaries();


delimiter $$
create procedure Large_salaries1()
Begin
	select *
	from employee_salary
	where salary >= 50000;
	select*
    from employee_salary
	where salary >= 10000;
End$$
delimiter ;

call Large_salaries1();

delimiter $$
create procedure Large_salaries2(p_employee_id int)
Begin
	select salary
	from employee_salary
	where employee_id = p_employee_id
    ;
End$$
delimiter ;

call Large_salaries2(1);