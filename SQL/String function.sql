-- string functions

select length('Ronak');

select first_name,length(first_name) as length
from employee_demographics
order by 2 ;

select upper('ronak');
select lower('RONAK');

select first_name,upper(first_name)
from employee_demographics
order by 1;

select trim('      ronak     ');
select ltrim('      ronak     ');
select rtrim('      ronak     ');

select first_name ,
left(first_name,4),
right(first_name,3),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;


select first_name,replace (first_name,'a','r')
from employee_demographics;

select locate('k','ronak');

select first_name, locate('an', first_name)
from employee_demographics;

select first_name,last_name,
concat (first_name  ,'  ',last_name)
from employee_demographics;





