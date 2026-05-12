-- joins

-- inner join 

select *
from employee_demographics
;
select *
from employee_salary
;

select sal.employee_id,age,occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- outer joins

select dem.employee_id,age,occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- outer join

select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- self join

select emp1.employee_id as emp_santa,
emp1.first_name as santa_first_name,
emp1.last_name as santa_last_name,
emp2.employee_id as emp,
emp2.first_name as emp_first_name,
emp2.last_name as emp_last_name
from employee_salary emp1
join employee_salary emp2
 on 
 (emp1.employee_id + 1 = emp2.employee_id AND emp1.employee_id != 12)
 or 
 (emp1.employee_id = 12 AND emp2.employee_id = 1)
 ;
 
 -- joining multiple tables
 
 select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
;

select *
from parks_departments
;