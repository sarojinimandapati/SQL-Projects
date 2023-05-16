use gdb023;
show tables;
select * from dim_customer; 
select * from fact_gross_price;
select * from fact_manufacturing_cost;
select * from fact_pre_invoice_deductions;
select * from fact_sales_monthly;

/*1. Provide the list of markets in which customer "Atliq Exclusive" operates its
business in the APAC region.*/

select  market from dim_customer where customer="Atliq Exclusive" and region="APAC";
select * from dim_product;

/* finding how many customers in different region and sub_zone */

select count(customer_code) total_count ,customer from dim_customer 
where sub_zone="India" and region="APAC"  group by customer ;

 /*2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg*/

select prev.A as unique_products_2020,next.B as unique_products_2021,round(((B-A)/A)*100,1) as percentage_chng 
from (
(select count(distinct product_code) A from fact_gross_price where fiscal_year=2020) as prev,
(select count(distinct product_code) B from fact_gross_price where fiscal_year=2021) as next) ;

/* 3. Provide a report with all the unique product counts for each segment and
sort them in descending order of product counts. The final output contains
2 fields, segment
product_count */

select count(distinct product_code) product_count,segment from dim_product group by segment order by product_count desc;

/* 4. Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference */



with cte1 as (select count(distinct d.product_code) product_count1,d.segment as segment1 from dim_product d join fact_gross_price f on d.product_code=f.product_code 
 group by segment1, f.fiscal_year having f.fiscal_year=2020),
 cte2 as (select count(distinct d.product_code) product_count2,d.segment as segment2  from dim_product d join fact_gross_price f on d.product_code=f.product_code 
 group by segment2, f.fiscal_year having f.fiscal_year=2021)
 select cte1.segment1,cte1.product_count1 as  product_count_2020, cte2.product_count2 as  product_count_2021,(product_count2-product_count1) as difference
 from cte1 ,cte2 where cte1.segment1=cte2.segment2;

 
/* 5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost */ 

select d.product_code,d.product, f.manufacturing_cost from dim_product d join fact_manufacturing_cost f  on d.product_code=f.product_code
where manufacturing_cost = (select MAX(manufacturing_cost) from fact_manufacturing_cost) 
or  manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost) order by manufacturing_cost desc ;

/* 6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
customer_code
customer
average_discount_percentage
*/

select d.customer_code,d.customer,round(avg(f.pre_invoice_discount_pct),4) as average_discount_percentage from dim_customer d join fact_pre_invoice_deductions f on d.customer_code=f.customer_code
where d.market="India" and f.fiscal_year=2021 group by d.customer_code order by average_discount_percentage desc limit 5 ;


/* 7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount */


select month(f.date) Month ,year(f.date) Year ,sum(f2.gross_price) as Gross_sales_Amount from fact_sales_monthly f join dim_customer c 
on f.customer_code=c.customer_code join fact_gross_price f2 on  f.product_code=f2.product_code
where c.customer= "Atliq Exclusive" group by Year,Month order by Year,Month asc;

/*8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity */

select quarter(date) Quarter ,sum(sold_quantity) total_sold_quantity from fact_sales_monthly where year(date)=2020
group by Quarter order by total_sold_quantity desc;

/*9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage */


WITH Output AS
(
SELECT C.channel,
       ROUND(SUM(G.gross_price*FS.sold_quantity/1000000), 2) AS Gross_sales_mln
FROM fact_sales_monthly FS JOIN dim_customer C ON FS.customer_code = C.customer_code
						   JOIN fact_gross_price G ON FS.product_code = G.product_code
WHERE FS.fiscal_year = 2021
GROUP BY channel
)
SELECT channel, CONCAT(Gross_sales_mln,' M') AS Gross_sales_mln , CONCAT(ROUND(Gross_sales_mln*100/total , 2), ' %') AS percentage
FROM
(
(SELECT SUM(Gross_sales_mln) AS total FROM Output) A,
(SELECT * FROM Output) B
)
ORDER BY percentage DESC ;

/*10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/

with result as (select d.product_code,d.product,d.division,sum(f.sold_quantity) total_sold_quantity ,
rank() over(partition by division order by sum(f.sold_quantity) desc ) rank_order from dim_product d join fact_sales_monthly f on d.product_code= f.product_code
where f.fiscal_year=2021  group by d.product_code,d.product,d.division)
select division,product_code,product,total_sold_quantity,rank_order from result where rank_order in(1,2,3);





