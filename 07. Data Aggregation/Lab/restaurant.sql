-- 1 --
SELECT `department_id`, COUNT(`id`) AS `Number of employees`
FROM `employees`
GROUP BY `department_id`;

-- 2 --
SELECT `department_id`, ROUND(AVG(`salary`), 2) 
FROM `employees` 
GROUP BY `department_id` 
ORDER BY `department_id`;

-- 3 --
SELECT `department_id`, ROUND(MIN(`salary`), 2) AS `Min salary`
FROM `employees`
GROUP BY `department_id`
HAVING `Min salary` > 800;

-- 4 --
SELECT COUNT(`category_id`) AS `Appetizers Count`
FROM `products`
WHERE `category_id` = 2 AND `price` > 8
GROUP BY `category_id`;

