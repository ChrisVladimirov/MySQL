use camp;

#1st task
/*Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
- Mountains:
 id
 name
- Peaks:
 id
 name
 mountain_id*/

create table `mountains`
(
    `id`   int primary key auto_increment,
    `name` varchar(15) not null
);
create table `peaks`
(
    `id`          int primary key,
    `name`        varchar(15),
    `mountain_id` int not null,
    constraint foreign key (mountain_id)
        references mountains (id)
);

#2nd task
/*Write a query to retrieve information about SoftUni camp&#39;s transportation organization. Get information about the
drivers (name and id) and their vehicle type.*/

select driver_id, vehicle_type, concat(first_name, ' ', last_name) as `driver_name`
from vehicles
         join campers on vehicles.driver_id = campers.id;
         
#3rd task
/*Get information about the hiking routes – starting point and ending point, and their leaders – name and id.*/

select `starting_point`, end_point, leader_id, concat(first_name, ' ', last_name) as `leader_name`
from routes
         join campers c on c.id = routes.leader_id;
         
#4th task
/*Drop tables from the task 1.
Write a query to create a one-to-many relationship between a table, holding information about
mountains (id, name) and other - about peaks (id, name, mountain_id), so that when a mountain
gets removed from the database, all his peaks are deleted too.*/

drop table mountains;
drop table peaks;
create table `mountains`
(
    `id`   int primary key auto_increment,
    `name` varchar(15) not null
);
create table `peaks`
(
    `id`          int primary key,
    `name`        varchar(15),
    `mountain_id` int not null,
    constraint foreign key (mountain_id)
        references mountains (id) on DELETE cascade
);
