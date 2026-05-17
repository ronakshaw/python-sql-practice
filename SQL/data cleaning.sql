-- data cleaning

-- 1. check & clean duplicate rows
-- 2. standardize data and fix errors
-- 3. look at null values
-- 4. remove unnecessary columns and rows


select*
from layoffs;

create table layoffs_1
like layoffs;

insert layoffs_1
select* from layoffs;

select*
from layoffs_1;

-- 1

with CTE_1 as
(
	select company,location,industry,total_laid_off,percentage_laid_off,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off)row_num
	from layoffs_1 
)
select*
from CTE_1
where row_num > 1;

select *
from layoffs_1
where company = 'oda';

select company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)row_num
from layoffs_1 ; 

with CTE_2 as
(
	select company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)row_num
	from layoffs_1 
)
select*
from CTE_2
where row_num > 1;

CREATE TABLE `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert layoffs_2
select *,
	row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)row_num
from layoffs_1 ;

select*
from layoffs_2
where row_num > 1;

delete
from layoffs_2
where row_num > 1;

-- 2

select *
from layoffs_2;

select distinct trim(company)
from layoffs_2;

update layoffs_2
set company = trim(company);

select *
from layoffs_2
order by industry asc;

select distinct industry
from layoffs_2
where industry like 'crypto%';

update layoffs_2
set industry = 'crypto'
where industry like 'crypto%';

update layoffs_2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_2
modify column `date` date;

select distinct country
from layoffs_2
order by country asc;

update layoffs_2
set country = 'United states'
where country like 'United states%';

-- 3

select *
from layoffs_2
where industry is null 
or industry = ''
order by industry;

update layoffs_2
set industry = null
where industry like '';

update layoffs_2 t1
join layoffs_2 t2
	on t1.company = t2.company
    set t1. industry = t2.industry
where t1.industry is null 
and t2. industry is not null; 

select *
from layoffs_2
where percentage_laid_off is null and total_laid_off is null;

delete
from layoffs_2
where percentage_laid_off is null
and total_laid_off is null;

-- 4
alter table layoffs_2
drop column row_num;

select *
from layoffs_2;