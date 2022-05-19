use gringotts;
#1st task
/*Import the database and send the total count of records to Mr. Bodrog. Make sure nothing got lost.*/
select count(magic_wand_size)
from wizzard_deposits as count;
#2nd task
/*Select the size of the longest magic wand. Rename the new column appropriately.*/
select max(magic_wand_size)
from wizzard_deposits;
#3rd task
/*For wizards in each deposit group show the longest magic wand. Sort result by longest magic wand for each deposit
group in increasing order, then by deposit_group alphabetically. Rename the new column appropriately.*/
select deposit_group, max(magic_wand_size) as longest_magic_wand
from wizzard_deposits
group by deposit_group
order by longest_magic_wand, deposit_group;
#4th task
/*Select the deposit group with the lowest average wand size.*/
select deposit_group
from wizzard_deposits
group by deposit_group
having avg(magic_wand_size)
limit 1;
#5th task
/*Select all deposit groups and its total deposit sum. Sort result by total_sum in increasing order.*/
select deposit_group, sum(deposit_amount) as `total_sum`
from wizzard_deposits
group by deposit_group
order by total_sum;
#6th task
/*Select all deposit groups and its total deposit sum but only for the wizards who has their magic wand crafted by
Ollivander family. Sort result by deposit_group alphabetically.*/
select deposit_group, sum(deposit_amount) as total_sum
from wizzard_deposits
where last_name = 'Ollivander'
group by deposit_group
order by deposit_group;
#7th task
/*Select all deposit groups and its total deposit sum but only for the wizards who has their magic wand crafted by
Ollivander family. After this, filter total deposit sums lower than 150000. Order by total deposit sum in descending
order.*/
select deposit_group, sum(deposit_amount) as total_sum
from wizzard_deposits
where magic_wand_creator = 'Ollivander Family'
group by deposit_group
having total_sum < 150000
order by total_sum desc;
#8th task
/*Create a query that selects:
• Deposit group
• Magic wand creator
• Minimum deposit charge for each group
Group by deposit_group and magic_wand_creator.
Select the data in ascending order by magic_wand_creator and deposit_group.*/
select deposit_group, magic_wand_creator, min(deposit_charge)
from wizzard_deposits
group by deposit_group, magic_wand_creator
order by magic_wand_creator, deposit_group;
#9th task
/*Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
• [0-10]
• [11-20]
• [21-30]
• [31-40]
• [41-50]
• [51-60]
• [61+]
The query should return:
• Age groups
• Count of wizards in it
Sort result by increasing size of age groups.*/
select case
           when age <= 10 then '[0-10]'
           when age <= 20 then '[11-20]'
           when age <= 30 then '[21-30]'
           when age <= 40 then '[31-40]'
           when age <= 50 then '[41-50]'
           when age <= 60 then '[51-60]'
           else '[61+]'
           end  as `age_group`,
       count(*) as wizard_count
from wizzard_deposits
group by age_group
order by wizard_count;
#10th task
/*Write a query that returns all unique wizard first letters of their first names only if they have deposit of type Troll
Chest. Order them alphabetically. Use GROUP BY for uniqueness.*/
select left(first_name, 1) as `first_letter`
from wizzard_deposits
where deposit_group = 'Troll Chest'
group by first_letter
order by first_letter;
#11th task
/*Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposits groups split by
whether the deposit has expired or not. But that&#39;s not all. He wants you to select deposits with start date after
01/01/1985. Order the data descending by Deposit Group and ascending by Expiration Flag.*/
select deposit_group, is_deposit_expired, avg(deposit_interest) as `average_interest`
from wizzard_deposits
where deposit_start_date > '1985-01-01'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired;
#12th task
/*That&#39;s it! You no longer work for Mr. Bodrog. You have decided to find a proper job as an analyst in SoftUni.
It&#39;s not a surprise that you will use the soft_uni database.
Select the minimum salary from the employees for departments with ID (2,5,7) but only for those who are hired
after 01/01/2000. Sort result by department_id in ascending order.
Your query should return:
• department_id*/
use soft_uni;
select department_id, min(salary)
from employees
where department_id in (2, 5, 7)
  and hire_date > '2000-01-01'
group by department_id
order by department_id;
#13th task
/*Select all high paid employees who earn more than 30000 into a new table. Then delete all high paid employees
who have manager_id = 42 from the new table. Then increase the salaries of all high paid employees with
department_id = 1 with 5000 in the new table. Finally, select the average salaries in each department from the new
table. Sort result by department_id in increasing order.*/
create table `high_paid_employees`
as
select *
from employees
where salary > 30000
  and manager_id <> 42;
update high_paid_employees
set salary = salary + 5000
where department_id = 1;
select department_id, avg(salary) as `avg_salary`
from high_paid_employees
group by department_id
order by department_id;
#14th task
/*Find the max salary for each department. Filter those which have max salaries not in the range 30000 and 70000.
Sort result by department_id in increasing order.*/
select department_id, max(salary) as max_salary
from employees
group by department_id
having max_salary not between 30000 and 70000
order by department_id;
#15th task
/*Count the salaries of all employees who don't have a manager.*/
select count(salary)
from employees
where manager_id is null;
#16th task
/*Find the third highest salary in each department if there is such.
  Sort result by department_id in increasing order.*/
select e.department_id,
       (select distinct e1.salary
        from employees as e1
        where e.department_id = e1.department_id
        order by salary desc
        limit 2, 1) as `third_highest_salary`
from employees as e
group by e.department_id
having third_highest_salary is not null
order by e.department_id;
#17th task
/*Write a query that returns:
• first_name
• last_name
• department_id
for all employees who have salary higher than the average salary of their respective departments. Select only the
first 10 rows. Order by department_id, employee_id.*/
select e1.first_name, e1.last_name, e1.department_id
from employees as e1
         join (
    select e2.department_id, avg(e2.salary) as `salary`
    from employees as e2
    group by e2.department_id
) as `dep_average` on e1.department_id = dep_average.department_id
where e1.salary > dep_average.salary
order by e1.department_id, e1.employee_id
limit 10;
#18th task
/*Create a query which shows the total sum of salaries for each department. Order by department_id.
Your query should return:
• department_id*/
select department_id, sum(salary)
from employees
group by department_id
order by department_id;