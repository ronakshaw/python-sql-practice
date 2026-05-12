select *
from Parks_and_Recreation.employee_demographics;

select first_name,
last_name,
age,
age+10
from Parks_and_Recreation.employee_demographics;

select distinct gender
from Parks_and_Recreation.employee_demographics;

select distinct first_name,gender
from Parks_and_Recreation.employee_demographics;

select *
from Parks_and_Recreation.employee_demographics
WHERE gender != 'male'
;

select *
from Parks_and_Recreation.employee_demographics
WHERE gender != 'male'
;

