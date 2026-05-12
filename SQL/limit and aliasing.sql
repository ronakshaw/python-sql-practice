-- limit and aliasing

-- limit

select *
from employee_demographics
limit 4
;

select *
from employee_demographics
order by age desc
limit 4
;

select *
from employee_demographics
order by age desc
limit 2,1
;

-- aliasing

select gender, avg (age) as avg_age
from employee_demographics
group by gender
;

select gender, avg (age) as avg_age
from employee_demographics
group by gender
having avg_age
;