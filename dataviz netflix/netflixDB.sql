CREATE DATABASE  IF NOT EXISTS `netflix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `netflix`;
-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: netflix
-- ------------------------------------------------------
-- Server version	8.0.21-0ubuntu0.20.04.4

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
-- Table structure for table `ACTOR`
--

DROP TABLE IF EXISTS `ACTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACTOR` (
  `cast_id` int NOT NULL AUTO_INCREMENT,
  `cast` varchar(100) NOT NULL,
  PRIMARY KEY (`cast_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ACTOR_CATALOGUE`
--

DROP TABLE IF EXISTS `ACTOR_CATALOGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACTOR_CATALOGUE` (
  `cast_id` int NOT NULL,
  `show_id` int NOT NULL,
  PRIMARY KEY (`cast_id`,`show_id`),
  KEY `fk_ACTOR_CATALOGUE_2_idx` (`show_id`),
  CONSTRAINT `fk_ACTOR_CATALOGUE_1` FOREIGN KEY (`cast_id`) REFERENCES `ACTOR` (`cast_id`),
  CONSTRAINT `fk_ACTOR_CATALOGUE_2` FOREIGN KEY (`show_id`) REFERENCES `CATALOGUE` (`show_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CATALOGUE`
--

DROP TABLE IF EXISTS `CATALOGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATALOGUE` (
  `show_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `rating` varchar(200) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`show_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81235730 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CATEGORY`
--

DROP TABLE IF EXISTS `CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORY` (
  `listed_in_id` int NOT NULL AUTO_INCREMENT,
  `listed_in` varchar(45) NOT NULL,
  PRIMARY KEY (`listed_in_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CATEGORY_CATALOGUE`
--

DROP TABLE IF EXISTS `CATEGORY_CATALOGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORY_CATALOGUE` (
  `show_id` int NOT NULL,
  `listed_in_id` int NOT NULL,
  PRIMARY KEY (`show_id`,`listed_in_id`),
  KEY `fk_CATEGORY_CATALOGUE_2_idx` (`listed_in_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `COUNTRY`
--

DROP TABLE IF EXISTS `COUNTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COUNTRY` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `COUNTRY_CATALOGUE`
--

DROP TABLE IF EXISTS `COUNTRY_CATALOGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COUNTRY_CATALOGUE` (
  `show_id` int NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`show_id`,`country_id`),
  KEY `fk_COUNTRY_CATALOGUE_2_idx` (`country_id`),
  CONSTRAINT `fk_COUNTRY_CATALOGUE_1` FOREIGN KEY (`show_id`) REFERENCES `CATALOGUE` (`show_id`),
  CONSTRAINT `fk_COUNTRY_CATALOGUE_2` FOREIGN KEY (`country_id`) REFERENCES `COUNTRY` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DIRECTOR`
--

DROP TABLE IF EXISTS `DIRECTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DIRECTOR` (
  `director_id` int NOT NULL AUTO_INCREMENT,
  `director` varchar(100) NOT NULL,
  PRIMARY KEY (`director_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3656 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DIRECTOR_CATALOGUE`
--

DROP TABLE IF EXISTS `DIRECTOR_CATALOGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DIRECTOR_CATALOGUE` (
  `show_id` int NOT NULL,
  `director_id` int NOT NULL,
  PRIMARY KEY (`show_id`,`director_id`),
  KEY `fk_DIRECTOR_CATALOGUE_2_idx` (`director_id`),
  CONSTRAINT `fk_DIRECTOR_CATALOGUE_1` FOREIGN KEY (`show_id`) REFERENCES `CATALOGUE` (`show_id`),
  CONSTRAINT `fk_DIRECTOR_CATALOGUE_2` FOREIGN KEY (`director_id`) REFERENCES `DIRECTOR` (`director_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-10 14:58:53
