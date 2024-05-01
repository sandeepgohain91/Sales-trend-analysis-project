
Create database If Not exists Data_analyst_assignment;

use Data_analyst_assignment;


select * from employees;
select * from products;
select * from sales limit 2500;
select * from stores;

/*1. SQL Queries:
- Write a SQL query to calculate the total sales amount by product category for the year.
- Write a SQL query to find the top 3 performing stores in terms of sales amount.
- Identify the employee with the highest sales in each store.*/

Select ProductCategory,round(sum(saleamount)) as total_sales_amount
from Products p join Sales s
on p.productid=s.productid /* Joining table products and sales using common column product id*/
group by ProductCategory
order by total_sales_amount desc;

/* The above query displays the total sales amount for each product category in the fiscal year
2023-24*/

Select sa.storeid,s.storename,round(sum(saleamount)) as total_sale_amount
from stores s join sales sa
on s.storeid=sa.storeid /* Joining tables stores and sales using common column storeid to display storename */ 
group by sa.storeid,s.storename
order by total_sale_amount desc
limit 3;

/* The above query displays the top 3 performing stores in terms of sales amount in the fiscal year
2023-24*/

/* 2. Data Analysis & RCA:
- Analyze the monthly sales data to identify any declining trends in any product category or
store.
- Perform a root cause analysis to determine possible reasons for the decline. Consider
factors such as employee turnover, product availability, regional economic factors, etc.
- Provide at least two actionable insights based on your analysis.*/

set sql_safe_updates=0;
/* Adding a column Date to have only date values without the time */
Alter table Sales
Add Date date;

/* Getting the date from the exisiting column Saledate*/
Update Sales
Set Date=DATE(SaleDate);

Select * from Sales;/* Checking whether the column has been added with the values in the right format*/


-- The query below retrieves sales data along with information about stores and products, 
-- calculates total sales amounts, and presents the results grouped by various dimensions.

SELECT
    st.region,st.location,s.storeid,st.storename,Productcategory,s.productid,
    
    -- Converting the month number from the Date column into the corresponding month name
    CASE 
        WHEN MONTH(Date) = 1 THEN 1
        WHEN MONTH(Date) = 2 THEN 2
        WHEN MONTH(Date) = 3 THEN 3
        WHEN MONTH(Date) = 4 THEN 4
        WHEN MONTH(Date) = 5 THEN 5
        WHEN MONTH(Date) = 6 THEN 6
        WHEN MONTH(Date) = 7 THEN 7
        WHEN MONTH(Date) = 8 THEN 8
        WHEN MONTH(Date) = 9 THEN 9
        WHEN MONTH(Date) = 10 THEN 10
        WHEN MONTH(Date) = 11 THEN 11
        WHEN MONTH(Date) = 12 THEN 12
    END AS Month,
    -- Calculating and rounding the total sales amount
    ROUND(SUM(SaleAmount)) AS TotalSales
FROM 
    Sales s 
JOIN 
    Products p 
ON s.productid=p.productid
join stores st
on s.storeid=st.storeid
-- Grouping the result set by specified columns 
GROUP BY 
    st.region,st.location,s.storeid,st.storename,Productcategory,s.productid,month
-- Sorting the result set in descending order based on total sales amount 
order by 
      totalsales desc;
      
      
    

  