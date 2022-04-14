create database `minions`;
use minions;
#1st task
create table `minions`
(
    `id`   int primary key auto_increment,
    `name` varchar(50) not null,
    `age`  int         not null
);
create table `towns`
(
    `town_id` int primary key auto_increment,
    `name`    varchar(50)
);
#2nd task
alter table `towns`
    rename column `town_id` to `id`;
alter table `minions`
    add column `town_id` int;
/*alter table `minions`
    add constraint foreign key (town_id)
        references towns (`id`);*/
#3rd task
/*insert into `towns`(id, name)
VALUES (1, 'Sofia'),
       (2, 'Plovdiv'),
       (3, 'Varna');*/
insert into `minions`(id, name, age, town_id)
VALUES (1, 'Kevin', 22, 1),
       (2, 'Bob', 15, 3),
       (3, 'Steward', null, 2);
alter table `minions`
    modify column `age` int default null;
#4th task
truncate `minions`;
#5th task
drop table `minions`, `towns`;
#6th task
create table `people`
(
    `id`        int unique auto_increment primary key,
    `name`      varchar(200) not null,
    `picture`   blob,
    `height`    double(3, 2),
    `weight`    double(5, 2),
    `gender`    char         not null,
    `birthdate` date         not null,
    `biography` text
);
use minions;
insert into `people`(name, picture, height, weight, gender, birthdate, biography)
VALUES ('Peter', null, 1.83, 59.47, 'm', '2020-05-08', null),
       ('Jose', null, 1.56, 99.06, 'f', '2002-12-08', 'I have nothing interesting to say!'),
       ('Pepi', null, 2.08, 89.6, 'f', '2022-03-08', null),
       ('John', null, 1.93, 69.6, 'm', '2021-07-08', 'brrr'),
       ('Maria', null, 1.71, 49.02, 'f', '2019-10-03', null);
#7th task
create table `users`
(
    `id`              int unique auto_increment primary key,
    `username`        varchar(30) unique not null,
    `password`        varchar(26)        not null,
    `profile_picture` tinyblob,
    `last_login_time` time,
    `is_deleted`      boolean
);
insert into `users`(id, username, password, profile_picture, last_login_time, is_deleted)
VALUES (1, 'Pesho24', 'yfy3xg', null, '02:30', false),
       (2, 'Pesho22', 'yfy9xg', null, '03:45', true),
       (3, 'Pesho29', 'yfy5xg', null, '02:00', true),
       (4, 'Pesho26', 'yfycxg', null, '08:30', false),
       (5, 'Pesho25', 'yfy_xg', null, '02:30', true);
#8th task
alter table `users`
    drop primary key,
    add constraint pk_users primary key (id, username);
#9th task
alter table users
    modify column last_login_time timestamp default current_timestamp;
#10th task
alter table users
    drop primary key,
    add primary key (`id`),
    modify column username varchar(30) not null unique;
#11th task
create database `Movies`;
create table `directors`
(
    `id`            int primary key auto_increment,
    `director_name` varchar(30) not null,
    `notes`         text
);
create table `genres`
(
    `id`         int primary key auto_increment,
    `genre_name` varchar(30) not null,
    `notes`      text
);
create table `categories`
(
    `id`            int primary key auto_increment,
    `category_name` varchar(30) not null,
    `notes`         text
);
create table `movies`
(
    `id`             int primary key auto_increment,
    `title`          varchar(30) not null,
    `director_id`    varchar(30),
    `copyright_year` year,
    `length`         int,
    `genre_id`       int,
    `category_id`    int,
    `rating`         int,
    `notes`          text,
    constraint foreign key (genre_id) references genres (id),
    constraint foreign key (category_id) references categories (id)
);
insert into directors(id, director_name, notes)
VALUES (1, 'Sean Pen', null),
       (2, 'Lubo Neykov', null),
       (3, 'Maggie Halvajyan', null),
       (4, 'Dani DaVito', null),
       (5, 'Stephen Spielberg', null);
insert into movies(id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES (1, 'Wrong turn 24', 1, 1998, 120, 1, 2, 90, null),
       (2, 'Wrong turn 3', 5, 2008, 189, 3, 3, 89, null),
       (3, 'Wrong turn 2', 3, 2003, 90, 2, 4, 27, null),
       (4, 'Jurasic Park 3', 4, 2001, 146, 2, 5, 46, null),
       (5, 'Wrong turn 7', 2, 1999, 121, 1, 2, 20, null);
insert into categories(id, category_name, notes)
VALUES (1, 'romantic', 'this movie is not worth watching at all!'),
       (2, 'romantic', null),
       (3, 'drama', 'this movie is a total mess!'),
       (4, 'horror', 'this movie is not worth watching at all!'),
       (5, 'historic', 'this movie is not worth watching at all!');
insert into genres(id, genre_name, notes)
VALUES (1, 'thriller', null),
       (2, 'brr', null),
       (3, 'thriller', null),
       (4, 'action', null),
       (5, 'documentary', null);
#12th task
create database `car_rental`;
use car_rental;
create table `categories`
(
    `id`           int primary key auto_increment,
    `category`     varchar(30) not null,
    `daily_rate`   int,
    `weekly_rate`  int,
    `monthly_rate` int,
    `weekend_rate` int
);
create table `cars`
(
    `id`            int primary key auto_increment,
    `plate_number`  varchar(10) not null,
    `make`          varchar(10),
    `model`         varchar(10),
    `car_year`      year,
    `category_id`   int,
    `doors`         int,
    `picture`       blob,
    `car_condition` varchar(10),
    `available`     boolean
);
create table `employees`
(
    `id`         int primary key auto_increment,
    `first_name` varchar(10),
    `last_name`  varchar(10),
    `title`      varchar(10),
    `notes`      text
);
create table `customers`
(
    `id`                    int primary key auto_increment,
    `driver_license_number` varchar(10),
    `full_name`             varchar(30),
    `address`               varchar(30),
    `city`                  varchar(30),
    `zip_code`              varchar(10),
    `notes`                 text
);
create table `rental_orders`
(
    `id`                int primary key auto_increment,
    `employee_id`       int,
    `customer_id`       int,
    `car_id`            int,
    car_condition       varchar(10),
    `tank_level`        int,
    `kilometrage_start` int,
    `kilometrage_end`   int,
    `total_kilometrage` int,
    `start_date`        date,
    `end_date`          date,
    `total_days`        int,
    `rate_applied`      int,
    `tax_rate`          int,
    `order_status`      int,
    `notes`             text
);
insert into categories(id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES (1, 'brr', 1, 2, 3, 4),
       (2, 'brr2', 1, 2, 58, 47),
       (3, 'brr3', 155, 51, 47, 58);
insert into cars(id, plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES (1, 'CA7895H', null, null, 2000, 1, 4, null, null, true),
       (2, 'CA7895G', null, null, 2002, 2, 5, null, null, true),
       (3, 'CA7895Y', null, null, 2001, 3, 2, null, null, false);
insert into employees(id, first_name, last_name, title, notes)
VALUES (1, 'John', 'Smith', 'leader', null),
       (2, 'Johnatan', 'Smithie', 'recruit', null),
       (3, 'Johnie', 'Mithie', 'chief', null);
insert into customers(id, driver_license_number, full_name, address, city, zip_code, notes)
VALUES (1, 'fisfb', 'Bilbo Baggins', 'The Shire', 'Bree', null, null),
       (2, 'fisfh', 'Bosco Boffin', 'The Tree', 'Bree', null, null),
       (3, 'fisff', 'Lobelia Took', 'The River', 'Bree', null, null);
insert into rental_orders(id, employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start,
                          kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate,
                          order_status, notes)
VALUES (1, 2, 3, 3, 5, 78, 20, 40, 10000, '2012-12-14', '2013-12-15', 100, 24, null, null, null),
       (2, 2, 3, 3, 5, 78, 20, 40, 1000, '2012-12-11', '2013-12-17', 10, 26, null, null, null),
       (3, 2, 3, 3, 5, 78, 20, 40, 100, '2012-12-10', '2013-12-16', 105, 25, null, null, null);
#13th task
create database `soft_uni`;
use soft_uni;

create table `towns`
(
    `id`   int primary key auto_increment,
    `name` varchar(30)
);
create table `addresses`
(
    `id`           int primary key auto_increment,
    `address_text` varchar(10),
    `town_id`      int,
    constraint foreign key (town_id) references towns (id)
);
create table `departments`
(
    `id`   int primary key auto_increment,
    `name` varchar(30)
);
create table `employees`
(
    `id`          int primary key auto_increment,
    `first_name`  varchar(15),
    `middle_name` varchar(15),
    `last_name`   varchar(15),
    `job_title`   varchar(20),
    department_id int,
    `hire_date`   date,
    `salary`      decimal,
    `address_id`  int,
    constraint foreign key (department_id) references departments (id),
    constraint foreign key (address_id) references addresses (id)
);
insert into towns(name) value
    ('Sofia'), ('Plovdiv'),('Varna'), ('Burgas');
insert into `departments`(name)
values ('Engineering'),
       ('Sales'),
       ('Marketing'),
       ('Software Development'),
       ('Quality Assurance');
insert into employees(id, first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
values (1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
       (2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
       (3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-08', 525.25),
       (4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
       (5, 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);
#14th task
select *
from towns,
     departments,
     employees;
#15th task
select *
from `towns`
order by name asc;
select *
from `departments`
order by name asc;
select *
from `employees`
order by salary desc;
#16th task
select name from towns order by name asc;
select name from departments order by name asc;
select first_name, last_name, job_title, salary from employees order by salary desc;
#17th task
update employees
set salary = salary * 1.1;
select salary from employees;
#18th task
/*delete from `occupancies`;*/