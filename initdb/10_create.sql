SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS operational_analytics DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE operational_analytics;


CREATE TABLE IF NOT EXISTS operational_analytics.class_info
(
    `class_id`             INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`                 VARCHAR(255) NULL DEFAULT NULL,
    `class_code`           VARCHAR(10)  NULL DEFAULT NULL,
    `class_section_number` INT          NULL DEFAULT NULL,
    PRIMARY KEY (class_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.`logs`
(
    `log_id`    INT          NOT NULL,
    `log_type`  CHAR(1)      NULL DEFAULT NULL,
    `username`  VARCHAR(255) NULL DEFAULT NULL,
    `timestamp` DATE         NULL DEFAULT NULL,
    PRIMARY KEY (log_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.professor_info
(
    `professor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`         VARCHAR(255) NULL DEFAULT NULL,
    `username`     VARCHAR(255) NULL DEFAULT NULL,
    `password`     VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (professor_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.semester_info
(
    `semester_id`   INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `semester_code` INT          NULL DEFAULT NULL COMMENT,
    `name`          VARCHAR(10)  NULL DEFAULT NULL,
    PRIMARY KEY (semester_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.sign_in_logs
(
    `log_id`                INT             NOT NULL,
    `sign_in_log_id`        INT             NOT NULL,
    `attempted_password`    VARCHAR(255)    NULL DEFAULT NULL,
    `successful_log_in`     ENUM ('Y', 'N') NULL DEFAULT NULL,
    `match_existing_record` ENUM ('Y', 'N') NULL DEFAULT 'N',
    PRIMARY KEY (sign_in_log_id, log_id),
    INDEX `sign_in_logs_idx` (log_id ASC) VISIBLE,
    CONSTRAINT sign_in_logs_logs_fk
        FOREIGN KEY (log_id)
            REFERENCES operational_analytics.`logs` (log_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.student_info
(
    `student_id`       INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `name`             VARCHAR(255)    NULL DEFAULT NULL,
    `username`         VARCHAR(255)    NULL DEFAULT NULL,
    `password`         VARCHAR(255)    NULL DEFAULT NULL,
    `password_changed` ENUM ('Y', 'N') NULL DEFAULT NULL,
    `last_sign_in`     DATE            NULL DEFAULT NULL,
    PRIMARY KEY (student_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.student_class_instance
(
    `instance_id`  INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'primary key',
    `student_id`   INT UNSIGNED NULL DEFAULT NULL,
    `professor_id` INT UNSIGNED NULL DEFAULT NULL,
    `class_id`     INT UNSIGNED NULL DEFAULT NULL,
    `semester_id`  INT UNSIGNED NULL DEFAULT NULL,
    PRIMARY KEY (instance_id),
    INDEX `student_id_idx` (student_id ASC) VISIBLE,
    INDEX `professor_id_idx` (professor_id ASC) VISIBLE,
    INDEX `class_id_idx` (class_id ASC) VISIBLE,
    INDEX `semester_id_idx` (semester_id ASC) VISIBLE,
    CONSTRAINT `student_class_instance_student_info_fk`
        FOREIGN KEY (student_id)
            REFERENCES operational_analytics.student_info (student_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `student_class_instance_professor_info_fk`
        FOREIGN KEY (professor_id)
            REFERENCES operational_analytics.professor_info (professor_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `student_class_instance_class_info_fk`
        FOREIGN KEY (class_id)
            REFERENCES operational_analytics.class_info (class_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `student_class_instance_semester_info_fk`
        FOREIGN KEY (semester_id)
            REFERENCES operational_analytics.semester_info (semester_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS operational_analytics.upload_logs
(
    `log_id`            INT             NOT NULL,
    `upload_logs_id`    INT             NOT NULL,
    `filename`          VARCHAR(255)    NULL DEFAULT NULL,
    `filepath`          LONGTEXT        NULL DEFAULT NULL,
    `successful_upload` ENUM ('Y', 'N') NULL DEFAULT NULL,
    PRIMARY KEY (upload_logs_id, log_id),
    INDEX `log_id_idx` (log_id ASC) VISIBLE,
    CONSTRAINT `upload_logs_logs_fk`
        FOREIGN KEY (log_id)
            REFERENCES operational_analytics.`logs` (log_id)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
