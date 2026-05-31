
SET SESSION wait_timeout = 600;
SET SESSION interactive_timeout = 600;

SET GLOBAL local_infile = 1;

select *
from olist_customers_dataset;
-- total 99441 row

select*
from olist_orders_dataset;
-- total 99441 row

select distinct order_id
from olist_orders_dataset
where order_status = 'delivered';
-- 96478 rows

describe olist_orders_dataset;	

update olist_orders_dataset
set order_delivered_customer_date = null
where order_delivered_customer_date = '';


ALTER TABLE olist_orders_dataset
MODIFY order_purchase_timestamp DATETIME,
MODIFY order_estimated_delivery_date DATETIME,
MODIFY order_delivered_customer_date DATETIME;

select *
from olist_order_items_dataset;
-- total 112650 row


describe olist_order_items_dataset;

ALTER TABLE olist_order_items_dataset
MODIFY shipping_limit_date DATETIME;

select*
from olist_products_dataset;
-- total 32340 row


select*
from olist_order_reviews_dataset;
-- total 99224 rows

select*
from olist_order_payments_dataset;
-- 103886

select *
from olist_sellers_dataset;
-- total 3095 row

select *
from product_category_name_translation;
-- total 71 row


-- joining tables
-- order data set has both order_id & customer_id

ALTER TABLE olist_customers_dataset
MODIFY customer_id VARCHAR(50),
MODIFY customer_state VARCHAR(5),
MODIFY customer_city VARCHAR(50);

ALTER TABLE olist_orders_dataset
MODIFY order_id VARCHAR(50),
MODIFY customer_id VARCHAR(50),
MODIFY order_status VARCHAR(20);

CREATE INDEX idx_orders_order_id ON olist_orders_dataset(order_id);
CREATE INDEX idx_orders_customer_id ON olist_orders_dataset(customer_id);

ALTER TABLE olist_order_items_dataset
MODIFY order_id VARCHAR(50),
MODIFY product_id VARCHAR(50),
MODIFY seller_id VARCHAR(50);

CREATE INDEX idx_items_order_id ON olist_order_items_dataset(order_id);
CREATE INDEX idx_items_product_id ON olist_order_items_dataset(product_id);
CREATE INDEX idx_items_seller_id ON olist_order_items_dataset(seller_id);

ALTER TABLE olist_products_dataset
MODIFY product_id VARCHAR(50),
MODIFY product_category_name VARCHAR(100);

ALTER TABLE olist_order_reviews_dataset
MODIFY order_id VARCHAR(50),
MODIFY review_id VARCHAR(50);

CREATE INDEX idx_reviews_order_id ON olist_order_reviews_dataset(order_id);

ALTER TABLE olist_order_payments_dataset 
MODIFY order_id VARCHAR(50),
MODIFY payment_type VARCHAR(50);

CREATE INDEX idx_payment_order_id ON olist_order_payments_dataset(order_id);

ALTER TABLE olist_sellers_dataset
MODIFY seller_id VARCHAR(50),
MODIFY seller_state VARCHAR(5),
MODIFY seller_city VARCHAR(50);

CREATE INDEX idx_sellers_seller_id ON olist_sellers_dataset(seller_id);

CREATE INDEX idx_translation_cat 
ON `product_category_name_translation` (category_name_portuguese(50));


SHOW PROCESSLIST;

kill 5;



select * 
from Master_data;


-- joined everything directly i.e., too many row gets duplicate

DROP TABLE IF EXISTS `Master_data`;

CREATE TABLE `Master_data` (
    `customer_id` varchar(50), 
    `order_id` varchar(50), 
    `product_id` varchar(50),
    `seller_id` varchar(50),
    `review_id` varchar(50),
    `price` float,
    `freight_value` float,
    `order_status` text,
    `order_purchase_timestamp` datetime,
    `shipping_limit_date` datetime,
    `order_delivered_customer_date` datetime,
    `order_estimated_delivery_date` datetime,
    `delivery_days` float,
    `product_category_name` text,
    `product_category_name_english` text, 
    `review_score` float,
    `customer_city` text,
    `customer_state` text,
    `seller_city` text,
    `seller_state` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create a real table for the compressed reviews
DROP TABLE IF EXISTS `Temp_Agg_Reviews`;

CREATE TABLE `Temp_Agg_Reviews` (
    `order_id` VARCHAR(50) PRIMARY KEY,
    `review_id` VARCHAR(50),
    `review_score` FLOAT
);

-- Insert the compressed data into it
INSERT INTO `Temp_Agg_Reviews`
SELECT 
    order_id,
    MAX(review_id) as review_id,
    AVG(review_score) as review_score 
FROM `olist_order_reviews_dataset`
GROUP BY order_id;

INSERT INTO Master_data
SELECT 
    customer.customer_id, 
    items.order_id, 
    items.product_id,
    items.seller_id,
    reviews.review_id,
    items.price,
    items.freight_value,
    orders.order_status,
    orders.order_purchase_timestamp,
    items.shipping_limit_date,
    orders.order_delivered_customer_date,
    orders.order_estimated_delivery_date,
    datediff(orders.order_delivered_customer_date, orders.order_purchase_timestamp) as delivery_days,
    product.product_category_name,
    T.category_name_english, 
    reviews.review_score,
    customer.customer_city,
    customer.customer_state,
    seller.seller_city,
    seller.seller_state 
FROM `olist_orders_dataset` orders 
JOIN `olist_customers_dataset` customer 
    ON orders.customer_id = customer.customer_id
JOIN `olist_order_items_dataset` items 
    ON orders.order_id = items.order_id
JOIN `olist_products_dataset` product 
    ON items.product_id = product.product_id
JOIN `olist_sellers_dataset` seller
    ON items.seller_id = seller.seller_id
LEFT JOIN `Temp_Agg_Reviews` reviews 
    ON orders.order_id = reviews.order_id
LEFT JOIN `product_category_name_translation` T 
    ON product.product_category_name = T.category_name_portuguese
WHERE orders.order_status = 'delivered';


SELECT orders.order_status, COUNT(items.product_id) as total_items
FROM `olist_orders_dataset` orders
JOIN `olist_order_items_dataset` items 
  ON orders.order_id = items.order_id
GROUP BY orders.order_status;

TRUNCATE TABLE Master_data; -- Empties the 108,659 rows so we can reload it

INSERT INTO Master_data
SELECT 
    customer.customer_id, 
    items.order_id, 
    items.product_id,
    items.seller_id,
    reviews.review_id,
    items.price,
    items.freight_value,
    orders.order_status,
    orders.order_purchase_timestamp,
    items.shipping_limit_date,
    orders.order_delivered_customer_date,
    orders.order_estimated_delivery_date,
    datediff(orders.order_delivered_customer_date, orders.order_purchase_timestamp) as delivery_days,
    product.product_category_name,
    T.category_name_english, 
    reviews.review_score,
    customer.customer_city,
    customer.customer_state,
    seller.seller_city,
    seller.seller_state 
FROM `olist_orders_dataset` orders 
JOIN `olist_customers_dataset` customer 
    ON orders.customer_id = customer.customer_id
JOIN `olist_order_items_dataset` items 
    ON orders.order_id = items.order_id
-- CHANGED THESE TO LEFT JOINS TO PREVENT DATA LOSS:
LEFT JOIN `olist_products_dataset` product 
    ON items.product_id = product.product_id
LEFT JOIN `olist_sellers_dataset` seller
    ON items.seller_id = seller.seller_id
-- ------------------------------------------------
LEFT JOIN `Temp_Agg_Reviews` reviews 
    ON orders.order_id = reviews.order_id
LEFT JOIN `product_category_name_translation` T 
    ON product.product_category_name = T.category_name_portuguese
WHERE orders.order_status = 'delivered';


select*
from Master_data;

alter table Master_data
add Country varchar(50);

update Master_data
set Country = 'Brazil';

