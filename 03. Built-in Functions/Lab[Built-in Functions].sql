select extract(minute from '2012-12-24 23:59:16');
use book_library;
#1st task
/*Create a query which shows the total sum of salaries for each department. Order by department_id.
Your query should return:
• department_id*/
select title
from books
where title like 'The%'
order by id;
#2nd task
/*Write a SQL query to find books which titles start with "The" and replace the substring with 3 asterisks. Retrieve
data about the updated titles. Order the result by id.*/
update books
set title = replace(title, 'The', '***');
select title
from books
where title like '***%'
order by id;
#3rd task
/*Write a SQL query to sum prices of all books. Format the output to 2 digits after decimal point.*/
select round(sum(cost), 2)
from books;
#4th task
/*Write a SQL query to calculate the days that an author lived. Your query should return:
 Full Name – the full name of the author.
 Days Lived – days that he/she lived. NULL values mean that the author is still alive.*/
select concat_ws(' ', first_name, last_name) as 'Full Name',
       abs(timestampdiff(day, died, born))   as 'Days Lived'
from authors;
#5th task
/*Write a SQL query to retrieve titles of all the Harry Potter books. Order the information by id.*/
select title
from books
where title like 'Harry Potter%'
order by id;