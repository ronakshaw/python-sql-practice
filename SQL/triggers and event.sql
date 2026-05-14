-- triggers

select*
from employee_demographics;

select*
from employee_salary;

delimiter $$
create trigger employee_insert
	after insert on  employee_salary
    for each row
begin
	insert into employee_demographics(employee_id,first_name,Last_name)
    values(new.employee_id, new.first_name, new.Last_name);
end$$
delimiter ;

insert into employee_salary(employee_id,first_name,Last_name,occupation,dept_id)
values('13','ronak','shaw','entrepreneur','1');

 
-- events

delimiter $$
create event delete_retirees
on schedule every 30 day
do
begin
	delete
    from employee_demographics
    where age > 60;
end$$
delimiter ;
