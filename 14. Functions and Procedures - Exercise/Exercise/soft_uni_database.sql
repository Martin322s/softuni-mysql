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

