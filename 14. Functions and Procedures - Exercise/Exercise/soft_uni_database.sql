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

