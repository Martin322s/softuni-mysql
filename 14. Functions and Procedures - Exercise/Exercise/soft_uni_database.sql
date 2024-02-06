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

