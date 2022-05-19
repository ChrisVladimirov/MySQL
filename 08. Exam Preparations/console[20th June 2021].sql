select distinct c.`client_id`,
                cl.full_name
from courses as c
         join clients cl on cl.id != c.client_id
where length(full_name) > 3;

/*SELECT EXISTS*/(SELECT client_id FROM courses WHERE client_id is not null);

select distinct clients.id, clients.full_name
from clients,
     courses
where clients.id != courses.client_id;

delimiter $$$
create procedure udf_courses_by_client(phone_num VARCHAR(20))
begin
    select count(co.client_id) as `count`
    from clients as cl
             join courses co on cl.id = co.client_id
    where phone_number = phone_num;
end;
$$$
call udf_courses_by_client('(704) 2502909') /*as `count`*/;

delimiter ###
create function ufn_count_of_courses_per_client_phoneNumber(phone_number varchar(20))
    returns int
    deterministic
begin
    declare count int default 0;
    set count = udf_courses_by_client(phone_number);
    return count;
end ###;
select ufn_count_of_courses_per_client_phoneNumber('(831) 1391236');
-- ------------------------------------------------------------------------------
