CREATE DATABASE `online store`;
USE `online store`;

CREATE TABLE `item_types` (
	`item_type_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `items` (
	`item_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `item_type_id` INT NOT NULL,
    CONSTRAINT `fk_item_type_id`
    FOREIGN KEY (`item_type_id`)
    REFERENCES `item_types`(`item_type_id`)
);

CREATE TABLE `cities` (
	`city_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `customers` (
	`customer_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `birthday` DATE,
    `city_id` INT NOT NULL,
    CONSTRAINT `fk_city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities`(`city_id`)
);

