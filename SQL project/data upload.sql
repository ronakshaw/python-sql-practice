CREATE TABLE product_category_name_translation (
    category_name_portuguese VARCHAR(100),
    category_name_english VARCHAR(100)
    );

SET GLOBAL local_infile = 1;    

LOAD DATA LOCAL INFILE '/Users/ronak/Downloads/archive/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select *
from product_category_name_translation