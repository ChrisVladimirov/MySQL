use geography;
-- 1
/*Create two tables as follows. Use appropriate data types.

`people`

person_id   first_name  salary      passport_id
1           Roberto     43300.00    102
2           Tom         56100.00    103
3           Yana        60200.00    101

`passports`

passport_id passport_number
101         N34FG21B
102         K65LO4R7
103         ZE657QP2

Insert the data from the example above.
 Alter table people and make person_id a primary key.
 Create a foreign key between people and passports by using the passport_id column.
 Think about which passport field should be UNIQUE.
 Format salary to second digit after decimal point.*/
create table `passports`
(
    `passport_id`     int primary key,
    `passport_number` varchar(10) unique
);
insert into `passports`
values (101, 'N34FG21B'),
       (102, 'K65LO4R7'),
       (103, 'ZE657QP2');
create table people
(
    `person_id`   int primary key auto_increment,
    `first_name`  varchar(10) not null,
    `salary`      decimal(10, 2),
    `passport_id` int unique
);
alter table people
    add constraint fk_people_passports
        foreign key `people` (`passport_id`)
            references `passports` (`passport_id`);
insert into `people`(`first_name`, `salary`, `passport_id`)
values ('Roberto', 43300.00, 102),
       ('Tom', 56100.00, 103),
       ('Yana', 60200.00, 101);
-- 2
/*Create two tables as follows. Use appropriate data types.

`manufacturers`

manufacturer_id     name    established_on
1                   BMW     01/03/1916
2                   Tesla   01/01/2003
3                   Lada    01/05/1966

`models`

model_id    name    manufacturer_id
101         X1      1
102         i6      1
103         Model S 2
104         Model X 2
105         Model 3 2
106         Nova    3

Insert the data from the example above.
 Add primary and foreign keys.*/
create table `manufacturers`
(
    manufacturer_id int,
    name            varchar(40),
    established_on  date
);
create table models
(
    model_id        int,
    name            varchar(40),
    manufacturer_id int
);
alter table manufacturers
    add constraint primary key (`manufacturer_id`);
alter table models
    add constraint primary key (model_id);
alter table models
    add constraint foreign key (`manufacturer_id`) references manufacturers (manufacturer_id);
insert into manufacturers(manufacturer_id, name, established_on)
values (1, 'BMW', '1916-03-01'),
       (2, 'Tesla', '2003-01-01'),
       (3, 'Lada', '1966-05-01');
insert into models(model_id, name, manufacturer_id)
values (101, 'X1', 1),
       (102, 'i6', 1),
       (103, 'Model S', 2),
       (104, 'Model X', 2),
       (105, 'Model 3', 2),
       (106, 'Nova', 3);
-- 3
/*Create three tables as follows. Use appropriate data types.
  `students`
student_id  name
1           Mila
2           Toni
3           Ron

  `exams`
exam_id     name
101         Spring MVC
102         Neo4j
103         Oracle 11g

`students_exams`
student_id      exam_id
1               101
1               102
2               101
3               103
2               102
2               103

  Insert the data from the example above.
 Add primary and foreign keys.
 Have in mind that the table student_exams should have a
composite primary key.
*/
create table `exams`
(
    `exam_id` int primary key auto_increment,
    `name`    varchar(30) not null
) auto_increment = 101;
create table `students`
(
    `student_id` int primary key auto_increment,
    `name`       varchar(30) not null
) auto_increment = 0;
create table `students_exams`
(
    `student_id` int,
    `exam_id`    int,
    primary key (student_id, exam_id),
    foreign key (student_id) references students (student_id),
    foreign key (exam_id) references exams (exam_id)
);
insert into exams(name)
values ('Spring MVC'),
       ('Neo4j'),
       ('Oracle 11g');
insert into students(student_id, name)
VALUES (1, 'Mila'),
       (2, 'Toni'),
       (3, 'Ron');
insert into students_exams(student_id, exam_id)
VALUES (1, 101),
       (1, 102),
       (2, 101),
       (3, 103),
       (2, 102),
       (2, 103);
-- 4
/*Create a single table as follows. Use appropriate data types.

`teachers`

teacher_id      name        manager_id
101             John        null
102             Maya        106
103             Silvia      106
104             Ted         105
105             Mark        101
106             Greta       101

  Insert the data from the example above.
 Add primary and foreign keys.
 The foreign key should be between manager_id and teacher_id.
  */
create table `teachers`
(
    `teacher_id` int primary key auto_increment,
    `name`       varchar(20) not null,
    `manager_id` int default null
) auto_increment = 101;
insert into teachers(name, manager_id)
VALUES ('John', null),
       ('Maya', 106),
       ('Silvia', 106),
       ('Ted', 105),
       ('Mark', 101),
       ('Greta', 101);
alter table teachers
    add constraint foreign key (manager_id) references teachers (teacher_id);
-- 5
/*Create a new database and design the following structure:*/
create table `item_types`
(
    `item_type_id` int(11) primary key auto_increment,
    `name`         varchar(50)
);
create table `items`
(
    `item_id`      int(11) primary key auto_increment,
    `name`         varchar(50),
    `item_type_id` int(11),
    foreign key (item_type_id) references item_types (item_type_id)
);
create table `cities`
(
    city_id int(11) primary key auto_increment,
    `name`  varchar(50)
);
create table customers
(
    customer_id int(11) primary key auto_increment,
    `name`      varchar(50),
    birthday    date,
    city_id     int(11),
    foreign key (city_id) references cities (city_id)
);
create table `orders`
(
    order_id    int(11) primary key auto_increment,
    customer_id int(11),
    foreign key (customer_id) references customers (customer_id)
);
create table order_items
(
    order_id int(11),
    item_id  int(11),
    primary key (order_id, item_id),
    foreign key (order_id) references orders (order_id),
    foreign key (item_id) references items (item_id)
);
-- 6
/*Create a new database and design the following structure:*/
create database university;
use university;
create table `subjects`
(
    subject_id   int(11) primary key auto_increment,
    subject_name varchar(50)
);
create table agenda
(
    student_id int(11),
    subject_id int(11),
    foreign key (subject_id) references subjects (subject_id),
    foreign key (student_id) references students (student_id)
);
create table `majors`
(
    major_id int(11) primary key auto_increment,
    `name`   varchar(50)
);
create table students
(
    student_id     int(11) primary key auto_increment,
    student_number varchar(12),
    student_name   varchar(50),
    major_id       int(11),
    foreign key (major_id) references majors (major_id)
);
create table payments
(
    payment_id     int(11) primary key auto_increment,
    payment_date   date,
    payment_amount decimal(8, 2),
    student_id     int(11),
    foreign key (student_id) references students (student_id)
);
-- 9
/*Display all peaks for &quot;Rila&quot; mountain_range. Include:
 mountain_range
 peak_name
 peak_elevation
  Peaks should be sorted by peak_elevation descending.*/
use geography;
select mountain_range, peak_name, elevation as `peak_elevation`
from peaks join mountains m on m.id = peaks.mountain_id
where mountain_id = 17
order by peak_elevation desc;