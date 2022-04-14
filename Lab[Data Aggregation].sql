use restaurant;
#1st task
/*Write a query to count the number of employees in each department by id. Order the information by
deparment_id, then by Number of employees.
*/
select department_id, count(id)
from employees
group by department_id;
#2nd task
/*Write a query to calculate the average salary in each department. Order the information by department_id.
Round the salary result to two digits after the decimal point.
*/
select department_id, round(avg(salary), 2)
from employees
group by department_id;
#3rd task
/*Write a query to retrieve information about the departments grouped by department_id with minimum salary
higher than 800. Round the salary result to two digits after the decimal point.*/
select department_id, min(salary) as `Min Salary`
from employees
group by department_id
having `Min Salary` > 800;
#4th task
/*Write a query to retrieve the count of all appetizers (category id = 2) with price higher than 8.*/
select count(id)
from products
where category_id = 2
  and price > 8;
#5th task
/*Write a query to retrieve information about the prices of each category. The output should consist of:
 Category_id
 Average Price
 Cheapest Product
 Most Expensive Product
See the examples for more information. Round the results to 2 digits after the decimal point.*/
select category_id,
       round(avg(price), 2) as `Average Price`,
       round(min(price), 2) as `Cheapest Product`,
       round(max(price), 2) as `Most Expensive Product`
from products
group by category_id;