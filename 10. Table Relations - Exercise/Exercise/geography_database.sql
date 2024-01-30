-- 1 --
CREATE TABLE `passports`(
`passport_id` INT PRIMARY KEY AUTO_INCREMENT,
`passport_number` VARCHAR(40) UNIQUE
);

CREATE TABLE `people`(
`person_id`INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30),
`salary` DECIMAL(9,2),
`passport_id` INT UNIQUE,
 CONSTRAINT `fk_people_passports`
FOREIGN KEY (`passport_id`)
REFERENCES `passports`(`passport_id`)
);

INSERT INTO `passports`(`passport_id`,`passport_number`)
VALUES('101',"N34FG21B"),
('102',"K65LO4R7"),
('103',"ZE657QP2");

INSERT INTO `people`(`person_id`,`first_name`,`salary`,`passport_id`)
VALUES ('1',"Roberto",'43300.00','102'),
('2',"Tom",'56100.00','103'),
('3',"Yana",'60200.00','101');

-- 2 --
CREATE TABLE `manufacturers` (
	`manufacturer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `established_on` DATE
);

CREATE TABLE `models` (
	`model_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `manufacturer_id` INT NOT NULL,
    FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers`(`id`)
);

-- 3 --
CREATE TABLE `students` (
	`student_id` INT UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE `exams` (
	`exam_id` INT UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
) AUTO_INCREMENT=101;

CREATE TABLE `students_exams` (
	`student_id` INT UNSIGNED NOT NULL,
    `exam_id` INT UNSIGNED NOT NULL
);

ALTER TABLE `students` 
ADD CONSTRAINT `pk_students` 
PRIMARY KEY (`student_id`);

ALTER TABLE `exams` 
ADD CONSTRAINT `pk_exams` 
PRIMARY KEY (`exam_id`);

ALTER TABLE `students_exams` 
ADD CONSTRAINT `pk_students_exams` 
PRIMARY KEY (`student_id`, `exam_id`),
ADD CONSTRAINT `fk_students_exams_students` 
FOREIGN KEY (`student_id`)
REFERENCES `students` (`student_id`),
ADD CONSTRAINT `fk_students_exams_exams` 
FOREIGN KEY (`exam_id`)
REFERENCES `exams` (`exam_id`);

INSERT INTO `students` (`name`)
VALUES 
	('Mila'), 
	('Toni'), 
	('Ron');

INSERT INTO `exams` (`name`)
VALUES 
	('Spring MVC'), 
	('Neo4j'), 
	('Oracle 11g');

INSERT INTO `students_exams`
VALUES  
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103);
    
-- 4 --
CREATE TABLE `teachers` (
	`teacher_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `manager_id` INT
);

INSERT INTO `teachers`(`teacher_id`, `name`, `manager_id`)
VALUES
	(101, 'John', NULL),	
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105),
	(105, 'Mark', 101),
	(106, 'Greta', 101);

ALTER TABLE `teachers`
ADD CONSTRAINT `fk_teacher_manager_id`
	FOREIGN KEY (`manager_id`)
	REFERENCES `teachers`(`teacher_id`);

-- 5 --
SELECT `mountain_range`, `peak_name`, `elevation`
FROM `mountains` AS `m`
JOIN `peaks` AS `p`
ON `m`.`id` = `p`.`mountain_id`
WHERE `m`.`mountain_range` = 'Rila'
ORDER BY `elevation` DESC;