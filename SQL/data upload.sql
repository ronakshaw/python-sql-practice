DROP TABLE IF EXISTS layoffs;

CREATE TABLE layoffs (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off TEXT,
  percentage_laid_off TEXT,
  date TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions TEXT
);
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/Users/ronak/Downloads/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM layoffs;

select company, total_laid_off
from layoffs
order by total_laid_off desc ;

ALTER TABLE layoffs 
MODIFY COLUMN total_laid_off INT;