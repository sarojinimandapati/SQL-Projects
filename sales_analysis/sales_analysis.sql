SELECT * FROM sales.date;
SELECT * FROM sales.customers;
select * from sales.markets;
select * from sales.transactions;
select * from sales.products;
select * from date;

use sales;
-- The dataset contain the data of sales from the company

show tables;
-- total 5 tabels

-- describing the structure of tables
desc customers;
desc date;
desc markets;
desc products;
desc transactions;

-- I check the null values and duplicate values in the power query ,the data is clean but it has duplicate rows in the transaction table,Ifilter the which does not affect on the original data

-- total revenue
select sum( sales_amount) as Revenue from transactions where sales_amount>=1 ;
-- total no_of sales
select sum(sales_qty) as Total_products from transactions where sales_amount>=1;

-- revenue of each market 
select m.markets_name,sum(t.sales_amount) total_revenue from markets m inner join transactions t on t.market_code=m.markets_code where m.zone is not null or m.zone="" and t.currency='USD\r' or t.currency="INR/r" and t.sales_amount>=1 group by m.markets_name order by sum(t.sales_amount) desc;
-- total sales of markets
select m.markets_name,sum(t.sales_qty) total_sales from markets m inner join transactions t on t.market_code=m.markets_code where m.zone is not null or m.zone="" and t.currency='USD\r' or t.currency="INR/r" group by m.markets_name order by sum(t.sales_qty) desc;

-- total revenue of customers
select c.custmer_name,sum(t.sales_amount) total_revenue from customers c inner join transactions t on t.customer_code=c.customer_code where t.sales_amount>=1  group by c.custmer_name order by sum(t.sales_amount) desc;

-- revenue of year
select year(order_date) year ,sum(sales_amount) as revenue from transactions where sales_amount>=1 and currency='USD\r' or currency='INR\r' group by year(order_date);

-- transactions of specific market
select markets_code,markets_name from markets; ;
select * from transactions where market_code="Mark001"; # code of chennai market

-- revenue and total_sales sold  of each market in each year
SELECT market_code,year(order_date),SUM(transactions.sales_amount) total_revenue,sum(sales_qty) total_sales FROM transactions where sales_amount>=1 and currency='USD\r' or currency='INR\r' group by market_code,year(order_date) order by market_code;

-- Monthly sales and revenue of specific year 
select date.month_name,sum(transactions.sales_amount) total_revenue,sum(transactions.sales_qty) total_sales FROM transactions INNER JOIN date ON transactions.order_date=date.date where date.year=2018 and (transactions.currency="INR\r" or transactions.currency='USD\r') and transactions.sales_amount>=1 group by date.month_name;


