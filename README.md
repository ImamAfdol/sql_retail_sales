# Retail Sales Analysis SQL Project

**Project Title**: Retail Sales Analysis
**Database**: `sql_project_p2`

## 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p2`
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of good sold (COGS), and total sale amount.

```sql
create database sql_project_p2;

CREATE TABLE retail_sales 
(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);
```

### 2. Data Exploration & Cleaning 

- **Record Count**: Determine the total number of records in  the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*) as total_sale from retail_sales;
select count(distinct customer_id) as customer from retail_sales;
select distinct category from retail_sales;

SELECT * from retail_sales
WHERE sale_date IS NULL OR 
      sale_time IS NULL OR 
      customer_id IS NULL OR
      gender IS NULL OR 
      age IS NULL OR 
      category IS NULL OR
      quantity IS NULL OR 
      price_per_unit IS NULL OR 
      cogs IS NULL OR
      total_sale IS NULL;

DELETE FROM retail_sales
WHERE sale_date IS NULL OR 
      sale_time IS NULL OR 
      customer_id IS NULL OR
      gender IS NULL OR 
      age IS NULL OR 
      category IS NULL OR
      quantity IS NULL OR 
      price_per_unit IS NULL OR 
      cogs IS NULL OR
      total_sale IS NULL;
```

### Data Analyst & Findings

The following sql queries were develoved to answer specific business question:

1. **Write a Sql query to retrieve all columns for sales made on '2022-11-05'**
  ``` sql
 SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
  ```

2. **write a Sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10
-- in the month of Nov 2022**:
   ``` sql
    SELECT * FROM retail_sales
    WHERE category = 'Clothing'
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND quantity >= 4;
   ```
   
3. **Write a Sql query to calculate the total sales (total_sale) for each category**:
   ``` sql
   SELECT category,
       SUM(total_sale) AS total_penjualan,
       COUNT(*) AS total_order
    FROM retail_sales
    GROUP BY category;
   ```
   
4. **Write a Sql query to find the average age of customers who purchased items from 'beauty' category**:
  ``` sql
  SELECT ROUND(AVG(age), 2) AS avg_age
  FROM retail_sales
  WHERE category = 'Beauty';
```

5. **write a Sql query to find all transactions where the total_sale is greater than 1000**:
   ``` sql
   SELECT *
    FROM retail_sales
    WHERE total_sale > 1000;
   ```

6. **write a Sql query to find the total number of transactions (transactions_id) made by each gender in each category**:
   ``` sql  
   SELECT 
    COUNT(*) AS total_transactions,
    gender,
    category
    FROM retail_sales
    GROUP BY gender, category
    ORDER BY 3;
    ```
   
 7. **Write a Sql query to calculate the average sale for each Month, find out best selling month in each year**:
    ``` sql
        SELECT 
        year,
        month,
        avg_sale
    FROM 
    (
        SELECT 
            EXTRACT(YEAR FROM sale_date) AS year,
            EXTRACT(MONTH FROM sale_date) AS month,
            AVG(total_sale) AS avg_sale,
            RANK() OVER (
                PARTITION BY EXTRACT(YEAR FROM sale_date) 
                ORDER BY AVG(total_sale) DESC
            ) AS rank
        FROM retail_sales
        GROUP BY 1, 2
    ) AS t1
    WHERE rank = 1;
    ```

8. **Write a Sql query to find the top 5 customers basen on highest total sales**:
   ``` sql
       SELECT 
        customer_id,
        SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5;
   ```

9. **Write as Sql query to find the number of unique customers who purchased item from each category**:
   ``` sql
       SELECT 
        category,
        COUNT(DISTINCT customer_id) AS unique_cst
    FROM retail_sales
    GROUP BY category;
   ```

10. **Write a Sql query to create each shift and number of orders (Example morning <=12, Afternoon between 12 & 17, Evening > 17)**:
    ``` sql
      WITH hourly_sale AS
    (
        SELECT *,
            CASE
                WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                ELSE 'Evening'
            END AS shift
        FROM retail_sales
    )
    SELECT 
        shift,
        COUNT(*) AS total_orders
    FROM hourly_sale
    GROUP BY shift;
    ```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.






   
