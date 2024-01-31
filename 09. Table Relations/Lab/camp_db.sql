-- 1 --
CREATE TABLE `mountains` (
	`id` INT AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
	`mountain_id` INT NOT NULL,
    CONSTRAINT `fk_mountain_id`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountains`(`id`)
);

-- 2 --
SELECT 
	v.`driver_id`, 
    v.`vehicle_type`, 
    CONCAT(c.`first_name`, ' ', c.`last_name`) AS 'driver_name'
FROM `vehicles` AS v JOIN `campers` AS c
ON v.`driver_id` = c.`id`;

-- 3 --
SELECT 
	`starting_point`, 
    `end_point`, 
    `leader_id`, 
    CONCAT(c.`first_name`, ' ', c.`last_name`) AS 'leader_name' 
FROM `routes` AS r JOIN `campers` AS c
ON r.`leader_id` = c.`id`;

-- 4 --
DROP TABLE `mountains`, `peaks`;

CREATE TABLE `mountains` (
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT `fk_mountain_id`
    FOREIGN KEY (`mountain_id`)
    REFERENCES `mountains`(`id`)
    ON DELETE CASCADE
);

-- 5 --
CREATE TABLE `clients` (
	`id`INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100)
);

CREATE TABLE `employees` (
	`id` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`first_name` VARCHAR(100),
	`last_name` VARCHAR(100),
    `project_id` INT(11)
);

CREATE TABLE `projects` (
	`id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `client_id` INT(11),
    `project_lead_id` INT(11),
    CONSTRAINT `fk_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `clients`(`id`),
    CONSTRAINT `fk_project_lead_id`
    FOREIGN KEY (`project_lead_id`)
    REFERENCES `employees`(`id`)
);

ALTER TABLE `employees`
ADD CONSTRAINT `fk_project_id`
FOREIGN KEY (`project_id`)
REFERENCES `projects`(`id`);