#0th task
create database `stc`;
use stc;
#1st task
create table `cars`
(
    `id`          int primary key auto_increment,
    `make`        varchar(20)   not null,
    `model`       varchar(20),
    `year`        int default 0 not null,
    `mileage`     int default 0,
    `condition`   char(1)       not null,
    `category_id` int           not null,
    constraint foreign key (category_id)
        references categories (id)
);
create table `courses`
(
    `id`              int primary key auto_increment,
    `from_address_id` int      not null,
    `start`           datetime not null,
    `car_id`          int      not null,
    `client_id`       int      not null,
    `bill`            decimal(10, 2) default 10,
    constraint foreign key (from_address_id)
        references addresses (id),
    foreign key (car_id) references cars (id),
    foreign key (client_id) references clients (id)
);
create table `drivers`
(
    `id`         int primary key auto_increment,
    `first_name` varchar(30) not null,
    `last_name`  varchar(30) not null,
    `age`        int         not null,
    `rating`     float default 5.5
);
create table `clients`
(
    `id`           int primary key auto_increment,
    `full_name`    varchar(50) not null,
    `phone_number` varchar(20) not null
);
create table `addresses`
(
    `id`   int primary key auto_increment,
    `name` varchar(100) not null
);
create table `categories`
(
    `id`   int primary key auto_increment,
    `name` varchar(10) not null
);
#mapping table
create table cars_drivers
(
    `car_id`    int not null,
    `driver_id` int not null,
    constraint primary key (car_id, driver_id),
    foreign key (car_id) references cars (id),
    foreign key (driver_id) references drivers (id)
);
#2nd task
insert into clients(full_name, phone_number)
select concat(first_name, ' ', last_name) as full_name, concat('(088) 9999', (id * 2)) as phone_number
from drivers
where id between 10 and 20;
#3rd task
update `cars`
set `condition` = 'C'
where (`mileage` >= 800000)
   or mileage is null and `year` <= 2010 and `make` != 'Mercedes-Benz';
#4th task
delete
from `clients`
where `id` not in (select client_id from courses)
  and char_length(`full_name`) > 3;
#5th task
select `make`, `model`, `condition`
from cars
order by `id`;
#6th task
select first_name, last_name, make, model, mileage
from drivers
         join cars_drivers cd on drivers.id = cd.driver_id
         join cars c on c.id = cd.car_id
where mileage is not null
order by mileage desc, first_name;
#7th task
-- 2
select c.id,
       make,
       mileage,
       count(co.id)        as 'count_of_courses',
       round(avg(bill), 2) as 'avg_bill'
from cars as c
         left join courses as co
                   on co.car_id = c.id
group by c.id
having count_of_courses != 2
order by count_of_courses desc, c.id;
#8th task
select full_name, count(c.id) as count_of_cars, sum(bill) as total_sum
from clients
         join courses c on clients.id = c.client_id
group by full_name
having left(full_name, 2) like '_a'
   and count_of_cars > 1
order by full_name;
#9th task
select a.`name`,
       if(hour(`start`) between 6 and 20, 'Day', 'Night')
                 as `day_time`,
       `bill`,
       `full_name`,
       `make`,
       `model`,
       ct.`name` as `category_name`
from addresses as a
         join courses co on a.id = co.from_address_id
         join clients cl on co.client_id = cl.id
         join cars cr on cr.id = co.car_id
         join categories ct on ct.id = cr.category_id
order by co.id;
#10th task
delimiter $$$
create function udf_courses_by_client(phone_num VARCHAR(20))
    returns int deterministic
begin
    declare count int default 0;
    set count = (select count(co.client_id) as `count`
                 from clients as cl
                          join courses co on cl.id = co.client_id
                 where phone_number = phone_num);
    return count;
end;
$$$
select udf_courses_by_client('(803) 6386812') as `count`;
#11th task
create procedure udp_courses_by_address(address_name varchar(100))
begin
    select a.`name`,
           cl.`full_name`,
           case
               when bill <= 20 then 'Low'
               when bill <= 30 then 'Medium'
               else 'High'
               end
               as `level_of_bill`,
           `make`,
           `condition`, c2.`name`
    from addresses as a
             join courses co on a.id = co.from_address_id
             join clients cl on cl.id = co.client_id
             join cars c on co.car_id = c.id
    join categories c2 on c.category_id = c2.id
    where a.name = address_name
    order by make, full_name;
end;
$$$
CALL udp_courses_by_address('700 Monterey Avenue');