-- EDA(exloratory data analysis)

select*
from Layoffs_1;


-- Looking at Percentage to see how big these layoffs were

select max(percentage_laid_off), min(percentage_laid_off)
from Layoffs_1;

-- Which companies had 1 which is basically 100 percent of they company laid off

select*
from Layoffs_1
where percentage_laid_off = 1;

-- if we order by funds_raised_millions we can see how big some of these companies were

select*
from Layoffs_1
where percentage_laid_off = 1 and funds_raised_millions is not null
order by funds_raised_millions desc;

-- Companies with the biggest single Layoff

select company,total_laid_off
from Layoffs_1
order by 2 desc
limit 5 ;

-- now that's just on a single day

-- Companies with the most Total Layoffs

select distinct company, sum(total_laid_off)
from Layoffs_1
group by company
order by 2 desc
limit 10;