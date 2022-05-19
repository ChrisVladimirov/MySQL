create table account_holders
(
    id         int primary key auto_increment,
    first_name varchar(15),
    last_name  varchar(15),
    ssn        varchar(15)
);
create table accounts
(
    id                int primary key auto_increment,
    account_holder_id int,
    balance           decimal(8, 4) not null,
    foreign key (account_holder_id) references accounts (id)
);
-- 7
/*Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) that
returns 1 or 0 depending on that if the word is a comprised of the given set of letters.*/
use soft_uni;
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
    returns boolean
    deterministic
begin
    return word regexp concat('^[', set_of_letters, ']+$');
end;
select ufn_is_word_comprised('pppp', 'Guy');
-- 8
/*You are given a database schema with tables:
 account_holders(id (PK), first_name, last_name, ssn)
and
 accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. The result should be
sorted by full_name alphabetically and id ascending.
*/
create procedure usp_get_holders_full_name()
begin
    select concat(first_name, ' ', last_name) as `full_name`
    from account_holders
    order by full_name, id;
end;
-- 10
/*Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum (with
precision, 4 digits after the decimal point), yearly interest rate (double) and number of years(int). It should
calculate and return the future value of the initial sum. The result from the function must be decimal, with
percision 4.
Using the following formula:
  FV=I*((1+R)^T)
  I – Initial sum
  R – Yearly interest rate
  T – Number of years
  */
create function ufn_calculate_future_value(sum decimal(8, 4), yearly_interest_rate double, number_of_years int)
    returns decimal(8, 4)
    deterministic
begin
    return sum * (pow((1 + yearly_interest_rate), number_of_years));
end;
-- 11
/*Your task is to create a stored procedure usp_calculate_future_value_for_account that accepts as
parameters – id of account and interest rate. The procedure uses the function from the previous problem to give
an interest to a person&#39;s account for 5 years, along with information about his/her account id, first name, last name
and current balance as it is shown in the example below. It should take the account_id and the interest_rate as
parameters. Interest rate should have precision up to 0.0001, same as the calculated balance after 5 years. Be
extremely careful to achieve the desired precision!*/
create procedure usp_calculate_future_value_for_account(account_id int, interest_rate double)
begin
    select account_id,
           first_name,
           last_name,
           balance,
           ufn_calculate_future_value
               (balance, interest_rate, 5) as `balance_in_5_years`
    from accounts a
             join account_holders ah on a.account_holder_id = ah.id
    where a.id = account_id;
end;
-- 12
/*Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. The
procedure should produce exact results working with the specified precision.*/
delimiter ###
create procedure usp_deposit_money(account_id int, money_amount decimal(8, 4))
begin
    start transaction;
    if (money_amount <= 0) then
        rollback;
    else
        update accounts
        set balance = balance + money_amount
        where id = account_id;
    end if;
end###
-- 13
/*Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive
number. Work with precision up to fourth sign after decimal point. The procedure should produce exact results
working with the specified precision.*/
CREATE PROCEDURE usp_withdraw_money(current_acc_id INT, money_amount DECIMAL(20, 4))
BEGIN
    IF money_amount > 0
    THEN
        START TRANSACTION;
        update accounts a
        set a.balance = a.balance - money_amount
        where a.id = current_acc_id;
        IF (select a.balance from accounts a where a.id = current_acc_id) < 0 THEN
            ROLLBACK;
        ELSE
            COMMIT;
        END IF;
    END IF;
END;
-- 14
/*Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that
transfers money from one account to another. Consider cases when one of the account_ids is not valid, the
amount of money is negative number, outgoing balance is enough or transferring from/to one and the same
account. Make sure that the whole procedure passes without errors and if error occurs make no change in the
database.
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.*/
create procedure usp_transfer_money(from_account_id int, to_account_id int, amount decimal(20, 4))
begin
    declare sender_id int default (select id from accounts where id = from_account_id);
    declare recipient_id int default (select id from accounts where id = to_account_id);
    declare senderBalance decimal(20, 4) default (select balance from accounts where id = from_account_id);

    if amount > 0 and from_account_id != to_account_id and sender_id is not null and recipient_id is not null
        and senderBalance >= amount then
        start transaction;
        update accounts
        set balance= balance + amount
        where id = to_account_id;
        update accounts
        set balance = balance - amount
        where id = from_account_id;
        if sender_id < 0 then rollback; else commit ; end if;
    end if;
end ###