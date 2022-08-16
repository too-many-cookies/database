CREATE DATABASE  IF NOT EXISTS `operanlys` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `operanlys`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: operanlys
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `classinfo`
--

DROP TABLE IF EXISTS `classinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classinfo` (
  `classID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL,
  `classCode` varchar(10) DEFAULT NULL,
  `classSectionNumber` int DEFAULT NULL,
  PRIMARY KEY (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classinfo`
--

LOCK TABLES `classinfo` WRITE;
/*!40000 ALTER TABLE `classinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `classinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professorinfo`
--

DROP TABLE IF EXISTS `professorinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professorinfo` (
  `professorID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`professorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professorinfo`
--

LOCK TABLES `professorinfo` WRITE;
/*!40000 ALTER TABLE `professorinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `professorinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semesterinfo`
--

DROP TABLE IF EXISTS `semesterinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semesterinfo` (
  `semesterID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `semesterCode` int DEFAULT NULL COMMENT 'RIT''s semester code',
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`semesterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semesterinfo`
--

LOCK TABLES `semesterinfo` WRITE;
/*!40000 ALTER TABLE `semesterinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `semesterinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentclassinstance`
--

DROP TABLE IF EXISTS `studentclassinstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentclassinstance` (
  `instanceID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `studentID` int unsigned DEFAULT NULL,
  `professorID` int unsigned DEFAULT NULL,
  `classID` int unsigned DEFAULT NULL,
  `semesterID` int unsigned DEFAULT NULL,
  PRIMARY KEY (`instanceID`),
  KEY `studentID` (`studentID`),
  KEY `professorID` (`professorID`),
  KEY `classID` (`classID`),
  KEY `semesterID` (`semesterID`),
  CONSTRAINT `studentclassinstance_ibfk_1` FOREIGN KEY (`studentID`) REFERENCES `studentinfo` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentclassinstance_ibfk_2` FOREIGN KEY (`professorID`) REFERENCES `professorinfo` (`professorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentclassinstance_ibfk_3` FOREIGN KEY (`classID`) REFERENCES `classinfo` (`classID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentclassinstance_ibfk_4` FOREIGN KEY (`semesterID`) REFERENCES `semesterinfo` (`semesterID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentclassinstance`
--

LOCK TABLES `studentclassinstance` WRITE;
/*!40000 ALTER TABLE `studentclassinstance` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentclassinstance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentinfo`
--

DROP TABLE IF EXISTS `studentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentinfo` (
  `studentID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `passwordChanged` enum('Y','N') DEFAULT NULL,
  `lastSignIn` date DEFAULT NULL,
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentinfo`
--

LOCK TABLES `studentinfo` WRITE;
/*!40000 ALTER TABLE `studentinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `logID` int NOT NULL,
  `logtype` char(1) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `timestamp` date DEFAULT NULL,
  PRIMARY KEY (`logID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `uploadlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uploadlogs` (
  `logID` int NOT NULL,
  `uploadLogsID` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `filepath` longtext,
  `successfullUpload` enum('Y','N') DEFAULT NULL,
  `timestamp` date DEFAULT NULL,
  PRIMARY KEY (`uploadLogsID`,`logID`),
  KEY `fk_uploadLogs_logs1_idx` (`logID`),
  CONSTRAINT `fk_uploadLogs_logs1` FOREIGN KEY (`logID`) REFERENCES `logs` (`logID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploadlogs`
--

LOCK TABLES `uploadlogs` WRITE;
/*!40000 ALTER TABLE `uploadlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploadlogs` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `signinlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signinlogs` (
  `logID` int NOT NULL,
  `signInLogID` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `attemptedPassword` varchar(255) DEFAULT NULL,
  `successfulLogIn` enum('Y','N') DEFAULT NULL,
  `timestamp` date DEFAULT NULL,
  PRIMARY KEY (`signInLogID`,`logID`),
  KEY `fk_signInLogs_logs_idx` (`logID`),
  CONSTRAINT `fk_signInLogs_logs` FOREIGN KEY (`logID`) REFERENCES `logs` (`logID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signinlogs`
--

LOCK TABLES `signinlogs` WRITE;
/*!40000 ALTER TABLE `signinlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `signinlogs` ENABLE KEYS */;
UNLOCK TABLES;
