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
INSERT INTO `towns` (`id`, `name`) VALUES (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');
INSERT INTO `minions`(`id`,`name`, `age`, `town_id`) VALUES (1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', NULL, 2);

-- 4 --
TRUNCATE TABLE `minions`;

-- 5 --
DROP TABLE `minions`, `towns`;

-- 6 --
CREATE TABLE `people` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`name` VARCHAR(200) NOT NULL,
	`picture` BLOB(2),
	`height` DOUBLE,
	`weight` DOUBLE,
	`gender` ENUM('m', 'f') NOT NULL,
	`birthdate` DATE NOT NULL,
	`biography`TEXT,
    PRIMARY KEY(`id`)
);

INSERT INTO `people` (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUES
('Martin Sofroniev', LOAD_FILE('d:\\flower.gif'), 1.90, 120.00, 'm', '2001-08-04', 'Student'),
('George Petkov', LOAD_FILE('d:\\flower.gif'), 1.95, 121.00, 'm', '2001-08-04', 'Student'),
('Marin Petkov', LOAD_FILE('d:\\flower.gif'), 1.80, 110.00, 'm', '2001-08-04', 'Student'),
('Toshko Petrov', LOAD_FILE('d:\\flower.gif'), 1.70, 50.00, 'm', '2001-08-04', 'Student'),
('Petko Petkov', LOAD_FILE('d:\\flower.gif'), 1.60, 25.00, 'm', '2001-08-04', 'Student');

-- 7 --
CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`username` VARCHAR(20) NOT NULL UNIQUE,
	`password` VARCHAR(26) NOT NULL UNIQUE,
	`profile_picture` BLOB NULL,
	`last_login_time` DATETIME,
	`is_deleted` ENUM('true', 'false'),
    PRIMARY KEY (`id`)
);

INSERT INTO `users` (`username`, `password`, `profile_picture`, `last_login_time`, `is_deleted`)
VALUES
('martin13', '123456', NULL,  '2001-08-04 12:44:56', 'false'),
('peter12', '1234567', NULL,  '2001-08-04 12:34:26', 'false'),
('geogre11', '1234568', NULL,  '2001-08-04 12:34:26', 'false'),
('mitko10','1234569', NULL, '2001-08-04 12:34:26', 'false'),
('tedi20', '1234561', NULL, '2001-08-04 12:34:26', 'false');

-- 8 --
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`, `username`);

-- 9 --
ALTER TABLE `users`
MODIFY COLUMN `last_login_time` DATETIME
DEFAULT NOW();

-- 10 --
ALTER TABLE `users`
DROP PRIMARY KEY,
DROP COLUMN `username`,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`),
ADD COLUMN `username` VARCHAR(50) UNIQUE;

-- 11 --
CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `director_name` VARCHAR(50) NOT NULL,
    `notes` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `genres` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `genre_name` VARCHAR(50) NOT NULL,
    `notes` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `categories` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `category_name` VARCHAR(50) NOT NULL,
    `notes` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `movies` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `director_id` INT,
    `copyright_year` YEAR,
    `length` INT,
	`genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE,
	`notes` TEXT,
    PRIMARY KEY (`id`)
);

INSERT INTO `directors`(`director_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `genres`(`genre_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `categories`(`category_name`, `notes`)
VALUES 
('TestName1', 'TestNotes'),
('TestName2', 'TestNotes'),
('TestName3', 'TestNotes'),
('TestName4', 'TestNotes'),
('TestName5', 'TestNotes');

INSERT INTO `movies` (`title`)
VALUES 
('TestMovie1'),
('TestMovie2'),
('TestMovie3'),
('TestMovie4'),
('TestMovie5');

-- 12 --
CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories` (
    `id` INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    `category` VARCHAR(255) NOT NULL UNIQUE,
    `daily_rate` DOUBLE,
    `weekly_rate` DOUBLE,
    `monthly_rate` DOUBLE,
    `weekend_rate` DOUBLE
);
 
CREATE TABLE `cars` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `plate_number` VARCHAR(255) NOT NULL UNIQUE,
    `make` VARCHAR(255) NOT NULL,
    `model` VARCHAR(255) NOT NULL,
    `car_year` YEAR,
    `category_id` INT,
    `doors` INT,
    `picture` BLOB,
    `car_condition` VARCHAR(255),
    `available` VARCHAR(255)
);
 
CREATE TABLE `employees` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `notes` VARCHAR(255)
);
 
CREATE TABLE `customers` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `driver_licence_number` INT NOT NULL UNIQUE,
    `full_name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255),
    `zip_code` INT,
    `notes` VARCHAR(255)
);
 
CREATE TABLE `rental_orders` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `car_id` INT NOT NULL,
    `car_condition` VARCHAR(255),
    `tank_level` INT,
    `kilometrage_start` INT,
    `kilometrage_end` INT,
    `total_kilometrage` INT,
    `start_date` DATE,
    `end_date` DATE,
    `total_days` INT,
    `rate_applied` DOUBLE,
    `tax_rate` DOUBLE,
    `order_status` VARCHAR(255),
    `notes` VARCHAR(255)
);
 
INSERT INTO `categories` (`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
("car" , 10.2 , 80.5 , 300.4 , 10.1),
("bus" , 10.2 , 80.5 , 300.4 , 10.1),
("truck" , 10.2 , 80.5 , 300.4 , 10.1);
 
INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
VALUES
("ST5848SK" , "VW" , "Passat" , "1996" , 1 , 4 , "Very tough car" , "used car","Yes"),
("ST4383NN" , "BMW" , "318" , "1994" , 1 , 4 , "Very tough car" , "used car", "Yes"),
("A9536II" , "TOYOTA" , "COROLLA" , "2008" , 1 , 4 , "Very tough car" , "used car" ,"Yes");
 
INSERT INTO `employees` (`first_name`, `last_name`, `title` , `notes`)
VALUES
("IVAN" , "DOBKOV" , "CHIEF DEPARTMENT" , "VERY TALENTED PERSON"),
("ANTONII" , "KOSEV" , "CHIEF DEPARTMENT" , "VERY TALENTED PERSON"),
("BOYAN" , "JELQZKOV" , "CHIEF DEPARTMENT" , "VERY TALENTED PERSON");
 
INSERT INTO `customers` (`driver_licence_number`, `full_name`, `address`, `city`, `zip_code`, `notes`)
VALUES 
(255238156 , "Jechko Jechkov" , "Izgrev, 9-5-4-desen" , "Burgas" , 8000 , "Top Client"),
(102011085 , "Bat Bogi" , "Izgrev, 9-6-1-lqv" , "Burgas" , 8000 , "Top Client"),
(123456987 , "Iovkitch Nikolova" , "Izgrev, 29-1-6-desen" , "Burgas" , 8000 , "Top Client");
 
INSERT INTO `rental_orders` 
	(`employee_id`, 
    `customer_id`, 
    `car_id`, 
    `car_condition`, 
    `tank_level`, 
    `kilometrage_start`, 
    `kilometrage_end`, 
    `total_kilometrage`, 
    `start_date`, 
    `end_date`, 
    `total_days`, 
    `rate_applied`, 
    `tax_rate`, 
    `order_status`, 
    `notes`)
VALUES
(900428 , 7549 , 123 , "Poor Condition" , 1200 , 123500 , 150000 , 27000 , "2024-01-13" , "2024-01-20" , 7 , 6.7 , 70.00 , "finalized" , "the car was in good shape and the customer was polite"),
(900921 , 7743 , 321 , "Poor Condition" , 1200 , 123500 , 150000 , 27000 , "2024-01-13" , "2024-01-20" , 7 , 6.7 , 70.00 , "finalized" , "the car was in good shape and the customer was polite"),
(921117 , 6551 , 456 , "Poor Condition" , 1200 , 123500 , 150000 , 27000 , "2024-01-13" , "2024-01-20" , 7 , 6.7 , 70.00 , "finalized" , "the car was in good shape and the customer was polite");

-- 13 --
CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    PRIMARY KEY (`id`)
);

CREATE TABLE `addresses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `address_text` VARCHAR(255),
    `town_id` INT,
    PRIMARY KEY (`id`),
    CONSTRAINT FOREIGN KEY (`town_id`)
    REFERENCES `towns`(`id`)
);

CREATE TABLE `departments` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    PRIMARY KEY (`id`)
);

CREATE TABLE `employees` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(255),
    `middle_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `job_title` VARCHAR(255),
    `department_id` INT,
    `hire_date` DATE,
    `salary` DOUBLE,
    `address_id` INT,
    PRIMARY KEY (`id`),
    CONSTRAINT FOREIGN KEY (`department_id`)
    REFERENCES `departments`(`id`),
    CONSTRAINT FOREIGN KEY (`address_id`)
    REFERENCES `addresses`(`id`)
);


INSERT INTO `towns`(`name`) 
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO `departments`(`id`, `name`)
VALUES (1, 'Engineering'), (2, 'Sales'), (3, 'Marketing'), (4, 'Software Development'), (5, 'Quality Assurance');


INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1,	'2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov',	'CEO',	2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan',	'Intern', 3,	'2016-08-28',	599.88);

-- 14 --
SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- 15 --
SELECT * FROM `towns` ORDER BY `name`;
SELECT * FROM `departments` ORDER BY `name`;
SELECT * FROM `employees` ORDER BY `salary` DESC;

-- 16 --
