-- 0
create database `sgd`;
use sgd;
-- 1
create table addresses
(
    `id`   int primary key auto_increment,
    `name` varchar(50) not null
);
create table `categories`
(
    `id`   int primary key auto_increment,
    `name` varchar(10) not null
);
create table offices
(
    `id`               int primary key auto_increment,
    workspace_capacity int not null,
    website            varchar(50),
    address_id         int not null,
    foreign key (address_id) references addresses (id)
);
create table employees
(
    `id`            int primary key auto_increment,
    first_name      varchar(30)    not null,
    last_name       varchar(30)    not null,
    age             int            not null,
    salary          decimal(10, 2) not null,
    job_title       varchar(20)    not null,
    happiness_level char           not null
);
create table teams
(
    `id`      int primary key auto_increment,
    `name`    varchar(40) not null,
    office_id int         not null,
    leader_id int unique  not null,
    foreign key (leader_id) references employees (id),
    foreign key (office_id) references offices (id)
);
create table games
(
    `id`          int primary key auto_increment,
    `name`        varchar(50)       not null unique,
    `description` text,
    rating        float default 5.5 not null,
    budget        decimal(10, 2)    not null,
    release_date  date,
    team_id       int               not null,
    foreign key (team_id) references teams (id)
);
create table games_categories
(
    game_id     int not null,
    category_id int not null,
    primary key (game_id, category_id),
    foreign key (game_id) references games (id),
    foreign key (category_id) references categories (id)
);
-- 2
insert into games(name, rating, budget, team_id)
select lower(reverse(substring(`name` from 2))) as `name`,
       `id`                                     as rating,
       leader_id * 1000                         as budget,
       `id`                                     as team_id
from teams
where id between 1 and 9;
-- 3
update employees
set salary = salary + 1000
where salary < 5000
  and age <= 39
  and id in (select leader_id from teams);
-- 4
delete
from games
where id not in (
    select game_id
    from games_categories)
  and release_date is null;
-- 5
select first_name,
       last_name,
       age,
       salary,
       happiness_level
from employees
order by salary, id;
-- 6
select t.name              as team_name,
       a.name                 address_name,
       char_length(a.name) as count_of_characters
from teams t
         join offices o on t.office_id = o.id
         join addresses a on o.address_id = a.id
where website is not null
order by t.name, a.name;
-- 7
select c.name,
       count(gc.category_id)   as `games_count`,
       round(avg(g.budget), 2) as `avg_budget`,
       max(rating)             as `max_rating`
from categories c
         join games_categories gc on c.id = gc.category_id
         join games g on gc.game_id = g.id
group by name
having max_rating >= 9.5
Order by games_count desc, c.name;
-- 8
select games.name                                          as `name`,
       release_date,
       concat(substring(description from 1 for 10), '...') as `summary`,

       case
           when month(release_date) between 1 and 3 then 'Q1'
           when month(release_date) between 4 and 6 then 'Q2'
           when month(release_date) between 7 and 9 then 'Q3'
           else 'Q4' end
                                                           as `quarter`,
       t.name                                              as `team_name`
from games
         join teams t on t.id = games.team_id
where year(release_date) = 2022
  and month(release_date) % 2 = 0
  and right(games.name, 1) = '2'
order by quarter;
-- 9
select g.name,
       if(g.budget < 50000, 'Normal budget', 'Insufficient budget')
              as `budget_level`,
       t.name as `team_name`,
       a.name as `address_name`
from games g
         join teams t on t.id = g.team_id
         join offices o on o.id = t.office_id
         join addresses a on a.id = o.address_id
where g.release_date is null
  and g.id not in (
    select game_id
    from games_categories
)
order by g.name;
-- 10
create function udf_game_info_by_name(game_name VARCHAR(20))
    returns varchar(200)
    deterministic
begin
    return (select concat('The ', g.name, ' is developed by a ', t.name, ' in an office with an address ', a.name)
            from games g
                     join teams t on t.id = g.team_id
                     join offices o on t.office_id = o.id
                     join addresses a on o.address_id = a.id
            where g.name = game_name);
end;
-- 11
create procedure udp_update_budget(min_game_rating float)
begin
    update games
    set budget       = budget + 100000,
        release_date = adddate(release_date, interval 1 year)
    where `id` not in
          (select game_id
           from games_categories)
      and rating > min_game_rating
      and release_date is not null;
end;