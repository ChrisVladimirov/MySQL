drop database if exists `gamebar`;
-- 1
/*create new database named minions.*/
create database `gamebar` default character set utf8;
-- 2
/*n the newly created database Minions add table minions (id, name, age).
  Then add new table towns (town_id, name).
  Set id and town_id columns of both tables to be primary key as constraint, id's must be auto increment. */
use gamebar;
create table `categories`
(
    `id`   int primary key not null auto_increment,
    `name` varchar(50)     not null
);
create table `products`
(
    `id`          int primary key not null auto_increment,
    `name`        varchar(50)     not null,
    `category_id` int
);
-- 3
/*Before continuing with the next assignments, rename the town_id to id using Workbench's GUI.
Do not submit this query on the Judge System.
Change the structure of the Minions table to have new column town_id that
  would be of the same type as the id column of towns table.
  Add new constraint that makes town_id foreign key and references to id column of towns table.*/
alter table products
    add constraint products_categories_id_fk
        foreign key (category_id) references categories (id);
select * from `employees`;
select *
from employees;
update `employees`
set first_name = 'Georgi'
where first_name = 'editedName';
-- 4
/*Populate both tables with sample records given in the table below.
`minions`
  id  name      age  town_id
  1   Kevin     22      1
  2   Bob       15      3
  3   Steward   NULL    2

  `towns`
  id  name
  1   Sofia
  2   Plovdiv
  3   Varna

Use only insert SQL queries.
*/
insert into `employees`(`first_name`, `last_name`)
values ('testName', 'testSurname');
delete
from employees
where first_name = 'testName';
-- 5
truncate people;
-- 6
drop table people;
-- 7
create table people(
    `id` int not null primary key ,
    `justNotes` varchar(100)
);
-- 8
insert into `employees`(`first_name`, `last_name`)
values ('Pesho', 'Peshov'),
 ('Pesho1', 'Peshov2'),
 ('Pesho2', 'Peshov1');
-- 9
alter table `employees`
add column `middle_name` varchar(50);
-- 10
alter table `products`
add constraint `fk_category_id_id` foreign key (`category_id`)
references `categories`(`id`);
alter table `employees`
modify column `middle_name` varchar(100);