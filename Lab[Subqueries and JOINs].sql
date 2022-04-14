-- miscellaneous
use soft_uni;
set @brr := 'brr';
-- 1
/*Write a query to retrieve information about the managers – id, full_name, deparment_id and department_name.
  Select the first 5 departments ordered by employee_id.*/
select e.employee_id,
       concat_ws(' ', e.first_name, e.last_name)
                as full_name,
       d.department_id,
       d.`name` as department_name
from employees as e
        join departments d on d.manager_id = e.employee_id
order by employee_id
limit 5;
-- 2
/*Write a query to get information about the addresses in the database,
  which are in San Francisco, Sofia or Carnation.
  Retrieve town_id, town_name, address_text. Order the result by town_id, then by address_id. */
select addresses.town_id, `name`, address_text
from addresses
         join towns t on t.town_id = addresses.town_id
where name in ('San Francisco', 'Sofia', 'Carnation')
order by town_id, address_id;
-- 3
/*Write a query to get information about employee_id, first_name, last_name, department_id
  and salary for all employees who don't have a manager. */
select employee_id, first_name, last_name, department_id, round(salary, 0) as salary
from employees
where manager_id is null;
-- 4
/*Write a query to count the number of employees who receive salary higher than the average.*/
select count(e.employee_id) as `count`
from employees as e
where e.salary > (select avg(salary) from employees);