CREATE TABLE IF NOT EXISTS SALES(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) NOT NULL,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
VAT float(6,4)not null,
total decimal(12,4) not null,
date datetime not null,
time TIME not null,
payment_method varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income decimal(12,4) not null,
rating float(2,1)

);

-- ----------- Feature engeneering----------- --- time_of_day-------

SELECT
  time,(
  CASE 
     WHEN 'time' BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
     WHEN 'time' BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
     ELSE 'Evening'
    END )
    AS time_of_date
  FROM sales;
  
  
  ALTER TABLE sales ADD COLUMN time_of_date varchar(30);
  SET SQL_SAFE_UPDATES =0;
  
  UPDATE sales
  SET  time_of_date=(
  CASE 
     WHEN 'time' BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
     WHEN 'time' BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
     ELSE 'Evening'
    END
  );
  
  -- ------- day_name------
  
  SELECT
  date ,
  dayname(date)
  FROM sales;
  
   ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
   
  UPDATE sales
  SET day_name=(dayname(date));
  
  -- ---------month_name------ --
   SELECT 
   date,monthname(date) from sales;
  
ALTER TABLE sales ADD COLUMN Month_name varchar(20);

UPDATE sales 
SET Month_name= monthname(date);

-- -----GENERIC----------
-- How many unique cities does the data have?

SELECT
     DISTINCT city FROM sales;
     
-- In which city is each branch--

SELECT DISTINCT branch FROM sales;


SELECT DISTINCT city, branch
FROM sales;


-- -----------Product------

SELECT COUNT(DISTINCT product_line)
FROM sales;

--       What is the most common payment method---- --
SELECT payment_method,COUNT(payment_method) AS cnt
 FROM sales
 GROUP BY payment_method
 ORDER BY cnt DESC;
 
 
 -- ------What is the most selling product line----
 SELECT product_line, COUNT(product_line) AS pd
 FROM sales
 GROUP BY product_line
 ORDER BY pd DESC;
 
 -- What is the total revenue by month--
 
 SELECT month_name, SUM(total) AS total_revenue
 FROM sales
 GROUP BY month_name
 ORDER BY total_revenue DESC;
 
 -- What month had the largest COGS ----
 
 SELECT month_name, SUM(cogs) AS COGS
 FROM sales
 GROUP BY month_name
 ORDER BY COGS DESC;
 
 --    What product line had the largest revenue---- --
 SELECT product_line,SUM(total) AS Total_revenue
 FROM sales
 GROUP BY product_line
 ORDER BY Total_revenue DESC;

--  What city had the largest revenue--
 SELECT city,branch,SUM(total) AS Total_revenue
 FROM sales
 GROUP BY city,branch
 ORDER BY Total_revenue DESC;

-- What product line had the largest VAT ---
SELECT product_line , AVG(VAT) AS avg_tax
FROM sales 
GROUP BY product_line
ORDER BY avg_tax DESC;

-- which branch sold products than average product sold

SELECT branch, SUM(quantity) AS qty
FROM sales 
GROUP BY branch
HAVING qty>(SELECT AVG(quantity) FROM sales);

-- what is the most product line by gender--

SELECT gender,product_line,
COUNT(gender) AS total_cnt
FROM sales 
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating for each product line--
SELECT product_line, ROUND(AVG(rating),2) AS rating
FROM sales 
group by product_line
ORDER BY rating DESC










