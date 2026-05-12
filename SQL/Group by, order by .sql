-- group by

select gender, avg(age),max(age),min(age),count(age)
from employee_demographics
group by gender
;

select occupation, salary
from employee_salary
group by occupation, salary
;

select *
from employee_demographics
order by gender asc, age desc
;

select *
from employee_demographics
order by first_name,last_name
;

select *
from employee_demographics
order by 5,4