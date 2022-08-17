-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema operanlys
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema operanlys
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `operanlys` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `operanlys`;

-- -----------------------------------------------------
-- Table `operanlys`.`classinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`classinfo`
(
    `classID`            INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`               VARCHAR(255) NULL DEFAULT NULL,
    `classCode`          VARCHAR(10)  NULL DEFAULT NULL,
    `classSectionNumber` INT          NULL DEFAULT NULL,
    PRIMARY KEY (`classID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`logs`
(
    `logID`     INT          NOT NULL,
    `logtype`   CHAR(1)      NULL DEFAULT NULL,
    `username`  VARCHAR(255) NULL DEFAULT NULL,
    `timestamp` DATE         NULL DEFAULT NULL,
    PRIMARY KEY (`logID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`professorinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`professorinfo`
(
    `professorID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`        VARCHAR(255) NULL DEFAULT NULL,
    `username`    VARCHAR(255) NULL DEFAULT NULL,
    `password`    VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (`professorID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`semesterinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`semesterinfo`
(
    `semesterID`   INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `semesterCode` INT          NULL DEFAULT NULL COMMENT 'RIT\'s semester code',
    `name`         VARCHAR(10)  NULL DEFAULT NULL,
    PRIMARY KEY (`semesterID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`signinlogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`signinlogs`
(
    `logID`               INT             NOT NULL,
    `signInLogID`         INT             NOT NULL,
    `attemptedPassword`   VARCHAR(255)    NULL DEFAULT NULL,
    `successfulLogIn`     ENUM ('Y', 'N') NULL DEFAULT NULL,
    `matchExistingRecord` ENUM ('Y', 'N') NULL DEFAULT 'N',
    PRIMARY KEY (`signInLogID`, `logID`),
    INDEX `fk_signInLogs_logs_idx` (`logID` ASC) VISIBLE,
    CONSTRAINT `fk_signInLogs_logs`
        FOREIGN KEY (`logID`)
            REFERENCES `operanlys`.`logs` (`logID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`studentinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`studentinfo`
(
    `studentID`       INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`            VARCHAR(255)    NULL DEFAULT NULL,
    `username`        VARCHAR(255)    NULL DEFAULT NULL,
    `password`        VARCHAR(255)    NULL DEFAULT NULL,
    `passwordChanged` ENUM ('Y', 'N') NULL DEFAULT NULL,
    `lastSignIn`      DATE            NULL DEFAULT NULL,
    PRIMARY KEY (`studentID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`studentclassinstance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`studentclassinstance`
(
    `instanceID`  INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `studentID`   INT UNSIGNED NULL DEFAULT NULL,
    `professorID` INT UNSIGNED NULL DEFAULT NULL,
    `classID`     INT UNSIGNED NULL DEFAULT NULL,
    `semesterID`  INT UNSIGNED NULL DEFAULT NULL,
    PRIMARY KEY (`instanceID`),
    INDEX `studentID` (`studentID` ASC) VISIBLE,
    INDEX `professorID` (`professorID` ASC) VISIBLE,
    INDEX `classID` (`classID` ASC) VISIBLE,
    INDEX `semesterID` (`semesterID` ASC) VISIBLE,
    CONSTRAINT `studentclassinstance_ibfk_1`
        FOREIGN KEY (`studentID`)
            REFERENCES `operanlys`.`studentinfo` (`studentID`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `studentclassinstance_ibfk_2`
        FOREIGN KEY (`professorID`)
            REFERENCES `operanlys`.`professorinfo` (`professorID`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `studentclassinstance_ibfk_3`
        FOREIGN KEY (`classID`)
            REFERENCES `operanlys`.`classinfo` (`classID`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `studentclassinstance_ibfk_4`
        FOREIGN KEY (`semesterID`)
            REFERENCES `operanlys`.`semesterinfo` (`semesterID`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `operanlys`.`uploadlogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `operanlys`.`uploadlogs`
(
    `logID`             INT             NOT NULL,
    `uploadLogsID`      INT             NOT NULL,
    `filename`          VARCHAR(255)    NULL DEFAULT NULL,
    `filepath`          LONGTEXT        NULL DEFAULT NULL,
    `successfullUpload` ENUM ('Y', 'N') NULL DEFAULT NULL,
    PRIMARY KEY (`uploadLogsID`, `logID`),
    INDEX `fk_uploadLogs_logs1_idx` (`logID` ASC) VISIBLE,
    CONSTRAINT `fk_uploadLogs_logs1`
        FOREIGN KEY (`logID`)
            REFERENCES `operanlys`.`logs` (`logID`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
