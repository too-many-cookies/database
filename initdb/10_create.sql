CREATE DATABASE  IF NOT EXISTS `operational_analytics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `operational_analytics`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: operational_analytics
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `class_info`
--

DROP TABLE IF EXISTS `class_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_info` (
  `class_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `semester_id` int unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `class_code` varchar(10) DEFAULT NULL,
  `class_section_number` int DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk_class_info_semester_info1_idx` (`semester_id`),
  CONSTRAINT `fk_class_info_semester_info1` FOREIGN KEY (`semester_id`) REFERENCES `semester_info` (`semester_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_info`
--

LOCK TABLES `class_info` WRITE;
/*!40000 ALTER TABLE `class_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `successful` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `logs_student_info_fk` (`username`),
  KEY `username` (`username`),
  CONSTRAINT `logs_student_info_fk` FOREIGN KEY (`username`) REFERENCES `student_info` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor_class_instance`
--

DROP TABLE IF EXISTS `professor_class_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor_class_instance` (
  `professor_class_instance_id` int unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int unsigned NOT NULL,
  `professor_id` int unsigned NOT NULL,
  `active` enum('A','I') NOT NULL DEFAULT 'I',
  PRIMARY KEY (`professor_class_instance_id`),
  KEY `fk_professor_class_instance_class_info_idx` (`class_id`),
  KEY `fk_professor_class_instance_professor_info1_idx` (`professor_id`),
  CONSTRAINT `fk_professor_class_instance_class_info` FOREIGN KEY (`class_id`) REFERENCES `class_info` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_professor_class_instance_professor_info1` FOREIGN KEY (`professor_id`) REFERENCES `professor_info` (`professor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor_class_instance`
--

LOCK TABLES `professor_class_instance` WRITE;
/*!40000 ALTER TABLE `professor_class_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor_class_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor_feedback`
--

DROP TABLE IF EXISTS `professor_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor_feedback` (
  `professor_info_professor_id` int unsigned NOT NULL,
  `professor_feedback_id` int unsigned NOT NULL,
  `feedback` longtext,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`professor_info_professor_id`,`professor_feedback_id`),
  KEY `fk_professor_feedback_professor_info1_idx` (`professor_info_professor_id`),
  CONSTRAINT `fk_professor_feedback_professor_info1` FOREIGN KEY (`professor_info_professor_id`) REFERENCES `professor_info` (`professor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor_feedback`
--

LOCK TABLES `professor_feedback` WRITE;
/*!40000 ALTER TABLE `professor_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor_info`
--

DROP TABLE IF EXISTS `professor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor_info` (
  `professor_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` enum('Y','N') DEFAULT NULL,
  `active` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`professor_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor_info`
--

LOCK TABLES `professor_info` WRITE;
/*!40000 ALTER TABLE `professor_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester_info`
--

DROP TABLE IF EXISTS `semester_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester_info` (
  `semester_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `semester_code` int DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester_info`
--

LOCK TABLES `semester_info` WRITE;
/*!40000 ALTER TABLE `semester_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `semester_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_class_info`
--

DROP TABLE IF EXISTS `student_class_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_class_info` (
  `student_class_info_id` int unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int unsigned NOT NULL,
  `class_id` int unsigned NOT NULL,
  PRIMARY KEY (`student_class_info_id`),
  KEY `fk_student_info_has_class_info_class_info1_idx` (`class_id`),
  KEY `fk_student_info_has_class_info_student_info1_idx` (`student_id`),
  CONSTRAINT `fk_student_info_has_class_info_class_info1` FOREIGN KEY (`class_id`) REFERENCES `class_info` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_info_has_class_info_student_info1` FOREIGN KEY (`student_id`) REFERENCES `student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_class_info`
--

LOCK TABLES `student_class_info` WRITE;
/*!40000 ALTER TABLE `student_class_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_class_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_info`
--

DROP TABLE IF EXISTS `student_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_info` (
  `student_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_info`
--

LOCK TABLES `student_info` WRITE;
/*!40000 ALTER TABLE `student_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-02 15:24:24
