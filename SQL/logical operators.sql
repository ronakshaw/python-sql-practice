-- AND OR NOT -- Logical operators

select *
from Parks_and_Recreation.employee_demographics
WHERE birth_date >= '1985-01-01'
or gender = 'male'
;

select *
from Parks_and_Recreation.employee_demographics
WHERE (first_name = 'leslie' and age = 44) or age > 60
;

select *
from Parks_and_Recreation.employee_demographics
WHERE first_name like 'Ap___%' 
;



