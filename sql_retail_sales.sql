-- Create table
drop table if exists retail_sales;	
create table retail_sales 
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

alter table retail_sales
rename column quantiy to quantity;

SELECT * from retail_sales
limit 10

SELECT 
	count(*) 
from retail_sales

-- Mencari Nilai null
SELECT * from retail_sales
where transactions_id is null

SELECT * from retail_sales
where sale_date is null

SELECT * from retail_sales
where sale_time is null

SELECT * from retail_sales
where 
	transactions_id is null
	OR
	sale_date is null
	OR
	sale_time is null
	OR
	gender is null
	OR
	category is null
	OR
	quantiy is null
	OR
	cogs is null
	OR 
	total_sale is null

	-- menghapus data yang bernilai null
	delete from retail_sales
	where 
	transactions_id is null
	OR
	sale_date is null
	OR
	sale_time is null
	OR
	gender is null
	OR
	category is null
	OR
	quantiy is null
	OR
	cogs is null
	OR 
	total_sale is null

	-- Data Exploration

	-- how many sales we have 
	select count(*) as total_sale from retail_sales;

	-- how many customers we have ?
	select count(distinct customer_id) as customer from retail_sales;

	select distinct category from retail_sales;

-- My analyst & Findings

-- 1. Write a Sql query to retrieve all columns for sales made on '2022-11-05'
select 
	* 
from retail_sales
where sale_date = '2022-11-05';

-- 2.  write a Sql query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10
-- in the month of Nov 2022
select 
	*
from retail_sales
where category = 'Clothing'
	And
	To_char(sale_date, 'YYYY-MM') = '2022-11'
	And 
	quantity >= 4

-- 3. Write a Sql query to calculate the total sales (total_sale) for each category
select 
	category,
	sum(total_sale) as total_penjualan,
	count(*) as total_order
from retail_sales
group by category

-- 4. Write a Sql query to find the average age of customers who purchased items from 'beauty' category
select 
	round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'

-- 5. write a Sql query to find all transactions where the total_sale is greater than 1000
select *
from retail_sales
where total_sale > 1000

-- 6. write a Sql query to find the total number of transactions (transactions_id) made by each gender in each category
select 
	count(*) as total_transactions,
	gender,
	category
from retail_sales
group by gender, category
order by 3

-- 7. Write a Sql query to calculate the average sale for each Month, find out best selling month in each year
select 
	year,
	month,
	avg_sale
from 
(
select 
	EXTRACT(Year from sale_date) as year,
	EXTRACT(Month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() OVER(PARTITION BY EXTRACT(Year from sale_date) ORDER BY AVG(total_sale) desc) as rank
from retail_sales
group by 1, 2
) as t1
where rank = 1
-- order by 1, 3 desc

-- 8. Write a Sql query to find the top 5 customers basen on highest total sales
select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

-- 9. Write as Sql query to find the number of unique customers who purchased item from each category
select 
	category,
	count(distinct customer_id) as unique_cst
from retail_sales
group by category

-- 10. Write a Sql query to create each shift and number of orders (Example morning <=12, Afternoon between 12 & 17, Evening > 17)
with hourly_sale
as
(
select *,
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	End as shift
from retail_sales
)
select 
	shift,
	count(*) as total_orders
from hourly_sale
group by shift

-- End of Project
