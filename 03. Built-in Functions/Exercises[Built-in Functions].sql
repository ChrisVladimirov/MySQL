use soft_uni;

#1st task
/*Write a SQL query to retrieve titles of all the Harry Potter books. Order the information by id.*/

select first_name, last_name
from employees
where first_name like 'Sa%'
order by employee_id;

#2nd task
/*Write a SQL query to find first and last names of all employees whose last name contains &quot;ei&quot; (case insensitively).
Order the information by id.*/

select first_name, last_name
from employees
where last_name like '%ei%'
order by employee_id;

#3rd task
/*Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is
between 1995 and 2005 inclusively. Order the information by id.*/

select first_name
from employees
where department_id in (3, 10) && year(hire_date) between 1995 and 2005
order by employee_id;

#4th task
/*Write a SQL query to find the first and last names of all employees whose job titles does not contain &quot;engineer&quot;.
Order the information by id.*/

select first_name, last_name
from employees
where job_title not like '%engineer%'
order by employee_id;

#5th task
/*Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name.*/

select name
from towns
where char_length(name) in (5, 6)
order by name;

#6th task
/*Write a SQL query to find all towns that start with letters M, K, B or E (case insensitively). Order them
alphabetically by town name.*/

select town_id, name
from towns
where left(name, 1) in ('M', 'K', 'B', 'E')
order by name;

#7th task
/*Write a SQL query to find all towns that do not start with letters R, B or D (case insensitively). Order them
alphabetically by name.*/

select town_id, name
from towns
where left(name, 1) not in ('R', 'B', 'D')
order by name;

#8th task
/*Write a SQL query to create view v_employees_hired_after_2000 with the first and the last name of all employees
hired after 2000 year. Select all from the created view.*/

create view `v_employees_hired_after_2000` as
select `first_name`, `last_name`
from `employees`
where year(`hire_date`) > 2000;

#9th task
/*Write a SQL query to find the first and last names of all employees whose last name is exactly 5 characters long.*/

select first_name, last_name
from employees
where char_length(last_name) = 5;

#10th task
/*Find all countries that hold the letter &#39;A&#39; in their name at least 3 times (case insensitively), sorted by ISO code.
Display the country name and the ISO code.*/

use geography;
select country_name, iso_code
from countries
where country_name like '%a%a%a%'
order by iso_code;

#11th task
/*Combine all peak names with all river names, so that the last letter of each peak name is the same as the first letter
of its corresponding river name. Display the peak name, the river name, and the obtained mix(converted to lower
case). Sort the results by the obtained mix alphabetically.*/

select peak_name,
       river_name,
       (lower(concat(peak_name, substring(river_name, 2)))) as 'mix'
from peaks,
     rivers
where right(peak_name, 1) = left(river_name, 1)
order by mix
limit 81;

#12th task
/*Find the top 50 games ordered by start date, then by name. Display only the games from the years 2011 and 2012.
Display the start date in the format &quot;YYYY-MM-DD&quot;.*/

use diablo;
select g.name, date_format(g.start, '%Y-%m-%d') as 'start'
from games as g
where year(g.start) in (2011, 2012)
order by g.start, g.name
limit 50;

#13th task
/*Find information about the email providers of all users. Display the user_name and the email provider. Sort the
results by email provider alphabetically, then by username.*/

select user_name,
       substring(email from (locate('@', email) + 1) for 100) as `Email provider`
from users
order by `Email provider`, user_name;

#14th task
/*Find the user_name and the ip_address for each user, sorted by user_name alphabetically. Display only the rows,
where the ip_address matches the pattern: &quot;___.1%.%.___&quot;.*/

select user_name, ip_address
from users
where ip_address like '___.1%.%.___'
order by user_name;

#15th task
/*Find all games with their corresponding part of the day and duration. Parts of the day should be Morning (start
time is >= 0 and < 12), Afternoon (start time is >= 12 and < 18), Evening (start time is >= 18 and < 24). Duration
should be Extra Short (smaller or equal to 3), Short (between 3 and 6 including), Long (between 6 and 10 including)
and Extra Long in any other cases or without duration.*/

select name,
       case
           when hour(start) >= 0 and hour(start) < 12 then 'Morning'
           when hour(start) >= 12 and hour(start) < 18 then 'Afternoon'
           when hour(start) >= 18 and hour(start) < 24 then 'Evening'
           end
           as `Part of the Day`,
       case
           when duration <= 3 then 'Extra Short'
           when duration > 3 and duration <= 6 then 'Short'
           when duration > 6 and duration <= 10 then 'Long'
           when duration IS NULL or duration > 10 then 'Extra Long'
           end
           as `Duration`
from games;

#16th task
/*You are given a table orders (id, product_name, order_date) filled with data. Consider that the payment for an
order must be accomplished within 3 days after the order date. Also the delivery date is up to 1 month. Write a
query to show each product&#39;s name, order date, pay and deliver due dates.*/

use orders;
select product_name,
       order_date,
       adddate(order_date, interval 3 day)   as 'pay_due',
       adddate(order_date, interval 1 month) as 'deliver_due'
from orders;
