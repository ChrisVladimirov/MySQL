create function myFunction(input int)
returns int
deterministic
begin
    declare
        n int default 1;
    forLoop: loop
        if
            n < 3
        then
            set n = n + input + @brr;
        end if;
        leave forLoop;
    end loop;
    return n;
end;
