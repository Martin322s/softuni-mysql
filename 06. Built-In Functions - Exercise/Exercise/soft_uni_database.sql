-- 1 --
SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOWER(SUBSTRING(`first_name`, 1, 2)) = 'sa'
ORDER BY `employee_id`;

-- 2 --
SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOWER(`last_name`) LIKE '%ei%'
ORDER BY `employee_id`;

-- 3 --
SELECT `first_name`
FROM `employees`
WHERE `department_id` IN (3, 10) AND YEAR(hire_date) BETWEEN 1995 AND 2005
order by `employee_id`;

-- 4 --
SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOWER(`job_title`) NOT LIKE '%engineer%'
ORDER BY `employee_id`;

-- 5 --
SELECT `name`
FROM `towns`
WHERE LENGTH(`name`) IN (5, 6)
ORDER BY `name`;

-- 6 --
SELECT `town_id`, `name`
FROM `towns`
WHERE SUBSTRING(LOWER(`name`), 1, 1) IN ('m', 'k', 'e', 'b')
ORDER BY `name`;

-- 7 --
SELECT `town_id`, `name`
FROM `towns`
WHERE LEFT(LOWER(`name`), 1) NOT IN ('r', 'b', 'd')
ORDER BY `name`;

-- 8 --
CREATE VIEW `v_employees_hired_after_2000` AS
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE YEAR(`hire_date`) > 2000;
SELECT * FROM `v_employees_hired_after_2000`;

-- 9 --
SELECT `first_name`, `last_name`
FROM `employees`
WHERE LENGTH(`last_name`) = 5;