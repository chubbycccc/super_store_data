{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 USE project;\
\
-- --1.Have a close watch on dataset\
\
SELECT *\
FROM sales;\
\
SELECT\
     DISTINCT(country),\
     COUNT(country) AS num_countries\
FROM sales\
GROUP BY country;\
\
\
SELECT \
     DISTINCT(segment),\
     COUNT(segment) as num_segments\
FROM sales\
GROUP BY segment\
ORDER BY num_segments DESC;\
\
SELECT\
     DISTINCT(ship_mode),\
     COUNT(ship_mode) AS num_ship_mode\
FROM sales\
GROUP BY ship_mode\
ORDER BY num_ship_mode DESC;\
\
-- Standard Class is the most frequency choice\
\
SELECT\
     DISTINCT(order_id),\
     COUNT(order_id)\
FROM sales\
GROUP BY order_id;\
\
-- --CHECK Abnormal Values\
\
SELECT \
     order_date,\
     ship_date\
FROM sales\
WHERE ship_date < order_date;\
\
-- --It turned out that all the ship dates are greater than order date\
\
\
-- 2.Which segment has the largest sales in total?\
\
SELECT\
     segment,\
     ROUND(SUM(sales),2) AS total_sales\
FROM sales\
GROUP BY segment\
ORDER BY total_sales DESC;\
\
-- Consumer segment has the highest sales of more than 1.1 million.\
\
\
-- 3. Which state has the largest sales?\
SELECT\
     state,\
     ROUND(SUM(sales),2) AS total_sales\
FROM sales\
GROUP BY state\
ORDER BY total_sales DESC\
LIMIT 5;\
\
-- California contributed to the largest proportion of sales of more than 0.4 million, followed by New York and Texas\
\
\
-- 4. Which region has the largest sales\
SELECT\
     region,\
     ROUND(SUM(sales),2) AS total_sales\
FROM sales\
GROUP BY region\
ORDER BY total_sales DESC;\
\
-- --West Region has the largest sales\
\
\
-- 5.Which products sales best in each region?\
SELECT\
       region,\
	   category\
FROM       \
(SELECT \
     region,\
     category,\
     RANK() OVER (PARTITION BY region ORDER BY COUNT(*) DESC) as ranking\
FROM sales\
GROUP BY region,category) AS rank_sales\
WHERE ranking=1;\
\
-- --For all the region ,Office Supplies is most best sell product\
\
-- 6. Which category and sub category has the largest sales?\
\
SELECT\
      category,\
      sub_category,\
      ROUND(SUM(sales),2)AS total_sales\
FROM sales\
GROUP BY category, sub_category\
ORDER BY total_sales DESC\
LIMIT 5;\
\
-- Among all the main categories, the subcategory 'Telephones' under the 'Technology' category sells the best.\
\
-- 7. what is the longest ship period?\
SELECT MAX(DATEDIFF(ship_date, order_date)) AS longest_ship_period\
FROM sales;\
\
-- 8.Which year has the largest sales?\
\
SELECT\
     YEAR(order_date) AS order_year,\
     ROUND(SUM(sales),2) as year_total_sales\
FROM sales\
GROUP BY order_year\
ORDER BY year_total_sales DESC;\
\
-- --2018 has the largest sales \
\
}