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

CREATE TABLE `orders` (
	`order_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `order_items` (
	`order_id` INT NOT NULL,
    `item_id` INT NOT NULL,
    CONSTRAINT `pk_order_items` 
	PRIMARY KEY (`order_id` , `item_id`),
    CONSTRAINT `fk_order_items_orders` 
	FOREIGN KEY (`order_id`)
	REFERENCES `orders` (`order_id`),
    CONSTRAINT `fk_order_items_items` 
	FOREIGN KEY (`item_id`)
	REFERENCES `items` (`item_id`)
);