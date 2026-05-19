-- EDA(exloratory data analysis)

select*
from layoffs_2;


-- Looking at Percentage to see how big these layoffs were

select max(percentage_laid_off), min(percentage_laid_off)
from Layoffs_2;

-- Which companies had 1 which is basically 100 percent of they company laid off

select*
from Layoffs_2
where percentage_laid_off = 1;

-- if we order by funds_raised_millions we can see how big some of these companies were

select*
from Layoffs_2
where percentage_laid_off = 1 and funds_raised_millions is not null
order by funds_raised_millions desc;

select*
from Layoffs_2
where percentage_laid_off = 1 and funds_raised_millions is not null and country = 'india'
order by funds_raised_millions desc;

-- Companies with the biggest single Layoff

select company,total_laid_off
from Layoffs_2
order by 2 desc
limit 10;

-- now that's just on a single day

-- Companies with the most Total Layoffs

select distinct company, sum(total_laid_off)
from Layoffs_2
group by company
order by 2 desc
limit 10;

-- by location

select distinct company, location, sum(total_laid_off)
from Layoffs_2
group by company, location
order by 3 desc
limit 10;

select distinct company, location, sum(total_laid_off)
from Layoffs_2
where country = 'india' 
group by company, location
order by 3 desc;

select distinct country, sum(total_laid_off)
from Layoffs_2
group by country
order by 2 desc;

select year(date), sum(total_laid_off)
from Layoffs_2
group by year(date)
order by 1 asc;

select industry, sum(total_laid_off)
from Layoffs_2
group by industry
order by 2 desc;

select stage, sum(total_laid_off)
from Layoffs_2
group by stage
order by 2 desc;

-- companies with most layoff per year

with company_year as
(
	select company, year(date) as years, sum(total_laid_off) as total_laid_off
	from Layoffs_2
	group by company, year(date)
) 
, company_year_rank as
(
	select company, years, total_laid_off, 
    dense_rank() over (partition by years order by total_laid_off desc) as ranking
    from company_year
) 
select company,years,total_laid_off,ranking
from company_year_rank
where ranking <= 3
and years is not null
order by years asc, total_laid_off desc;

-- Rolling Total of Layoffs Per Month

select substring(`date`,1,7) as dates, sum(total_laid_off) as total_laid_off
from layoffs_2
group by dates
order by dates asc;

with date_cte as
(
	select substring(`date`,1,7) as dates, sum(total_laid_off) as total_laid_off
	from layoffs_2
	group by dates
	order by dates asc
)
select dates, sum(total_laid_off) over(order by dates asc) as rolling_total
from date_cte
where dates is not null
order by dates asc;


