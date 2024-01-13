CREATE DATABASE `minions`;
USE `minions`;

-- 1 --
CREATE TABLE `minions`(
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    `age` INT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `towns` (
    `town_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    PRIMARY KEY (`town_id`)
);

-- 2 --
ALTER TABLE `towns` RENAME COLUMN `town_id` TO `id`;
ALTER TABLE `minions` ADD COLUMN `town_id` INT NOT NULL AFTER `age`;
ALTER TABLE `minions` ADD FOREIGN KEY `minions`(`town_id`) REFERENCES `towns`(`id`);

-- 3 --
INSERT INTO `minions`(`name`, `age`, `town_id`) VALUES ('Kevin', 22, 1), ('Bob', 15, 3), ('Steward', NULL, 2);
INSERT INTO `towns` (`name`) VALUES ('Sofia'), ('Plovdiv'), ('Varna');

-- 4 --
TRUNCATE TABLE `minions`;

-- 5 --
DROP TABLE `minions`, `towns`;