-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema operational_analytics
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `operational_analytics` ;

-- -----------------------------------------------------
-- Schema operational_analytics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `operational_analytics` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `operational_analytics` ;

-- -----------------------------------------------------
-- Table `operational_analytics`.`semester_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`semester_info` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`semester_info` (
  `semester_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `semester_code` INT NULL DEFAULT NULL,
  `name` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`semester_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operational_analytics`.`class_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`class_info` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`class_info` (
  `class_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `semester_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `class_code` VARCHAR(10) NULL DEFAULT NULL,
  `class_section_number` INT NULL DEFAULT NULL,
  `student_signin_count` INT NULL DEFAULT NULL,
  `total_student_count` INT NULL DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  INDEX `fk_class_info_semester_info1_idx` (`semester_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_info_semester_info1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `operational_analytics`.`semester_info` (`semester_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operational_analytics`.`logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`logs` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`logs` (
  `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_type` CHAR(1) NULL DEFAULT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `timestamp` DATE NULL DEFAULT NULL,
  `successful` ENUM('Y', 'N') NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operational_analytics`.`professor_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`professor_info` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`professor_info` (
  `professor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`professor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operational_analytics`.`professor_class_instance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`professor_class_instance` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`professor_class_instance` (
  `professor_class_instance_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_id` INT UNSIGNED NOT NULL,
  `professor_id` INT UNSIGNED NOT NULL,
  `active` ENUM('A', 'I') NOT NULL DEFAULT 'I',
  PRIMARY KEY (`professor_class_instance_id`),
  INDEX `fk_professor_class_instance_class_info_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_professor_class_instance_professor_info1_idx` (`professor_id` ASC) VISIBLE,
  CONSTRAINT `fk_professor_class_instance_class_info`
    FOREIGN KEY (`class_id`)
    REFERENCES `operational_analytics`.`class_info` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_professor_class_instance_professor_info1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `operational_analytics`.`professor_info` (`professor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `operational_analytics`.`student_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`student_info` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`student_info` (
  `student_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NOT NULL,
  `password_changed` ENUM('Y', 'N') NULL DEFAULT NULL,
  `last_sign_in` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operational_analytics`.`student_class_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operational_analytics`.`student_class_info` ;

CREATE TABLE IF NOT EXISTS `operational_analytics`.`student_class_info` (
  `student_class_info_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` INT UNSIGNED NOT NULL,
  `class_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`student_class_info_id`, `student_id`, `class_id`),
  INDEX `fk_student_info_has_class_info_class_info1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_student_info_has_class_info_student_info1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_info_has_class_info_class_info1`
    FOREIGN KEY (`class_id`)
    REFERENCES `operational_analytics`.`class_info` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_info_has_class_info_student_info1`
    FOREIGN KEY (`student_id`)
    REFERENCES `operational_analytics`.`student_info` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
