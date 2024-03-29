-- 1 --
SELECT `employee_id`, `job_title`, `a`.`address_id`, `address_text`
FROM `employees` AS `e`
JOIN `addresses` AS `a`
ON `e`.`address_id` = `a`.`address_id`
ORDER BY `address_id`
LIMIT 5;

-- 2 --
SELECT `first_name`, `last_name`, `name` AS `town`, `address_text`
FROM `employees` AS `e`
JOIN `addresses` AS `a` ON `e`.`address_id` = `a`.`address_id`
JOIN `towns` AS `t` ON `t`.`town_id` = `a`.`town_id`
ORDER BY `first_name`, `last_name`
LIMIT 5;

-- 3 --
SELECT `employee_id`, `first_name`, `last_name`, `name`
FROM `employees` AS `e`
JOIN `departments` AS `d`
ON `e`.`department_id` = `d`.`department_id`
WHERE `name` = 'Sales'
ORDER BY `employee_id` DESC;

-- 4 --
