use soft_uni;
#1st task
/*Write a SQL query to find all available information about the departments. Sort the information by id.*/
select *
from departments
order by department_id;
#2nd task
/*Write SQL query to find all department names. Sort the information by id. */
select name
from departments
order by department_id;
#3rd task
/*Write SQL query to find the first name, last name and salary of each employee. Sort the information by id.*/
select first_name, last_name, salary
from employees
order by employee_id;
#4th task
/*Write SQL query to find the first, middle and last name of each employee. Sort the information by id.*/
select first_name, middle_name, last_name
from employees
order by employee_id;
#5th task
/*Write a SQL query to find the email address of each employee. (by his first and last name).
  Consider that the email domain is softuni.bg. Emails should look like "John.Doe@softuni.bg".
  The produced column should be named "full_ email_address". */
select concat(first_name, '.', last_name, '@softuni.bg') as full_name
from employees;
#6th task
/*Write a SQL query to find all different employee's salaries.
  Show only the salaries. Sort the information by id.  */
select distinct salary
from employees
order by employee_id;
#7th task
/*Write a SQL query to find all information about the employees whose job title is "Sales Representative".
  Sort the information by id. */
select *
from employees
where job_title = 'Sales Representative'
order by employee_id;
#8th task
/*Write a SQL query to find the first name, last name and job title of all employees whose salary is in the range [20000, 30000].
  Sort the information by id.*/
select first_name, last_name, job_title
from employees
where salary >= 20000
  and salary <= 30000
order by employee_id;
#9th task
/*Write a SQL query to find the full name of all employees
  whose salary is 25000, 14000, 12500 or 23600. Full Name is combination of first,
  middle and last name (separated with single space)
  and they should be in one column called "Full Name". */
select concat(first_name, ' ', middle_name, ' ', last_name) as Full_name
from employees
where salary in (25000, 14000, 12500, 23600);
#10th task
/*Write a SQL query to find first and last names about those employees that does not have a manager.*/
select first_name, last_name
from employees
where manager_id is null;
#11th task
/*Write a SQL query to find first name, last name and salary of those employees who has salary more than 50000.
  Order them in decreasing order by salary. */
select first_name, last_name, salary
from employees
where salary > 50000
order by salary desc;
#12th task
/*Write SQL query to find first and last names about 5 best paid Employees ordered descending by their salary. */
select first_name, last_name
from employees
order by salary desc
limit 5;
#13th task
/*Write a SQL query to find the first and last names of all employees whose department ID is different from 4. */
select first_name, last_name
from employees
where department_id <> 4;
#14th task
/*Write a SQL query to sort all records in the еmployees table by the following criteria:
First by salary in decreasing order
Then by first name alphabetically
Then by last name descending
Then by middle name alphabetically
Sort the information by id.
*/
select *
from employees
order by salary desc, first_name asc, last_name desc, middle_name asc, employee_id;
#15th task
/*Write a SQL query to create a view v_employees_salaries with first name,
  last name and salary for each employee. */
create view `v_employees_salaries` as
select first_name, last_name, salary
from employees;
select *
from v_employees_salaries;
#16th task
/*Write a SQL query to create view v_employees_job_titles with full employee name and job title.
  When middle name is NULL replace it with empty string (''). */
create view `v_employees_job_titles` as
select concat(first_name, ' ', if(middle_name is not null, concat(middle_name, ' '), ''), last_name) as full_name,
       job_title
from employees;
#alternative solution using concat_ws() function:
create view `v_employees_job_titles` as
select concat_ws(' ', first_name, middle_name, last_name) as full_name, job_title
from employees;
select *
from v_employees_job_titles;
#17th task
/*Write a SQL query to find all distinct job titles. Sort the result by job title alphabetically.*/
select distinct job_title
from employees
order by job_title;
#18th task
/*Write a SQL query to find first 10 started projects.
  Select all information about them and sort them by start date, then by name.
  Sort the information by id.*/
select `project_id`, name, description, start_date, end_date
from projects
order by start_date, name, project_id
limit 10;
#19th task
/*Write a SQL query to find last 7 hired employees. Select their first, last name and their hire date. */
select first_name, last_name, hire_date
from employees
order by hire_date desc
limit 7;
#20th task
/*Write a SQL query to increase salaries of all employees that are in the Engineering,
  Tool Design, Marketing or Information Services department by 12%.
  Then select Salaries column from the Employees table.*/
update `employees`
set salary = salary + 0.12 * employees.salary
where department_id in (1, 2, 4, 11);
select salary
from employees;
#21st task
/*Display all mountain peaks in alphabetical order. */
use geography;
select peak_name
from peaks
order by peak_name asc;
#22nd task
/*Find the 30 biggest countries by population from Europe. Display the country name and population.
  Sort the results by population (from biggest to smallest), then by country alphabetically.*/
select country_name, population
from countries
where continent_code = 'EU'
order by population desc, country_name asc
limit 30;
#23rd task
/*Find all countries along with information about their currency.
  Display the country name, country code and information about its currency: either "Euro" or "Not Euro".
  Sort the results by country name alphabetically.*/
select country_name, country_code, if(currency_code = 'EUR', 'Euro', 'Not Euro')
from countries
order by country_name;
#24th task
/*Display the name of all characters in alphabetical order. */
use diablo;
select name from characters order by name;