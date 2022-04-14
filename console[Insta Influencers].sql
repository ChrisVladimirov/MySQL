-- 1
create database instd;
use instd;
create table users
(
    id        int primary key,
    username  varchar(30) not null unique,
    password  varchar(30) not null,
    email     varchar(50) not null,
    gender    char(1)     not null,
    age       int         not null,
    job_title varchar(40) not null,
    ip        varchar(30) not null
);
create table addresses
(
    id      int primary key auto_increment,
    address varchar(30) not null,
    town    varchar(30) not null,
    country varchar(30) not null,
    user_id int         not null,
    foreign key (user_id) references users (id)
);
create table photos
(
    id          int primary key auto_increment,
    description text          not null,
    date        datetime      not null,
    views       int default 0 not null
);
create table comments
(
    id       int primary key auto_increment,
    comment  varchar(255) not null,
    date     datetime     not null,
    photo_id int          not null,
    foreign key (photo_id) references photos (id)
);
create table users_photos
(
    user_id  int not null,
    foreign key (user_id) references users (id),
    photo_id int not null,
    foreign key (photo_id) references photos (id)
);
create table likes
(
    id       int primary key auto_increment,
    photo_id int,
    foreign key (photo_id) references photos (id),
    user_id  int,
    foreign key (user_id) references users (id)
);
-- 2
insert into addresses(address, town, country, user_id)
        (select username, `password`, ip, age from users where gender = 'M');
-- 3
update addresses
set country = (
    case
        when left(country, 1) = 'B' then 'Blocked'
        when left(country, 1) = 'T' then 'Test'
        when left(country, 1) = 'P' then 'In Progress'
        end);
#set sql_safe_mode_checks = 0;
-- 4
delete
from addresses
where id % 3 = 0;
-- 5
select username, gender, age
from users
order by age desc, username;
-- 6
select photos.id,
       photos.`date` as `date_and_time`,
       description,
       count(c.id)   as commentsCount
from photos
         left join comments c on photos.id = c.photo_id
group by photos.id
order by commentsCount desc, photos.id
limit 5;
-- 7
select concat(user_id, ' ', u.username) as `id_username`, u.email
from users_photos
         join users u on users_photos.user_id = u.id
where user_id = photo_id
order by id_username;
-- 8
select p.id                 as `photo_id`,
       count(distinct l.id) as `likes_count`,
       count(distinct c.id) as `comments_count`
from photos p
         left join comments c on p.id = c.photo_id
         left join likes l on p.id = l.photo_id
group by p.id
order by likes_count desc, comments_count desc, p.id;
-- 9
select concat(substr(description, 30), '...') as `summary`, `date`
from photos
where day(date) = 10
order by `date` desc;
-- 10
create function udf_users_photos_count(username VARCHAR(30))
    returns int
begin
    return (select count(photo_id)
            from users_photos
                     join users u on u.id = users_photos.user_id
            where u.username = username);
end;
-- 11
delimiter ##
create procedure udp_modify_user(address varchar(30), town varchar(30))
begin
    update `users`
    set age = age + 10
    where id in
          (select u.id
           from users u
                    left join addresses a on u.id = a.user_id
           where (a.address = address)
             and (a.town = town)
             and (a.user_id is not null));
end;##
select username, email, gender, age, job_title from users where username = 'eblagden21';