-- 1 --
SELECT 
	`e`.`employee_id`, 
    CONCAT_WS(' ', `e`.`first_name`, `e`.`last_name`) AS `full_name`, 
    `d`.`department_id`, 
    `d`.`name`
FROM `employees` AS `e`
JOIN `departments` AS `d`
ON `e`.`employee_id` = `d`.`manager_id`
ORDER BY `e`.`employee_id`
LIMIT 5;

-- 2 --
SELECT `t`.`town_id`, `name`, `address_text`
FROM `addresses` AS `a`
JOIN `towns` AS `t`
ON `a`.`town_id` = `t`.`town_id` 
WHERE `t`.`name` IN (
	SELECT `name`
	FROM `towns`
	WHERE `name` IN ('Sofia', 'San Francisco', 'Carnation')
)
ORDER BY `town_id`, `address_id`;

