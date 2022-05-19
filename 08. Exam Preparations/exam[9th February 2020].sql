create database fsd;
use fsd;
-- 1
create table countries
(
    id   int primary key auto_increment,
    name varchar(45) not null
);
create table towns
(
    id         int primary key auto_increment,
    name       varchar(45) not null,
    country_id int         not null,
    foreign key (country_id) references countries (id)
);
create table stadiums
(
    id       int primary key auto_increment,
    name     varchar(45) not null,
    capacity int         not null,
    town_id  int         not null,
    foreign key (town_id) references towns (id)
);
create table teams
(
    id          int primary key auto_increment,
    name        varchar(45) not null,
    established date        not null,
    fan_base    bigint      not null default 0,
    stadium_id  int         not null,
    foreign key (stadium_id) references stadiums (id)
);
create table skills_data
(
    id        int primary key auto_increment,
    dribbling int default 0,
    pace      int default 0,
    passing   int default 0,
    shooting  int default 0,
    speed     int default 0,
    strength  int default 0
);
create table coaches
(
    id          int primary key auto_increment,
    first_name  varchar(10)              not null,
    last_name   varchar(20)              not null,
    salary      decimal(10, 2) default 0 not null,
    coach_level int            default 0 not null
);
create table players
(
    `id`           int primary key auto_increment,
    `first_name`   varchar(10)              not null,
    last_name      varchar(20)              not null,
    age            int            default 0 not null,
    position       char(1)                  not null,
    salary         decimal(10, 2) default 0 not null,
    hire_date      datetime,
    skills_data_id int                      not null,
    team_id        int,
    foreign key (team_id) references teams (id),
    foreign key (skills_data_id) references skills_data (id)
);
create table players_coaches
(
    player_id int,
    coach_id  int,
    foreign key (coach_id) references coaches (id),
    foreign key (player_id) references players (id),
    primary key (player_id, coach_id)
);
-- 2
insert into coaches(first_name, last_name, salary, coach_level)
    (select first_name, last_name, salary * 2, char_length(first_name)
     from players
     where age >= 45);
-- 3
update coaches
set coach_level = coach_level + 1
where first_name like 'A%'
  and (`id` between 1 and 5)
  and (first_name != 'Aesra');
-- 4
delete
from players
where age >= 45
  and id in (select coach_id from players_coaches);
#TODO:pending
-- 5
select first_name, age, salary
from players
order by salary desc;