-- 12 --
SELECT 
    `department_id`, MIN(`salary`) AS 'minimum_salary'
FROM
    `employees`
WHERE
    `department_id` IN (2 , 5, 7)
GROUP BY `department_id`
ORDER BY `department_id`;

-- 13 --
SELECT 
    `department_id`,
    CASE
        WHEN `department_id` = 1 THEN AVG(`salary`) + 5000
        ELSE AVG(`salary`)
    END AS 'avg_salary'
FROM
    `employees`
WHERE
    `salary` > 30000 AND `manager_id` != 42
GROUP BY `department_id`
ORDER BY `department_id`;

-- 14 --
SELECT `department_id`, MAX(`salary`) AS `max_salary`
FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

-- 15 --
SELECT COUNT(`salary`)
FROM `employees`
WHERE ISNULL(`manager_id`);

-- 16 --
SELECT 
    `emp`.`department_id`,
    MAX(`emp`.`salary`) AS 'third_highest_salary'
FROM
    `employees` AS `emp`
        JOIN
    (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    JOIN (SELECT 
        `e`.`department_id`, MAX(`e`.`salary`) AS `max_salary`
    FROM
        `employees` AS `e`
    GROUP BY `e`.`department_id`) AS `first_max_salary` ON `e`.`department_id` = `first_max_salary`.`department_id`
    WHERE
        `e`.`salary` < `first_max_salary`.`max_salary`
    GROUP BY `e`.`department_id`) AS `second_max_salary` ON `emp`.`department_id` = `second_max_salary`.`department_id`
WHERE
    `emp`.`salary` < `second_max_salary`.`max_salary`
GROUP BY `emp`.`department_id`
ORDER BY `emp`.`department_id`;

-- 17 --
SELECT 
    `department_id`,
    (SELECT DISTINCT
            `e2`.`salary`
        FROM
            `employees` AS `e2`
        WHERE
            `e2`.`department_id` = `e1`.`department_id`
        ORDER BY `e2`.`salary` DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM
    `employees` AS `e1`
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL;

-- 18 --
SELECT 
    `department_id`, SUM(`salary`) AS 'total_salary'
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `department_id`;