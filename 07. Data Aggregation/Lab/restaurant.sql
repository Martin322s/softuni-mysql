-- 1 --
SELECT `department_id`, COUNT(`id`) AS `Number of employees`
FROM `employees`
GROUP BY `department_id`;

-- 2 --
SELECT `department_id`, ROUND(AVG(`salary`), 2) 
FROM `employees` 
GROUP BY `department_id` 
ORDER BY `department_id`;

