-- 1 --
DELIMITER $

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE `salary` > 35000
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $

DELIMITER ;

CALL usp_get_employees_salary_above_35000();

-- 2 --
DELIMITER $

CREATE PROCEDURE usp_get_employees_salary_above(given_salary DECIMAL(10, 4))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE `salary` >= given_salary
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $

DELIMITER ;

CALL usp_get_employees_salary_above(45000);

-- 3 --
DELIMITER $

CREATE PROCEDURE usp_get_towns_starting_with(symbol VARCHAR(50))
BEGIN
	SELECT `name`
    FROM `towns`
    WHERE LEFT(LOWER(`name`), LENGTH(symbol)) = LOWER(symbol)
    ORDER BY `name`;
END $

DELIMITER ;

CALL usp_get_towns_starting_with('b');

-- 4 --
DELIMITER $

CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees` AS `e`
    JOIN `addresses` AS `a`
    ON `e`.`address_id` = `a`.`address_id`
    JOIN `towns` AS `t`
    ON `a`.`town_id` = `t`.`town_id`
    WHERE `t`.`name` = town_name
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $

DELIMITER ;

CALL usp_get_employees_from_town('Sofia');

-- 5 --
DELIMITER $

CREATE FUNCTION ufn_get_salary_level(salary_input INT) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(10);
    IF salary_input < 30000 THEN 
		SET salary_level = "Low";
	ELSEIF salary_input >= 30000 AND salary_input <= 50000 THEN 
		SET salary_level = "Average";
	ELSE
		SET salary_level = "High";
    END IF;
    RETURN salary_level;
END $

DELIMITER ;

SELECT `salary`, ufn_get_salary_level(`salary`) AS `salary_level`
FROM `employees`;

-- 6 --
DELIMITER $

CREATE PROCEDURE `usp_get_employees_by_salary_level` (salary_level VARCHAR(7))
BEGIN
SELECT `first_name`, `last_name`
FROM `employees`
WHERE ufn_get_salary_level(`salary`) = salary_level
ORDER BY `first_name` DESC, `last_name` DESC;
END $

DELIMITER ;

-- 7 --
DELIMITER $
 
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50)) RETURNS TINYINT
DETERMINISTIC
BEGIN
	DECLARE i INT;
	SET i := 1;
	loop1: LOOP
		IF (LOCATE(SUBSTR(word, i, 1), set_of_letters) = 0) THEN
			RETURN 0;
			LEAVE loop1;
		END IF;
		SET i := i + 1;
		IF (i = CHAR_LENGTH(word) + 1) THEN
			LEAVE loop1;
		END IF;
		END LOOP loop1;
		RETURN 1;
END $

DELIMITER ;

-- 8 --
DELIMITER $

CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT_WS(' ', `first_name`, `last_name`) AS `full_name`
	FROM `account_holders`
	ORDER BY `full_name`, `id`;
END $

DELIMITER ;

-- 9 --
DELIMITER $

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(more_balance DECIMAL(19, 4))
DETERMINISTIC
BEGIN
	SELECT `first_name`, `last_name`
	FROM `account_holders` AS `ah1`
	WHERE (
			SELECT SUM(`balance`) 
			FROM `account_holders` AS `ah`
			JOIN `accounts` AS `a` 
            ON `ah`.`id` = `a`.`account_holder_id`
			WHERE `ah`.`id` = `ah1`.`id`
			GROUP BY `ah`.`id`) > `more_balance`
			ORDER BY `ah1`.`id`;
END $

DELIMITER ;

-- 10 --
CREATE FUNCTION ufn_calculate_future_value(`sum` DECIMAL(19, 4), interest_rate DOUBLE, years INT)
RETURNS DECIMAL(19, 4)
DETERMINISTIC
RETURN `sum`* POW(1 + interest_rate, years);

-- 11 --
DELIMITER $

CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest_rate DECIMAL(19, 4))
DETERMINISTIC
BEGIN
	SELECT 
		`a`.`id`, 
        `first_name`, 
        `last_name`, 
        `balance` AS `current_balance`, 
        ufn_calculate_future_value(balance, interest_rate, 5) AS `balance_in_5_years`
	FROM `accounts` AS `a`
	JOIN `account_holders` AS `ah` ON `a`.`account_holder_id` = `ah`.`id`
	WHERE `a`.`id` = `id`;
END $

DELIMITER ;

-- 12 --
DELIMITER $

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
	IF((SELECT count(`a`.`id`) 
    FROM `accounts` AS `a` 
    WHERE `a`.`id` = account_id) != 1 OR money_amount < 0) THEN
	ROLLBACK;
	ELSE
		UPDATE `accounts`
        SET `balance` = `balance` + `money_amount`
		WHERE `accounts`.`id` = account_id;
	END IF; 
END $

DELIMITER ;

-- 13 --
DELIMITER $

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
	IF((SELECT count(`a`.`id`) 
		FROM `accounts` AS `a` 
        WHERE `a`.`id` = account_id) != 1 OR money_amount < 0 OR (
			SELECT `balance` 
            FROM `accounts` AS `a` 
            WHERE `a`.`id` = account_id) < money_amount) 
		THEN
		ROLLBACK;
	ELSE
		UPDATE `accounts` 
        SET `balance` = `balance` - money_amount
		WHERE `accounts`.`id` = account_id;
	END IF; 
END $

DELIMITER ;

-- 14 --
DELIMITER $

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
	IF((SELECT count(`a`.`id`) FROM `accounts` AS `a` WHERE `a`.`id` = to_account_id) != 1 
    OR (SELECT count(`a`.`id`) FROM `accounts` AS `a` WHERE `a`.`id` = from_account_id) != 1 
    OR amount < 0 
    OR (SELECT `balance` FROM `accounts` AS `a` WHERE `a`.`id` = from_account_id) < amount
    OR from_account_id = to_account_id
    ) 
    THEN
	ROLLBACK;
	ELSE
		UPDATE `accounts`
        SET `balance` = `balance` - amount
		WHERE `accounts`.`id` = from_account_id;
        UPDATE `accounts` 
        SET `balance` = `balance` + amount
		WHERE `accounts`.`id` = to_account_id;
	END IF; 
END $

DELIMITER ;

