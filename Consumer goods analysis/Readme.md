# Domain:  Consumer Goods | Function: Executive Management
### Atliq Hardwares (imaginary company) is one of the leading computer hardware producers in India and well expanded in other countries too.
* However, the management noticed that they do not get enough insights to make quick and smart data-informed decisions. 
* They want to expand their data analytics team by adding several junior data analysts.
* Tony Sharma, their data analytics director wanted to hire someone who is good at both tech and soft skills. Hence, he decided to conduct a SQL challenge which will help him understand both the skills.    

# DATA
### The file provides a comprehensive overview of the tables found in the 'gdb023' (atliq_hardware_db) database. It includes information for six main tables:

1. dim_customer: contains customer-related data
2. dim_product: contains product-related data
3. fact_gross_price: contains gross price information for each product
4. fact_manufacturing_cost: contains the cost incurred in the production of each product
5. fact_pre_invoice_deductions: contains pre-invoice deductions information for each product
6. fact_sales_monthly: contains monthly sales data for each product.

#### Column Description for dim_customer table:
1. customer_code: The 'customer_code' column features unique identification codes for every customer in the dataset. These codes can be used to track a customer's saleshistory, demographic information, and other relevant details. For example, the codes could look like '70002017', '90005160', and '80007195' respectively.

2. customer: The 'customer' column lists the names of customers, for example 'Atliq Exclusive', 'Flipkart', and 'Surface Stores' etc.

3. platform: The 'platform' column identifies the means by which a company's products or services are sold. "Brick & Mortar" represents the physical store/location, and "E-Commerce" represents online platforms.

4. channel: The 'channel' column reflects the distribution methods used to sell a product. These methods include "Retailers", "Direct", and "Distributors". Retailers refer to physical or online stores that sell products to consumers. Direct sales refer to sales made directly to consumers through a company's website or other direct means, and distributors refer to intermediaries or middlemen between the manufacturer and retailer or end consumers.

5. market: The 'market' column lists the countries in which the customer is located.

6. region: The 'region' column categorizes countries according to their geographic location, including "APAC" (Asia Pacific), "EU" (Europe), "NA" (North America), and 	"LATAM" (Latin America).

7. sub_zone: "The 'sub_zone' column further breaks down the regions into sub-regions, such as "India", "ROA" (Rest of Asia), "ANZ" (Australia and New Zealand), "SE" 	Southeast Asia), "NE" (Northeast Asia), "NA" (North America), and "LATAM" (Latin America)."


#### Column Description for dim_product table:
1. product_code: The 'product_code' column features unique identification codes for each product, serving as a means to track and distinguish individual products within a 		database or system.

2. division: The 'division' column categorizes products into groups such as "P & A" (Peripherals and Accessories), "N & S" (Network and Storage) and "PC" (Personal 				 Computer).

3. segment: The 'segment' column categorizes products further within the division, such as "Peripherals" (keyboard, mouse, monitor, etc.), "Accessories" (cases, cooling solutions, power supplies), "Notebook" (laptops), "Desktop" (desktops, all-in-one PCs, etc), "Storage" (hard disks, SSDs, external storage), and "Networking" (routers, switches, modems, etc.).

4. category: The 'category' column classifies products into specific subcategories within the segment.

5. product: The 'product' column lists the names of individual products, corresponding to the unique identification codes found in the 'product_code' column.

6. variant: The "variant" column classifies products according to their features, prices, and other characteristics. The column includes variants such as "Standard", "Plus", "Premium" that represent different versions of the same product.

#### Column Description for fact_gross_price table:
1. product_code: The 'product_code' column features unique identification codes for each product.

2. fiscal_year: The 'fiscal_year' column contains the fiscal period in which the product sale was recorded. A fiscal year is a 12-month period that is used for accounting purposes and often differs from the calendar year. For Atliq Hardware, the fiscal year starts in September. The data available in this column covers the 	fiscal years 2020 and 2021.

3. gross_price: The 'gross_price' column holds the initial price of a product, prior to any reductions or taxes. It is the original selling price of the product.

#### Column Description for fact_manufacturing_cost:
1. product_code: The 'product_code' column features unique identification codes for each product

2. cost_year: The "cost_year" column contains the fiscal year in which the product was manufactured.

3. manufacturing_cost: The "manufacturing_cost" column contains the total cost incurred for the production of a product. This cost includes direct costs like
raw materials, labor, and overhead expenses that are directly associated with the production process.

#### Column Description for fact_pre_invoice_deductions:
1. customer_code: The 'customer_code' column features unique identification codes for every customer in the dataset. These codes can be used to track a customer's sales history, demographic information, and other relevant details. For example, the codes could look like '70002017', '90005160', and '80007195' respectively.

2. fiscal_year: The "fiscal_year" column holds the fiscal period when the sale of a product occurred.

3. pre_invoice_discount_pct: The "pre_invoice_discount_pct" column contains the percentage of pre-invoice deductions for each product. Pre-invoice deductions are 
discounts that are applied to the gross price of a product before the invoice is generated, and typically applied to large orders or long-term contracts.

#### Column Description for fact_sales_monthly:
1. date: The "date" column contains the date when a product was sold, in a monthly format for 2020 and 2021 fiscal years. This information can be used
to understand the sales performance of products over time.

2. product_code: The "product_code" column contains a unique identification code for each product. This code is used to track and differentiate individual 
products within a database or system.

3. customer_code: The 'customer_code' column features unique identification codes for every customer in the dataset. These codes can be used to track a customer's sales history, demographic information, and other relevant details. For example, the codes could look like '70002017', '90005160', and '80007195' respectively.

4. sold_quantity: The "sold_quantity" column contains the number of units of a product that were sold. This information can be used to understand the sales volume of products and to compare the sales volume of different products or variants.

5. fiscal_year: The "fiscal_year" column holds the fiscal period when the sale of a product occurred.

# Requests

#### 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

-> select  market from dim_customer where customer="Atliq Exclusive" and region="APAC";


<img width="120" alt="Screenshot 2023-05-16 194520" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/d163ff31-8218-4fe2-bfca-6a27272bb203">  

The above result set is the list of markets where Atliq is exclusive in the APAC region.

#### 2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,unique_products_2020unique_products_2021 percentage_chg.

<img width="295" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/0cc3c4db-8f91-4080-b365-4c46e4586c45">

#### 3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains2 fields, segment product_count



<img width="156" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/e4026efa-cedf-4426-9676-69c5ca592acd">

#### 4. Which segment had the most increase in unique products in2021 vs 2020? The final output contains these fields,segment product_count_2020 product_count_2021 difference

<img width="313" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/2d1a33c6-9676-49b6-afe2-367e4eb48b3a">

#### 5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,product_code product manufacturing_cost

<img width="274" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/c2dac960-0035-4a41-8424-7697445c9fce">

#### 6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields, customer_code customer average_discount_percentage

<img width="261" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/23180311-7134-43a1-bb7c-d06b1d25043d">

####  7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns:Month ,Year ,Gross sales Amount 

<img width="331" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/9c2d0d4d-2b95-44d3-80fd-7bd790e6cd14">

#### 8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,Quarter total_sold_quantity.

<img width="160" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/76a87876-692d-41dd-a8af-facae7ce0075">

#### 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields, channel gross_sales_mln ,percentage.

<img width="210" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/b750e825-81bc-441d-a45c-c9e8e6b854c9">

#### 10.Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these  fields,division product_code, product ,total_sold_quantity, rank_order.

<img width="365" alt="image" src="https://github.com/sarojinimandapati/SQL-Projects/assets/124454596/2c2ab0fa-8a66-429c-b852-48be443864e6">



