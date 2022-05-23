use soft_uni;

-- 1
/*Write a query that selects:
employee_id
job_title
address_id
address_text
Return the first 5 rows sorted by address_id in ascending order.*/

select employee_id, job_title, e.address_id, address_text
from employees e
         join addresses a on a.address_id = e.address_id
order by e.address_id
limit 5;

-- 2
/*Write a query that selects:
first_name
last_name
town
address_text
Sort the result by first_name in ascending order then by last_name. Select first 5 employees.
*/

select e.first_name, e.last_name, t.`name` as `town`, a.address_text
from employees e
         join addresses a on a.address_id = e.address_id
         left join towns t on a.town_id = t.town_id
order by first_name, last_name
limit 5;

-- 3
/*Write a query that selects:
employee_id
first_name
last_name
department_name
Sort the result by employee_id in descending order. Select only employees from the "Sales" department.*/

select employee_id, first_name, last_name, d.`name`
from employees
         join departments d on d.department_id = employees.department_id
where d.name = 'Sales'
order by employee_id desc;

-- 4
/*Write a query that selects:
employee_id
first_name
salary
department_name
Filter only employees with salary higher than 15000.
  Return the first 5 rows sorted by department_id in descending order.*/
  
select employee_id, first_name, salary, d.`name` as `department_name`
from employees e
         join departments d on d.department_id = e.department_id
where salary > 15000
order by d.department_id desc
limit 5;

-- 5
/*Write a query that selects:
employee_id
first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
*/

select e.employee_id, e.first_name
from employees e
         left join employees_projects ep on e.employee_id = ep.employee_id
where project_id is null
order by e.employee_id desc
limit 3;

-- 6
/*Write a query that selects:
first_name
last_name
hire_date
dept_name
Filter only employees hired after 1/1/1999 and from either the "Sales" or the "Finance" departments.
  Sort the result by hire_date (ascending).
*/

select e.first_name, e.last_name, e.hire_date, d.`name`
from employees as e
         join departments d on d.department_id = e.department_id
where hire_date > '1999-01-01'
  and d.name in ('Sales', 'Finance')
order by hire_date;

-- 7
/*Write a query that selects:
employee_id
first_name
project_name
Filter only employees with a project, which has started after 13.08.2002 and it is still ongoing (no end date).
  Return the first 5 rows sorted by first_name then by project_name both in ascending order.
*/

select e.`employee_id`, e.`first_name`, p.`name` as 'project_name'
from `employees` as e
         join `employees_projects` as ep
              using (`employee_id`)
         join `projects` as p
              using (`project_id`)
where date(p.`start_date`) > '2002-08-13'
  and p.`end_date` is null
order by e.`first_name`, p.`name`
limit 5;

-- 8
/*Write a query that selects:
employee_id
first_name
project_name
Filter all the projects of employees with id 24.
  If the project has started after 2005 inclusively the return value should be NULL.
  Sort the result by project_name alphabetically.*/

select e.employee_id,
       e.first_name,
       if(year(p.start_date) >= 2005, null, p.name)
           as `project_name`
from employees e
         join employees_projects ep on e.employee_id = ep.employee_id
         join projects p on p.project_id = ep.project_id
where e.employee_id = 24
order by project_name;

-- 9
/*Write a query that selects:
employee_id
first_name
manager_id
manager_name
Filter all employees with a manager who has id equal to 3 or 7.
  Return all rows sorted by employee first_name in ascending order.
*/

select e.employee_id, e.first_name, e.manager_id, e1.first_name as `manager_name`
from employees e
         join employees e1 on e.manager_id = e1.employee_id
where e.manager_id in (3, 7)
order by e.first_name;

-- 10
/*Write a query that selects:
employee_id
employee_name
manager_name
department_name
Show the first 5 employees (only for employees who have a manager) with their managers and the departments they are in (show the departments of the employees). Order by employee_id.
*/

select e.employee_id
     , concat(e.first_name, ' ', e.last_name)      as `employee_name`
     , concat_ws(' ', e1.first_name, e1.last_name) as `manager_name`
     , d.`name`                                    as `department_name`
from employees e
         join employees e1 on e.manager_id = e1.employee_id
         join departments d on d.department_id = e.department_id
where d.manager_id is not null
order by e.employee_id
limit 5;

-- 11
/*Write a query that returns the value of the lowest average salary of all departments.
*/

select (avg(salary)) as `average_salary_per_department`
from employees e
         join departments d on d.department_id = e.department_id
group by d.department_id
order by average_salary_per_department
limit 1;

-- 12
/*Write a query that selects:
country_code
mountain_range
peak_name
elevation
Filter all peaks in Bulgaria with elevation over 2835. Return all rows sorted by elevation in descending order.
*/

use geography;
select countries.country_code, mountain_range, peak_name, elevation
from countries
         join mountains_countries mc on countries.country_code = mc.country_code
         join mountains m on m.id = mc.mountain_id
         join peaks p on m.id = p.mountain_id
where countries.country_code = 'BG'
  and elevation > 2835
order by elevation desc;

-- 13
/*Write a query that selects:
country_code
mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria.
  Sort result by mountain_range count in decreasing order.*/
  
select countries.country_code, count(mountain_range) as mountain_range
from countries
         join mountains_countries mc on countries.country_code = mc.country_code
         join mountains m on m.id = mc.mountain_id
where countries.country_code in ('US', 'BG', 'RU')
group by countries.country_code
order by mountain_range desc;

-- 14
/*Write a query that selects:
country_name
river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
*/

select country_name, river_name
from countries
         left join countries_rivers cr on countries.country_code = cr.country_code
         left join rivers r on r.id = cr.river_id
where continent_code = 'AF'
order by country_name
limit 5;

-- 16
/*Find the count of all countries which don't have a mountain.
*/

select count(countries.country_code)
from countries
         left join mountains_countries mc on countries.country_code = mc.country_code
where mountain_id is null;

-- 17
/*For each country, find the elevation of the highest peak and the length of the longest river,
  sorted by the highest peak_elevation (from highest to lowest),
  then by the longest river_length (from longest to smallest),
  then by country_name (alphabetically).
  Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
*/

select c.country_name, max(p.elevation) as `highest_peak_elevation`, max(r.length) as `longest_river_length`
from countries c
        left join mountains_countries mc on c.country_code = mc.country_code
        left join peaks p on mc.mountain_id = p.mountain_id
        left join countries_rivers cr on c.country_code = cr.country_code
        left join rivers r on r.id = cr.river_id
group by c.country_name
order by highest_peak_elevation desc, longest_river_length desc, c.country_name limit 5;
