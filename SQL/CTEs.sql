-- CTEs

with CTE_example(Gender,AVG_sal,MAX_sal,MIN_sal,COUNT_sal) as
	(
select gender,avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender
	)
select *
from CTE_example;

select avg(avg_sal)
from(
select gender,avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
) example_subquery;


with 
CTE_example1 as
(
select employee_id, gender, birth_date
from employee_demographics
where birth_date > '1985_01_01'
),
CTE_example2 as
(
select employee_id,salary
from employee_salary
where salary > 50000
)
select *
from CTE_example1
join CTE_example2
	on CTE_example1.employee_id = CTE_example2.employee_id