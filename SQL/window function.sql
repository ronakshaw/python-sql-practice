-- window function

select dem.first_name, gender, avg(sal.salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by dem.first_name,gender
;

select dem.first_name, gender, sal.salary, avg(sal.salary) over(partition by gender) as Avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
 

select dem.first_name, 
gender, 
sal.salary, 
sum(sal.salary) over(partition by gender order by dem.employee_id) as Rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
    ;


select dem.employee_id,dem.first_name, gender, sal.salary,
row_number() over(partition by gender order by sal.salary desc) as Row_num,
rank() over(partition by gender order by sal.salary desc) as Rank_num, -- position wise ranking with duplicate numbers
dense_rank() over(partition by gender order by sal.salary desc) as Rank_num -- nummerically ranks with duplicate numbers
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
    ;
    
    