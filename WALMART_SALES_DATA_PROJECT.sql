-- create database
create database walmart;
-- use database 
use walmart;

-- create table to import data in data in table 

create table walmat_data( Invoice_ID varchar(100) primary key ,Branch varchar(20 )not null, City varchar(50) not null,Customer varchar(60) not null,
Gender varchar(60) not null , Product_Line varchar(100) not null , Unit_Price  double not null , Quantity int not null ,
TaX_5per double not null , Total double not null ,Datee date not null , Timee time not null , Payment varchar(60) not null,
Cogs float not null , Gross_margin decimal(15,10) not null , Gross_income float not null , Rating decimal(4,2) not null );

-- data cleaning --------
select * from walmat_data;

-- time_of_day --------
select timee, case when timee between "00:00:00" and "12:00:00" then "Morning" when timee between "12:01:00" and "17:00:00" then "Afternoon" when timee between 
"17:01:00" and "20:00:00" then "Evening" else "Night"  end  as time_of_day from walmat_data;
-- adding new column time_of_day ------

alter  table walmat_data add  column time_of_day varchar(50) ;
update walmat_data set time_of_day = ( case when timee between "00:00:00" and "12:00:00" then "Morning" 
when timee between "12:01:00" and "17:00:00" then "Afternoon" when timee between 
"17:01:00" and "20:00:00" then "Evening" else "Night"  end )  ;
select * from walmat_data;

-- day name ----
select datee,dayname(datee) from walmat_data;
-- adding new column day_name -----
alter table walmat_data add column day_name varchar(20) ;
update walmat_data set day_name =(select  dayname(datee)) ;
 
 select *  from walmat_data;
 -- month name 
 select monthname(datee) from walmat_data;d
 
 -- adding new column month_name 
 alter table walmat_data add column month_name varchar(15) ;
 
 update walmat_data set month_name =(select monthname(datee)) ;
 select * from walmat_data;
 
 -- now anylis data and solve question -----
 
 -- Generic Question------
 
 -- -- Q1 How many unique cities does the data have?
 select count(distinct(city)) from walmat_data;
 select distinct(city) from walmat_data;
 -- -- Q2 In which city is each branch?
 select distinct(city),branch from walmat_data ;
 
 -- Q3  how many branch in each city ---
 select city ,count(branch) from  walmat_data group by city;
 
 -- PRODUCT RELATED QUESTIONS --------
 
-- Q1 How many unique product lines does the data have?
 select distinct(product_line) from walmat_data;
 
 -- Q2 What is the most common payment method?
 select payment,count(payment) as most_used_pament from walmat_data 
 group by payment order by most_used_pament desc;
 
 -- Q3 What is the most selling product line?
 select product_line,sum(quantity) as  most_selling_product from walmat_data
 group by product_line order by most_selling_product desc ;
 
 -- Q4 What is the total revenue by month?
 select month_name ,sum(quantity*unit_price) as revenue from walmat_data 
 group by month_name order by revenue desc;
 
-- Q5 What month had the largest COGS?

select month_name, sum(cogs) as cogs from walmat_data group by month_name order by cogs  desc;

-- Q6 What product line had the largest revenue?

select product_line , sum(total) as revenue from walmat_data 
group by product_line order by  revenue  desc;

-- Q7 What is the city with the largest revenue?

select city , sum(total) as revenue from walmat_data 
group by city order by  revenue  desc;

-- Q8 What product line had the largest VAT (value added tax)?
select product_line ,round(avg(tax_5per),2)as vat from walmat_data 
 group by product_line order by vat desc ;

-- Q9 Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales.

select avg(quantity) from walmat_data; -- avg sales 

select product_line,case when avg(quantity)>6 then "Good" else "Bad" end  as remark from walmat_data group by product_line;
 
-- Q10 Which branch sold more products than average product sold?

select branch, sum(quantity) from walmat_data group by branch having sum(quantity)>6; -- 6 is avg of 
-- Q11 What is the most common product line by gender? 

select product_line ,gender ,count(gender) from walmat_data
 group by product_line ,gender order by count(gender) desc ;
 
-- Q12 What is the average rating of each product line?

select product_line ,round(avg(rating),2) from walmat_data
 group by product_line;

 -- ----CUSTOMER RELATED QUESTIONS --------------
 
 -- Q1 number of sales made in each time of the day per weekday
 select time_of_day , count(*) as total_sale from walmat_data where day_name ="monday" group by time_of_day 
 order by total_sale desc ;
 -- afternoon experience most sales, the stores are 
-- filled during the afternoon hours
-- Q2 Which of the customer types brings the most revenue?

select customer , sum(total) as revenue  from walmat_data group by 
 customer order by revenue desc;

-- Q3 Which city has the largest tax percent/ VAT (Value Added Tax)?

 select  city ,round(avg(tax_5per),2) as vat from walmat_data
 group by  city order by  vat desc;
 
-- Q4  Which customer type pays the most in VAT?

 select  customer ,round(avg(tax_5per),2) as vat from walmat_data
 group by  customer order by  vat desc;
 
--  CUSTOMER RELATED QUESTIONS ------
-- Q1 How many unique customer types does the data have?

select distinct(customer) from walmat_data;

-- Q2How many unique payment methods does the data have?

select distinct(payment) from walmat_data;

--  Q3 What is the most common customer type?

select customer,count(customer) from walmat_data group by customer order by count(customer) desc ;

-- Q4 Which customer type buys the most?

select customer,sum(total)  as total from walmat_data group by customer order by total desc ;

-- Q5 What is the gender of most of the customers?
select customer,gender ,count(gender) from walmat_data group by customer, gender order by  count(gender)  desc;
-- Q6 What is the gender distribution per branch?

SELECT
	gender,branch,
	COUNT(*) as gender_cnt
FROM walmat_data
GROUP BY gender,branch;
-- Q7 Which time of the day do customers give most ratings?

select  time_of_day , avg(rating) as rating from walmat_data group by time_of_day order by  rating desc;

-- Q8 Which time of the day do customers give most ratings per branch?

select  time_of_day,branch , count(rating) as rating from walmat_data group by time_of_day,branch order by  rating desc;
--  Q9 Which day fo the week has the best avg ratings?
select day_name , avg(rating) as rating from walmat_data group by day_name order by rating desc;
-- Mon, friday and sunday  are the top best days for good ratings

 