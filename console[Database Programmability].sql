/*Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) that
returns 1 or 0 depending on that if the word is a comprised of the given set of letters.

  Example:
set_of_letters      word    result
oistmiahf           Sofia   1
oistmiahf           halves  0
bobr                Rob     1
pppp                Guy     0
*/
delimiter ###
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
    returns bit
    deterministic
begin
    declare i int default 1;
    declare word_length int default char_length(word);
    declare currentChar char(1);
    declare necessarySimilarities int default word_length;
    loop
        if (i < word_length) then
            set currentChar := substr(set_of_letters from i for 1);
            if (word like concat('%', currentChar, '%')) then
                set necessarySimilarities := necessarySimilarities - 1;
            end if;
            set i := i + 1;
        else
            if necessarySimilarities = 0 then
                return 1;
            else
                return 0;
            end if;
        end if;
    end loop;
end###
select ufn_is_word_comprised('pppp', 'Guy');
