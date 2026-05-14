-- case statement

select first_name,last_name,age,
case
	when age < 30 then 'Young'
	when age between 31 and 50 then 'Old'
    when age > 50 then 'On deaths bed'
end as Age_bracket
from employee_demographics;

-- salary <= 50000 then 5% hike
-- salary > 50000 then 7% hike
-- extra bonus of 10% for finance department

select first_name,last_name,
case
	when salary <= 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
end as New_salary,
case
	when dept_id = 6 then salary * 0.1
    else 0
end as bonus,
 (
        CASE
            WHEN salary <= 50000 THEN salary * 1.05
            WHEN salary > 50000 THEN salary * 1.07
        END
        +
        CASE
            WHEN dept_id = 6 THEN salary * 0.1
            ELSE 0
        END
    ) AS total_salary
from employee_salary
;



SELECT *,
       new_salary + bonus AS total_salary
FROM
(
    SELECT 
        first_name,
        last_name,

        CASE
            WHEN salary <= 50000 THEN salary * 1.05
            WHEN salary > 50000 THEN salary * 1.07
        END AS new_salary,

        CASE
            WHEN dept_id = 6 THEN salary * 0.1
            ELSE 0
        END AS bonus

    FROM employee_salary
) t;