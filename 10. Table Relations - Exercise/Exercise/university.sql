CREATE DATABASE `university`;
USE `university`;

CREATE TABLE `subjects` (
	`subject_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `subject_name` VARCHAR(50)
);

CREATE TABLE `majors` (
	`major_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE `students` (
	`student_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `student_number` VARCHAR(12),
    `student_name` VARCHAR(50),
    `major_id` INT,
    CONSTRAINT `fk_majors_students_id`
    FOREIGN KEY (`major_id`)
    REFERENCES `majors`(`major_id`)
);

