CREATE TABLE retail_sales(
         transaction_id INT PRIMARY KEY,
		 sale_date DATE,
		 sale_time TIME,
		 customor_id INT,
		 gender VARCHAR(70),
		 age INT,
		 category VARCHAR(90),
		 quantity INT,
		 price_per_unit FLOAT,
		 cogs FLOAT,
		 total_sale FLOAT		 
);

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
WHERE transaction_id IS NULL


SELECT * FROM retail_sales
WHERE transaction_id IS NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL
OR 
customor_id IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR 
price_per_unit IS NULL
OR
cogs IS NULL


DELETE FROM retail_sales
WHERE
transaction_id IS NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL
OR 
customor_id IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR 
price_per_unit IS NULL
OR
cogs IS NULL


-- How Many Uniqe Coustmer We Have

    SELECT COUNT(DISTINCT customor_id) FROM retail_sales

-- How Many Uniqe Category We Have

   SELECT COUNT(DISTINCT category) FROM retail_sales

-- Business Probelems

-- 1) Write a sql query to retrieve all columns for sales made on '2022-11-05'

      SELECT * FROM retail_sales
	  WHERE sale_date='2022-11-05';

-- 2) Write a SQL Query to retrieve all transactions where the category is 'Clothing' and 
--    the quantity sold by more than 10 in the month of Nov-2022

    SELECT * FROM retail_sales
	WHERE 
	category='Clothing' 
	AND 
	TO_CHAR(sale_date,'MMMM-YY')='2022-11'
	AND 
    quantity>=4

-- 3) Write a SQL query to calculate the total sales AND total_order  for each category

      SELECT category,SUM(total_sale) AS total_sales, COUNT(*) AS total_order
	  FROM retail_sales
	  GROUP BY category


-- 4) Write a query to find the average Age of Coustmer who purchased items from the 
--    'Beauty' Category.

       SELECT ROUND(AVG(age),2)AS average_age 
	   FROM retail_sales
	   WHERE category='Beauty'
	   
-- 5) Write a SQL query to find all transactios where the total_sales is greater than 1000

	   SELECT * FROM retail_sales
	   WHERE total_sale>1000

-- 6) Write a SQL query to find the total number of transactions made by each gender in each category

       SELECT category,gender,COUNT(*) AS total_transaction
	   FROM retail_sales
	   GROUP BY 1,2
	   ORDER BY 3 DESC
      
-- 7) Write a SQL query to Calculate the average sale for each month
--    Find Out Best Selling Month In Each Year
      SELECT years,Months,total_average FROM(
	                 SELECT EXTRACT(YEAR FROM sale_date) AS years,
	                 EXTRACT(MONTH FROM sale_date) AS Months, 
			         ROUND(AVG(total_sale)::NUMERIC,2) AS total_average,
			         ROW_NUMBER() OVER( PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY ROUND(AVG(total_sale)::NUMERIC,2) ) AS row_rank
	                 FROM retail_sales
	                 GROUP BY 1,2
					 )
					 WHERE row_rank=1

-- 8) Write a SQL To Find the Top 5 Costmers Based On the Higest Total sales

	   SELECT customor_id,SUM(total_sale) 
	   FROM retail_sales
	   GROUP BY customor_id
	   ORDER BY 2 DESC



---------- Mr.Kartik Mate Patil (Data Analyst)
        
-- 9) Write a SQL Query to Find The Number Of Unique Customers Who Purchased Ites From Each Category

	  SELECT category,COUNT(customor_id) FROM retail_sales
	  GROUP BY 1

-- 10) Write a SQL Query to Create Each Shift And Number Of Orders (Example Morning>12 , Afternoon between 12 & 17,Eveining>17)

	  WITH CTE AS(
      SELECT *,CASE
	               WHEN EXTRACT(HOUR FROM sale_time)>12 THEN'Morning'
				   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN'Afternoon'
				   ELSE'Eveining'
				   END AS Shift
				FROM retail_sales
		    )

			SELECT Shift,COUNT(*) AS total_count FROM CTE
			GROUP BY Shift
	               
	  
	  














