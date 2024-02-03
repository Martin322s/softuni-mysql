-- 1 --
DELIMITER $

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(40)) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE result INT;
    SET result = (
		SELECT COUNT(*)
        FROM `employees` AS `e`
        JOIN `addresses` AS `a`
        ON `e`.`address_id` = `a`.`address_id`
        JOIN `towns` AS `t`
        ON `a`.`town_id` = `t`.`town_id`
        WHERE `t`.`name` = town_name
    );
    
    RETURN result;
END $

DELIMITER ;

SELECT ufn_count_employees_by_town('Sofia');

-- 2 --
DELIMITER $

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE `employees` as `e`
    JOIN `departments` AS `d` 
    ON `e`.`department_id` = `d`.`department_id`
    SET `salary` = `salary` * 1.05
    WHERE department_name = `d`.`name`;
END $

DELIMITER ;

CALL usp_raise_salaries('Finance');
SELECT `first_name`, `salary` 
FROM `employees` AS `e`
JOIN `departments` AS `d`
ON `e`.`department_id` = `d`.`department_id`
WHERE `d`.`name` = 'Finance' 
ORDER BY `first_name`, `salary`;

-- 3 --
DELIMITER $

CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	IF ((SELECT `employee_id` FROM `employees` WHERE `employee_id` = id) IS NOT NULL) THEN
		UPDATE `employees`
		SET `salary` = `salary` * 1.05
		WHERE `employee_id` = id;
	END IF;
END $

DELIMITER ;

CALL usp_raise_salary_by_id(17);

SELECT `salary` FROM `employees` WHERE `employee_id` = 17;

