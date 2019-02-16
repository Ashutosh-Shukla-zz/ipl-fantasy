CREATE DATABASE  IF NOT EXISTS `ipl` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ipl`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ipl
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

SET GLOBAL event_scheduler = ON;
set time_zone = '+05:30';

--
-- Table structure for table `match_fixtures_tbl`
--

DROP TABLE IF EXISTS `match_fixtures_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `match_fixtures_tbl` (
  `match_fixtures_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_one_id` int(11) NOT NULL,
  `team_two_id` int(11) NOT NULL,
  `match_datetime` datetime NOT NULL,
  `team_winner_id` int(11) DEFAULT NULL,
  `venue_id` int(11) NOT NULL,
  `match_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`match_fixtures_tbl_id`),
  KEY `team_one_id_fk_idx` (`team_one_id`),
  KEY `team_two_id_fk_idx` (`team_two_id`),
  KEY `team_winner_id_fk_idx` (`team_winner_id`),
  KEY `venue_id_fk_idx` (`venue_id`),
  CONSTRAINT `team_one_id_fk` FOREIGN KEY (`team_one_id`) REFERENCES `teams_tbl` (`teams_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_two_id_fk` FOREIGN KEY (`team_two_id`) REFERENCES `teams_tbl` (`teams_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_winner_id_fk` FOREIGN KEY (`team_winner_id`) REFERENCES `teams_tbl` (`teams_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `venue_id_fk` FOREIGN KEY (`venue_id`) REFERENCES `venue_tbl` (`venue_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='Match Fixtures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_fixtures_tbl`
--

LOCK TABLES `match_fixtures_tbl` WRITE;
/*!40000 ALTER TABLE `match_fixtures_tbl` DISABLE KEYS */;
INSERT INTO `match_fixtures_tbl` VALUES (1,8,7,'2017-04-05 20:00:00',NULL,3,0),(2,6,5,'2017-04-06 20:00:00',NULL,8,0),(3,2,4,'2017-04-07 20:00:00',NULL,9,0),(4,3,6,'2017-04-08 16:00:00',NULL,10,0),(5,7,1,'2017-04-08 20:00:00',NULL,1,0),(6,8,2,'2017-04-09 16:00:00',NULL,3,0),(7,5,4,'2017-04-09 20:00:00',NULL,7,0),(8,3,7,'2017-04-10 20:00:00',NULL,10,0),(9,6,1,'2017-04-11 20:00:00',NULL,8,0),(10,5,8,'2017-04-12 20:00:00',NULL,7,0),(11,4,3,'2017-04-13 20:00:00',NULL,5,0),(12,7,5,'2017-04-14 16:00:00',NULL,1,0),(13,2,6,'2017-04-14 20:00:00',NULL,9,0),(14,4,8,'2017-04-15 16:00:00',NULL,5,0),(15,1,3,'2017-04-15 20:00:00',NULL,2,0),(16,5,2,'2017-04-16 16:00:00',NULL,7,0),(17,7,6,'2017-04-16 20:00:00',NULL,1,0),(18,1,4,'2017-04-17 16:00:00',NULL,2,0),(19,8,3,'2017-04-17 20:00:00',NULL,3,0),(20,2,7,'2017-04-18 20:00:00',NULL,9,0),(21,8,1,'2017-04-19 20:00:00',NULL,3,0),(22,3,5,'2017-04-20 20:00:00',NULL,10,0),(23,4,2,'2017-04-21 20:00:00',NULL,5,0),(24,1,5,'2017-04-22 16:00:00',NULL,2,0),(25,6,8,'2017-04-22 20:00:00',NULL,8,0),(26,2,3,'2017-04-23 16:00:00',NULL,9,0),(27,4,7,'2017-04-23 20:00:00',NULL,5,0),(28,5,6,'2017-04-24 20:00:00',NULL,7,0),(29,7,8,'2017-04-25 20:00:00',NULL,1,0),(30,6,4,'2017-04-26 20:00:00',NULL,8,0),(31,7,2,'2017-04-27 20:00:00',NULL,1,0),(32,4,1,'2017-04-28 16:00:00',NULL,5,0),(33,3,8,'2017-04-28 20:00:00',NULL,6,0),(34,6,7,'2017-04-29 16:00:00',NULL,8,0),(35,2,5,'2017-04-29 20:00:00',NULL,9,0),(36,3,1,'2017-04-30 16:00:00',NULL,6,0),(37,8,4,'2017-04-30 20:00:00',NULL,3,0),(38,5,7,'2017-05-01 16:00:00',NULL,7,0),(39,6,2,'2017-05-01 20:00:00',NULL,8,0),(40,1,8,'2017-05-02 20:00:00',NULL,2,0),(41,4,6,'2017-05-03 20:00:00',NULL,5,0),(42,1,2,'2017-05-04 20:00:00',NULL,2,0),(43,7,3,'2017-05-05 20:00:00',NULL,1,0),(44,8,6,'2017-05-06 16:00:00',NULL,3,0),(45,5,1,'2017-05-06 20:00:00',NULL,7,0),(46,7,4,'2017-05-07 16:00:00',NULL,1,0),(47,3,2,'2017-05-07 20:00:00',NULL,6,0),(48,8,5,'2017-05-08 20:00:00',NULL,3,0),(49,3,4,'2017-05-09 20:00:00',NULL,6,0),(50,2,1,'2017-05-10 20:00:00',NULL,4,0),(51,5,3,'2017-05-11 20:00:00',NULL,7,0),(52,1,6,'2017-05-12 20:00:00',NULL,2,0),(53,2,8,'2017-05-13 16:00:00',NULL,4,0),(54,4,5,'2017-05-13 20:00:00',NULL,5,0),(55,6,3,'2017-05-14 16:00:00',NULL,8,0),(56,1,7,'2017-05-14 20:00:00',NULL,2,0),(57,9,9,'2017-05-16 20:00:00',NULL,11,0),(58,9,9,'2017-05-17 20:00:00',NULL,11,0),(59,9,9,'2017-05-19 20:00:00',NULL,11,0),(60,9,9,'2017-05-21 20:00:00',NULL,3,0),(63,1,7,'2017-03-30 16:00:00',NULL,3,0),(64,1,2,'2017-03-31 11:56:00',2,1,0);
/*!40000 ALTER TABLE `match_fixtures_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_manager_tbl`
--

DROP TABLE IF EXISTS `password_manager_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_manager_tbl` (
  `password_manager_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_master_id` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `is_change_request` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`password_manager_tbl_id`),
  KEY `user_master_id_fk_idx` (`user_master_id`),
  CONSTRAINT `user_master_id_fk` FOREIGN KEY (`user_master_id`) REFERENCES `user_master_tbl` (`user_master_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_manager_tbl`
--

LOCK TABLES `password_manager_tbl` WRITE;
/*!40000 ALTER TABLE `password_manager_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_manager_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_category_tbl`
--

DROP TABLE IF EXISTS `player_category_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_category_tbl` (
  `player_category_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_category` varchar(45) NOT NULL,
  PRIMARY KEY (`player_category_tbl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_category_tbl`
--

LOCK TABLES `player_category_tbl` WRITE;
/*!40000 ALTER TABLE `player_category_tbl` DISABLE KEYS */;
INSERT INTO `player_category_tbl` VALUES (1,'Capped'),(2,'Uncapped'),(3,'Overseas');
/*!40000 ALTER TABLE `player_category_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_individual_score_tbl`
--

DROP TABLE IF EXISTS `player_individual_score_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_individual_score_tbl` (
  `player_individual_score_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `match_fixture_id` int(11) NOT NULL,
  `runs` int(11) NOT NULL DEFAULT '0',
  `wickets` int(11) NOT NULL DEFAULT '0',
  `catches` int(11) NOT NULL DEFAULT '0',
  `run_outs` int(11) NOT NULL DEFAULT '0',
  `is_mom` tinyint(1) NOT NULL DEFAULT '0',
  `total_points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_individual_score_tbl_id`),
  KEY `player_id_fk_idx` (`player_id`),
  KEY `match_id_fk_idx` (`match_fixture_id`),
  CONSTRAINT `match_fixture_id_fk` FOREIGN KEY (`match_fixture_id`) REFERENCES `match_fixtures_tbl` (`match_fixtures_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `player_id_fk` FOREIGN KEY (`player_id`) REFERENCES `player_tbl` (`player_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_individual_score_tbl`
--

LOCK TABLES `player_individual_score_tbl` WRITE;
/*!40000 ALTER TABLE `player_individual_score_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_individual_score_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_role_tbl`
--

DROP TABLE IF EXISTS `player_role_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_role_tbl` (
  `player_role_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_role` varchar(45) NOT NULL,
  PRIMARY KEY (`player_role_tbl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Role of a player in the team';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_role_tbl`
--

LOCK TABLES `player_role_tbl` WRITE;
/*!40000 ALTER TABLE `player_role_tbl` DISABLE KEYS */;
INSERT INTO `player_role_tbl` VALUES (1,'Batsmen'),(2,'Bowler'),(3,'All Rounder');
/*!40000 ALTER TABLE `player_role_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_tbl`
--

DROP TABLE IF EXISTS `player_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_tbl` (
  `player_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `player_photo` blob,
  `player_team_id` int(11) NOT NULL,
  `player_role_id` int(11) NOT NULL,
  `player_category_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_tbl_id`),
  KEY `player_team_id_fk_idx` (`player_team_id`),
  KEY `player_role_id_idx` (`player_role_id`),
  KEY `player_category_id_fk_idx` (`player_category_id`),
  CONSTRAINT `player_category_id_fk` FOREIGN KEY (`player_category_id`) REFERENCES `player_category_tbl` (`player_category_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `player_role_id` FOREIGN KEY (`player_role_id`) REFERENCES `player_role_tbl` (`player_role_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `player_team_id_fk` FOREIGN KEY (`player_team_id`) REFERENCES `teams_tbl` (`teams_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8 COMMENT='Player Details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_tbl`
--

LOCK TABLES `player_tbl` WRITE;
/*!40000 ALTER TABLE `player_tbl` DISABLE KEYS */;
INSERT INTO `player_tbl` VALUES (1,'Zaheer','Khan','',1,2,1,1),(2,'Corey','Anderson','',1,3,3,1),(3,'Sam','Billings','',1,1,3,1),(4,'Carlos','Brathwaite','',1,3,3,1),(5,'Pat','Cummins','',1,2,3,1),(6,'Quinton','de Kock','',1,1,3,1),(7,'JP','Duminy','',1,1,3,1),(8,'Shreyas','Iyer','',1,1,1,1),(9,'Angelo','Mathews','',1,3,3,1),(10,'Amit','Mishra','',1,2,1,1),(11,'Mohammed','Shami','',1,2,1,1),(12,'Chris','Morris','',1,3,3,1),(13,'Karun','Nair','',1,1,1,1),(14,'Kagiso','Rabada','',1,2,3,1),(15,'Jayant','Yadav','',1,2,1,1),(16,'Ankit','Bawne','',1,1,2,1),(17,'Khaleel','Ahmed','',1,2,2,1),(18,'Murugan','Ashwin','',1,2,2,1),(19,'CV','Milind','',1,1,2,1),(20,'Shahbaz','Nadeem','',1,2,2,1),(21,'Rishabh','Pant','',1,1,2,1),(22,'Pratyush','Singh','',1,1,2,1),(23,'Navdeep','Saini','',1,2,2,1),(24,'Sanju','Samson','',1,1,2,1),(25,'Shashank','Singh','',1,2,2,1),(26,'Aditya','Tare','',1,1,2,1),(27,'Suresh','Raina','',2,1,1,1),(28,'Dwayne','Bravo','',2,3,3,1),(29,'Chirag','Suri','',2,1,3,1),(30,'James','Faulkner','',2,3,3,1),(31,'Aaron','Finch','',2,1,3,1),(32,'Manpreet','Gony','',2,2,1,1),(33,'Ravindra','Jadeja','',2,3,1,1),(34,'Dinesh','Karthik','',2,1,1,1),(35,'Dhawal','Kulkarni','',2,2,1,1),(36,'Praveen','Kumar','',2,2,1,1),(37,'Brendon','McCullum','',2,1,3,1),(38,'Munaf','Patel','',2,2,1,1),(39,'Jason','Roy','',2,1,3,1),(40,'Dwayne','Smith','',2,1,3,1),(41,'Andrew','Tye','',2,3,3,1),(42,'Akshdeep','Nath','',2,3,2,1),(43,'Shubham','Agarwal','',2,2,2,1),(44,'Basil','Thampi','',2,1,2,1),(45,'Ishan','Kishan','',2,1,2,1),(46,'Shadab','Jakati','',2,2,2,1),(47,'Shivil','Kaushik','',2,2,2,1),(48,'Pratham','Singh','',2,1,2,1),(49,'Pradeep','Sangwan','',2,2,2,1),(50,'Jaydev','Shah','',2,1,2,1),(51,'Shelley','Shaurya','',2,2,2,1),(52,'Nathu','Singh','',2,2,2,1),(53,'Tejas','Baroka','',2,2,2,1),(54,'Varun','Aaron','',3,2,1,1),(55,'Hashim','Amla','',3,1,3,1),(56,'Martin','Guptill','',3,1,3,1),(57,'Matt','Henry','',3,2,3,1),(58,'Shaun','Marsh','',3,1,3,1),(59,'Glenn','Maxwell','',3,3,3,1),(60,'David','Miller','',3,1,3,1),(61,'Eoin','Morgan','',3,1,3,1),(62,'Axar','Patel','',3,3,1,1),(63,'Wriddhiman','Saha','',3,1,1,1),(64,'Darren','Sammy','',3,3,3,1),(65,'Sandeep','Sharma','',3,2,1,1),(66,'Mohit','Sharma','',3,2,1,1),(67,'Marcus','Stoinis','',3,3,3,1),(68,'Murali','Vijay','',3,1,1,1),(69,'Anureet','Singh','',3,2,2,1),(70,'Armaan','Jaffer','',3,1,2,1),(71,'KC','Cariappa','',3,2,2,1),(72,'Gurkeerat','Mann Singh','',3,1,2,1),(73,'Nikhil','Naik','',3,1,2,1),(74,'T','Natarajan','',3,1,2,1),(75,'Pradeep','Sahu','',3,1,2,1),(76,'Rinku','Singh','',3,1,2,1),(77,'Swapnil','Singh','',3,2,2,1),(78,'Rahul','Tewatia','',3,2,2,1),(79,'Shardul','Thakur','',3,2,2,1),(80,'Manan','Vohra','',3,1,2,1),(81,'Gautam','Gambhir','',4,1,1,1),(82,'Trent','Boult','',4,2,3,1),(83,'Darren','Bravo','',4,1,3,1),(84,'Piyush','Chawla','',4,2,1,1),(85,'Nathan','Coulter-Nile','',4,2,3,1),(86,'Rishi','Dhawan','',4,3,1,1),(87,'Chris','Lynn','',4,1,3,1),(88,'Sunil','Narine','',4,2,3,1),(89,'Manish','Pandey','',4,1,1,1),(90,'Yusuf','Pathan','',4,3,1,1),(91,'Rovman','Powell','',4,1,3,1),(92,'Andre','Russell','',4,3,3,1),(93,'Shakib','Al Hasan','',4,3,3,1),(94,'Robin','Uthappa','',4,1,1,1),(95,'Chris','Woakes','',4,2,3,1),(96,'Suryakumar','Yadav','',4,1,1,1),(97,'Umesh','Yadav','',4,2,1,1),(98,'Sayan','Ghosh','',4,2,2,1),(99,'Sheldon','Jackson','',4,1,2,1),(100,'Ishank','Jaggi','',4,1,2,1),(101,'Kuldeep','Yadav','',4,3,2,1),(102,'Ankit','Rajpoot','',4,2,2,1),(103,'R','Sanjay Yadav','',4,1,2,1),(104,'Rohit','Sharma','',5,1,1,1),(105,'Jasprit','Bumrah','',5,2,1,1),(106,'Jos','Buttler','',5,1,3,1),(107,'Asela','Gunaratne','',5,1,3,1),(108,'Harbhajan','Singh','',5,2,1,1),(109,'Mitchell','Johnson','',5,2,3,1),(110,'Mitchell','McClenaghan','',5,2,3,1),(111,'Lasith','Malinga','',5,2,3,1),(112,'Hardik','Pandya','',5,3,1,1),(113,'Krunal','Pandya','',5,3,1,1),(114,'Parthiv','Patel','',5,1,1,1),(115,'Kieron','Pollard','',5,3,3,1),(116,'Nicholas','Pooran','',5,1,3,1),(117,'Ambati','Rayudu','',5,1,1,1),(118,'Karn','Sharma','',5,3,1,1),(119,'Lendl','Simmons','',5,1,3,1),(120,'Tim','Southee','',5,2,3,1),(121,'Saurabh','Tiwary','',5,1,1,1),(122,'Vinay','Kumar','',5,2,1,1),(123,'Shreyas','Gopal','',5,3,2,1),(124,'Krishnappa','Gowtham','',5,1,2,1),(125,'Kulwant','Khejroliya','',5,2,2,1),(126,'Siddhesh','Lad','',5,1,2,1),(127,'Deepak','Punia','',5,2,2,1),(128,'Nitish','Rana','',5,1,2,1),(129,'Jitesh','Sharma','',5,1,2,1),(130,'Jagadeesha','Suchith','',5,2,2,1),(131,'Steve','Smith','',6,3,3,1),(132,'Ravichandran','Ashwin','',6,2,1,1),(133,'Dan','Christian','',6,3,3,1),(134,'MS','Dhoni','',6,1,1,1),(135,'Ashok','Dinda','',6,2,1,1),(136,'Francois','du Plessis','',6,3,3,1),(137,'Lockie','Ferguson','',6,2,3,1),(138,'Usman','Khawaja','',6,1,3,1),(139,'Mitchell','Marsh','',6,3,3,1),(140,'Ajinkya','Rahane','',6,1,1,1),(141,'Ben','Stokes','',6,3,3,1),(142,'Manoj','Tiwary','',6,1,1,1),(143,'Adam','Zampa','',6,2,3,1),(144,'Jaydev','Unadkat','',6,2,1,1),(145,'Ishwar','Pandey','',6,1,1,1),(146,'Mayank','Agarwal','',6,1,2,1),(147,'Ankit','Sharma','',6,2,2,1),(148,'Baba','Aparajith','',6,3,2,1),(149,'Ankusk','Bains','',6,1,2,1),(150,'Rajat','Bhatia','',6,3,2,1),(151,'Deepak','Chahar','',6,2,2,1),(152,'Rahul','Chahar','',6,2,2,1),(153,'Jaskaran','Singh','',6,2,2,1),(154,'Saurabh','Kumar','',6,3,2,1),(155,'Milind','Tandon','',6,1,2,1),(156,'Rahul','Tripathi','',6,1,2,1),(157,'Virat','Kohli','',7,1,1,1),(158,'Samuel','Badree','',7,2,3,1),(159,'Stuart','Binny','',7,3,3,1),(160,'Yuzvendra','Chahal','',7,2,1,1),(161,'AB','de Villiers','',7,1,3,1),(162,'Chris','Gayle','',7,3,3,1),(163,'Travis','Head','',7,1,3,1),(164,'Kedar','Jadhav','',7,1,1,1),(165,'Mandeep','Singh','',7,3,1,1),(166,'Tymal','Mills','',7,2,3,1),(167,'Adam','Milne','',7,2,3,1),(168,'Pawan','Negi','',7,2,1,1),(169,'Lokesh','Rahul','',7,1,1,1),(170,'Shane','Watson','',7,3,3,1),(171,'Sreenath','Aravind','',7,2,2,1),(172,'Avesh','Khan','',7,2,2,1),(173,'Aniket','Choudhary','',7,2,2,1),(174,'Praveen','Dubey','',7,2,2,1),(175,'Iqbal','Abdulla','',7,2,2,1),(176,'Sarfaraz','Khan','',7,1,2,1),(177,'Harshal','Patel','',7,2,2,1),(178,'Sachin','Baby','',7,1,2,1),(179,'Tabraiz','Shamsi','',7,2,3,1),(180,'Billy','Stanlake','',7,2,3,1),(181,'David','Warner','',8,1,3,1),(182,'Ben','Cutting','',8,2,3,1),(183,'Shikhar','Dhawan','',8,1,1,1),(184,'Moises','Henriques','',8,3,3,1),(185,'Chris','Jordan','',8,2,3,1),(186,'Bhuvneshwar','Kumar','',8,2,1,1),(187,'Ben','Laughlin','',8,2,3,1),(188,'Mohammad','Nabi','',8,3,3,1),(189,'Mustafizur','Rahman','',8,2,3,1),(190,'Ashish','Nehra','',8,2,1,1),(191,'Naman','Ojha','',8,1,1,1),(192,'Rashid','Khan','',8,2,3,1),(193,'Kane','Williamson','',8,1,3,1),(194,'Yuvraj','Singh','',8,3,1,1),(195,'Tanmay','Agarwal','',8,1,2,1),(196,'Ricky','Bhui','',8,1,2,1),(197,'Bipul','Sharma','',8,3,2,1),(198,'Eklavya','Dwivedi','',8,1,2,1),(199,'Deepak','Hooda','',8,2,2,1),(200,'Siddarth','Kaul','',8,2,2,1),(201,'Abhimanyu','Mithun','',8,2,2,1),(202,'Mohammed','Siraj','',8,2,2,1),(203,'Vijay','Shankar','',8,3,2,1),(204,'Barinder','Sran','',8,2,2,1),(205,'Pravin','Tambe','',8,3,2,1);
/*!40000 ALTER TABLE `player_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `points_detail_tbl`
--

DROP TABLE IF EXISTS `points_detail_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `points_detail_tbl` (
  `points_detail_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `points_category_code` varchar(10) NOT NULL,
  `points_category_desc` varchar(45) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`points_detail_tbl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `points_detail_tbl`
--

LOCK TABLES `points_detail_tbl` WRITE;
/*!40000 ALTER TABLE `points_detail_tbl` DISABLE KEYS */;
INSERT INTO `points_detail_tbl` VALUES (1,'run','Runs',1),(2,'wkt','Wickets',10),(3,'catch','Catches',5),(4,'runout','Run Outs',5),(5,'mom','Man of the Match',0),(6,'teamwin','Team Win',10);
/*!40000 ALTER TABLE `points_detail_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_parameter_tbl`
--

DROP TABLE IF EXISTS `system_parameter_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_parameter_tbl` (
  `system_parameter_name` varchar(100) DEFAULT NULL,
  `system_parameter_value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_parameter_tbl`
--

LOCK TABLES `system_parameter_tbl` WRITE;
/*!40000 ALTER TABLE `system_parameter_tbl` DISABLE KEYS */;
INSERT INTO `system_parameter_tbl` VALUES ('BatsmenCount','3'),('BowlerCount','2'),('AllRounderCount','2');
/*!40000 ALTER TABLE `system_parameter_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams_tbl`
--

DROP TABLE IF EXISTS `teams_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams_tbl` (
  `teams_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(45) NOT NULL,
  `team_logo` blob,
  `team_code` varchar(45) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`teams_tbl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_tbl`
--

LOCK TABLES `teams_tbl` WRITE;
/*!40000 ALTER TABLE `teams_tbl` DISABLE KEYS */;
INSERT INTO `teams_tbl` VALUES (1,'Delhi Daredevils',NULL,'DD',1),(2,'Gujarat Lions',NULL,'GL',1),(3,'Kings XI Punjab',NULL,'KXIP',1),(4,'Kolkata Knight Riders',NULL,'KKR',1),(5,'Mumbai Indians',NULL,'MI',1),(6,'Rising Pune Supergiant',NULL,'RPS',1),(7,'Royal Challengers Bangalore',NULL,'RCB',1),(8,'Sunrisers Hyderabad',NULL,'SRH',1),(9,'TBD',NULL,'TBD',1);
/*!40000 ALTER TABLE `teams_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_tbl`
--

DROP TABLE IF EXISTS `test_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_tbl` (
  `col1` varchar(100) DEFAULT NULL,
  `col2` int(11) DEFAULT NULL,
  `col3` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tbl`
--

LOCK TABLES `test_tbl` WRITE;
/*!40000 ALTER TABLE `test_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_fixtures_tbl`
--

DROP TABLE IF EXISTS `user_fixtures_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_fixtures_tbl` (
  `user_fixtures_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `match_id` int(11) NOT NULL,
  `user_one_id` int(11) NOT NULL,
  `user_two_id` int(11) NOT NULL,
  `user_one_points` int(11) NOT NULL DEFAULT '0',
  `user_two_points` int(11) NOT NULL DEFAULT '0',
  `user_winner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_fixtures_tbl_id`),
  KEY `match_id_fk_idx` (`match_id`),
  KEY `user_two_id_fk_idx` (`user_two_id`),
  KEY `user_winner_id_fk_idx` (`user_winner_id`),
  KEY `user_one_id_fk_idx` (`user_one_id`),
  CONSTRAINT `match_id_fk` FOREIGN KEY (`match_id`) REFERENCES `match_fixtures_tbl` (`match_fixtures_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_one_id_fk` FOREIGN KEY (`user_one_id`) REFERENCES `user_master_tbl` (`user_master_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_two_id_fk` FOREIGN KEY (`user_two_id`) REFERENCES `user_master_tbl` (`user_master_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_winner_id_fk` FOREIGN KEY (`user_winner_id`) REFERENCES `user_master_tbl` (`user_master_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_fixtures_tbl`
--

LOCK TABLES `user_fixtures_tbl` WRITE;
/*!40000 ALTER TABLE `user_fixtures_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_fixtures_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_master_tbl`
--

DROP TABLE IF EXISTS `user_master_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_master_tbl` (
  `user_master_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `mobile_number` varchar(45) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_master_tbl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_master_tbl`
--

LOCK TABLES `user_master_tbl` WRITE;
/*!40000 ALTER TABLE `user_master_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_master_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_player_selection_tbl`
--

DROP TABLE IF EXISTS `user_player_selection_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_player_selection_tbl` (
  `user_player_selection_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_selection_id` int(11) NOT NULL,
  `user_selection_tbl_id` int(11) NOT NULL,
  PRIMARY KEY (`user_player_selection_tbl_id`),
  KEY `player_selection_id_fk_idx` (`player_selection_id`),
  KEY `user_selection_tbl_id_fk_idx` (`user_selection_tbl_id`),
  CONSTRAINT `player_selection_id_fk` FOREIGN KEY (`player_selection_id`) REFERENCES `player_tbl` (`player_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_selection_tbl_id_fk` FOREIGN KEY (`user_selection_tbl_id`) REFERENCES `user_selection_tbl` (`user_selection_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_player_selection_tbl`
--

LOCK TABLES `user_player_selection_tbl` WRITE;
/*!40000 ALTER TABLE `user_player_selection_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_player_selection_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_selection_tbl`
--

DROP TABLE IF EXISTS `user_selection_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_selection_tbl` (
  `user_selection_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `match_fixture_id` int(11) NOT NULL,
  `user_team_selection_id` int(11) NOT NULL,
  `user_mom_selection_id` int(11) DEFAULT NULL,
  `user_points` int(11) DEFAULT '0',
  `result` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_selection_tbl_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `match_fixture_id_idx` (`match_fixture_id`),
  KEY `user_team_selection_id_fk_idx` (`user_team_selection_id`),
  KEY `user_mom_selection_ids_fk_idx` (`user_mom_selection_id`),
  CONSTRAINT `match_fixture_ids_fk` FOREIGN KEY (`match_fixture_id`) REFERENCES `match_fixtures_tbl` (`match_fixtures_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_ids_fk` FOREIGN KEY (`user_id`) REFERENCES `user_master_tbl` (`user_master_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_mom_selection_ids_fk` FOREIGN KEY (`user_mom_selection_id`) REFERENCES `player_tbl` (`player_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_team_selection_ids_fk` FOREIGN KEY (`user_team_selection_id`) REFERENCES `teams_tbl` (`teams_tbl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_selection_tbl`
--

LOCK TABLES `user_selection_tbl` WRITE;
/*!40000 ALTER TABLE `user_selection_tbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_selection_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue_tbl`
--

DROP TABLE IF EXISTS `venue_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venue_tbl` (
  `venue_tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `venue_name` varchar(100) NOT NULL,
  `venue_city` varchar(45) NOT NULL,
  `venue_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`venue_tbl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Venue Names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue_tbl`
--

LOCK TABLES `venue_tbl` WRITE;
/*!40000 ALTER TABLE `venue_tbl` DISABLE KEYS */;
INSERT INTO `venue_tbl` VALUES (1,'M. Chinnaswamy Stadium','Bengaluru',NULL),(2,'Feroz Shah Kotla Ground','Delhi',NULL),(3,'Rajiv Gandhi Intl. Cricket Stadium','Hyderabad',NULL),(4,'Green Park','Kanpur',NULL),(5,'Eden Gardens','Kolkata',NULL),(6,'IS Bindra Stadium','Mohali',NULL),(7,'Wankhede Stadium','Mumbai',NULL),(8,'Maharashtra Cricket Association\'s International Stadium','Pune',NULL),(9,'Saurashtra Cricket Association Stadium','Rajkot',NULL),(10,'Hilkar Cricket Stadium','Indore',NULL),(11,'TBD','TBD',NULL);
/*!40000 ALTER TABLE `venue_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ipl'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `event_create_user_fixture` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = '+05:30' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `event_create_user_fixture` ON SCHEDULE EVERY 360 MINUTE STARTS '2017-03-31 04:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
 
 DECLARE current_date_time DATETIME DEFAULT now();
 DECLARE v_match_fixtures_tbl_id INT;
 DECLARE v_match_datetime DATETIME;
 DECLARE hogaya INT DEFAULT FALSE;
 
 DECLARE match_fixture_cur CURSOR FOR select match_fixtures_tbl_id, match_datetime from match_fixtures_tbl where match_status= 0;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET hogaya = TRUE;
 
 OPEN match_fixture_cur;
 start_loop : LOOP
	FETCH match_fixture_cur INTO v_match_fixtures_tbl_id, v_match_datetime;
    
		IF hogaya THEN
			LEAVE start_loop;
		END IF;
        
		IF v_match_datetime = current_date_time THEN
			insert into test_tbl (col1,col2) values ('Event Triggered :: Match fixture ID',v_match_fixtures_tbl_id);
			CALL prc_user_fixture(v_match_fixtures_tbl_id);
		END IF;
 END LOOP;
 CLOSE match_fixture_cur;
 End */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'ipl'
--
/*!50003 DROP FUNCTION IF EXISTS `get_team_code` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_team_code`(p_teamId int) RETURNS varchar(10) CHARSET utf8
    DETERMINISTIC
BEGIN
    DECLARE v_teamCode varchar(10);


select team_code into v_teamCode from teams_tbl where teams_tbl_id = p_teamId;

	RETURN (v_teamCode);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_launch_missile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_launch_missile`(

	  IN matchId int,
	  
	  OUT outParam VARCHAR(255) 
	)
BEGIN


	DECLARE hogaya INT DEFAULT FALSE;

	DECLARE v_player_id INT;
	DECLARE v_runs INT DEFAULT 0;
	DECLARE v_wickets INT DEFAULT 0;
	DECLARE v_catches INT DEFAULT 0;
	DECLARE v_run_outs INT DEFAULT 0;

	DECLARE v_user_fixtures_tbl_id INT;
	DECLARE v_user_one_id INT;
	DECLARE v_user_two_id INT;

	DECLARE v_user_selection_tbl_id INT;
	DECLARE v_user_team_selection_id INT;
	DECLARE v_user_mom_selection_id INT;

	DECLARE v_team_winner_id INT;
	DECLARE v_match_player_mom_id INT;

	DECLARE v_total_points INT;
    
    DECLARE v_count INT DEFAULT 0;
	 
	DECLARE user_fixtures_cur CURSOR FOR SELECT user_fixtures_tbl_id, user_one_id, user_two_id 
										   FROM ipl.user_fixtures_tbl 
										  WHERE match_id = matchId;
										  
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET hogaya = TRUE;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	ROLLBACK;
	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
	set outParam = 'Error';
	END;

	START TRANSACTION;
    
	SELECT count(1) INTO v_count FROM match_fixtures_tbl WHERE match_fixtures_tbl_id = matchId;
    
    IF v_count > 0 THEN
    
		### UPDATING INDIVIDUAL PLAYERS TOTAL FOR MATCH
		UPDATE player_individual_score_tbl 
		SET 
		total_points = 
			(runs * (SELECT points FROM ipl.points_detail_tbl where points_category_code = 'run')) +
			(wickets * (SELECT points FROM ipl.points_detail_tbl where points_category_code = 'wkt')) +
			(catches * (SELECT points FROM ipl.points_detail_tbl where points_category_code = 'catch')) +
			(run_outs * (SELECT points FROM ipl.points_detail_tbl where points_category_code = 'runout'))
		WHERE
			match_fixture_id = matchId;


		### GETTING TEAM WINNER AND MAN OF THE MATCH
		SELECT mf.team_winner_id, pt.player_id 
		  INTO v_team_winner_id, v_match_player_mom_id
		 FROM ipl.match_fixtures_tbl mf, ipl.player_individual_score_tbl pt 
		WHERE mf.match_fixtures_tbl_id = pt.match_fixture_id
		  AND mf.match_fixtures_tbl_id = matchId
		  AND pt.is_mom = 1;
		 
		 
		###
		OPEN user_fixtures_cur;
		start_loop : LOOP
			FETCH user_fixtures_cur INTO v_user_fixtures_tbl_id, v_user_one_id, v_user_two_id;
			
				IF hogaya THEN
					LEAVE start_loop;
				END IF;
				
			### For FIRST USER
				SELECT user_selection_tbl_id, user_team_selection_id, user_mom_selection_id 
				  INTO v_user_selection_tbl_id, v_user_team_selection_id, v_user_mom_selection_id
				  FROM ipl.user_selection_tbl 
				 WHERE user_id = v_user_one_id 
				   AND match_fixture_id = matchId;
				
				
				SELECT SUM(p.total_points) INTO v_total_points 
				  FROM player_individual_score_tbl p
				 WHERE p.player_id IN (SELECT u.player_selection_id# INTO v_total_points 
										 FROM ipl.user_player_selection_tbl u
										 WHERE user_selection_tbl_id = v_user_selection_tbl_id);
				 
				
				UPDATE ipl.user_fixtures_tbl
				SET user_one_points = v_total_points + 
									  (CASE WHEN v_user_team_selection_id = v_team_winner_id 
											THEN (SELECT points FROM ipl.points_detail_tbl WHERE points_category_code = 'teamwin')
											ELSE 0 
									   END) +
									  (CASE WHEN v_user_mom_selection_id = v_match_player_mom_id 
											THEN (SELECT total_points FROM ipl.player_individual_score_tbl WHERE player_id = v_match_player_mom_id) 
											ELSE 0 
									   END)
				WHERE user_fixtures_tbl_id = v_user_fixtures_tbl_id;
				
				
			### For SECOND USER
				SELECT user_selection_tbl_id, user_team_selection_id, user_mom_selection_id 
				  INTO v_user_selection_tbl_id, v_user_team_selection_id, v_user_mom_selection_id
				  FROM ipl.user_selection_tbl 
				 WHERE user_id = v_user_two_id
				   AND match_fixture_id = matchId;
				
				
				SELECT SUM(p.total_points) INTO v_total_points 
				  FROM player_individual_score_tbl p
				 WHERE p.player_id IN (SELECT u.player_selection_id# INTO v_total_points 
										 FROM ipl.user_player_selection_tbl u
										 WHERE user_selection_tbl_id = v_user_selection_tbl_id);
				 
				UPDATE ipl.user_fixtures_tbl
				   SET user_two_points = v_total_points + 
									  (CASE WHEN v_user_team_selection_id = v_team_winner_id 
											THEN (SELECT points FROM ipl.points_detail_tbl WHERE points_category_code = 'teamwin') 
											ELSE 0 
									   END) +
									  (CASE WHEN v_user_mom_selection_id = v_match_player_mom_id 
											THEN (SELECT total_points FROM ipl.player_individual_score_tbl WHERE player_id = v_match_player_mom_id) 
											ELSE 0 
									   END),
					user_winner_id = (CASE WHEN user_one_points > v_total_points 
										   THEN user_one_id 
										   ELSE user_two_id 
									  END)
				 WHERE user_fixtures_tbl_id = v_user_fixtures_tbl_id;
			  
			### UPDATING THE USER SELECTION TABLE WITH THE FINAL POINTS
				UPDATE ipl.user_selection_tbl
				   SET user_points = (select user_one_points - user_two_points from user_fixtures_tbl where match_id = matchId),
					   result = (CASE WHEN user_points < 0 
									  THEN 'Lost' 
									  ELSE 'Won'
								 END)
				WHERE match_fixture_id = matchId
				  AND user_id = v_user_one_id;
				  
				UPDATE ipl.user_selection_tbl
				   SET user_points = (select user_two_points - user_one_points from user_fixtures_tbl where match_id = matchId),
					   result = (CASE WHEN user_points < 0 
									  THEN 'Lost'
									  ELSE 'Won'
								 END)
				WHERE match_fixture_id = matchId
				  AND user_id = v_user_two_id;          
				  
		END LOOP;
		CLOSE user_fixtures_cur;    

		set outParam = 'success';
	ELSE
		SET outParam = 'noMatch';
        
	end if;
	commit;

	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_players_selection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_players_selection`(
  IN userId int,
  IN matchId int,
  IN playerMomId int,
  IN winTeamId int,
  IN selectedPlayersIds VARCHAR(255),
  OUT outParam VARCHAR(255) 
)
BEGIN

DECLARE v_count INT DEFAULT 0;
DECLARE v_user_selection_tbl_id INT DEFAULT 0;
DECLARE strLen    INT DEFAULT 0;
DECLARE SubStrLen INT DEFAULT 0;
DECLARE PlayersId INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
set outParam = 'error';
END;

START TRANSACTION;

SELECT 
    COUNT(1)
INTO v_count FROM
    user_selection_tbl
WHERE
    user_id = userId
        AND match_fixture_id = matchId;

IF v_count = 0 THEN

	insert into user_selection_tbl
		(user_id, match_fixture_id, user_team_selection_id, user_mom_selection_id) values
		(userId , matchId , winTeamId , playerMomId);
        
ELSEIF v_count > 0 THEN

	update user_selection_tbl set user_team_selection_id=winTeamId ,user_mom_selection_id = playerMomId
	where user_id = userId and match_fixture_id = matchId;
    
end if;

IF selectedPlayersIds IS NULL THEN
    SET selectedPlayersIds = '';
END IF;

SELECT 
    user_selection_tbl_id
INTO v_user_selection_tbl_id FROM
    user_selection_tbl
WHERE
    user_id = userId
        AND match_fixture_id = matchId;

SELECT 
    COUNT(1)
INTO v_count FROM
    user_player_selection_tbl
WHERE
    user_selection_tbl_id = v_user_selection_tbl_id;

if v_count > 0 then

	DELETE FROM user_player_selection_tbl
			WHERE user_selection_tbl_id = v_user_selection_tbl_id;
            
end if;

do_this:
  LOOP
    SET strLen = CHAR_LENGTH(selectedPlayersIds);
	SET PlayersId = SUBSTRING_INDEX(selectedPlayersIds, '|', 1);
     #insert into test_tbl values (PlayersId);
    insert into user_player_selection_tbl (player_selection_id, user_selection_tbl_id) values (PlayersId,v_user_selection_tbl_id);
	
    SET SubStrLen = CHAR_LENGTH(SUBSTRING_INDEX(selectedPlayersIds, '|', 1)) + 2;
    SET selectedPlayersIds = MID(selectedPlayersIds, SubStrLen, strLen);

    IF selectedPlayersIds = '' THEN
      LEAVE do_this;
    END IF;
  END LOOP do_this;

set outParam = 'success';
commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prc_user_fixture` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_user_fixture`(

  IN matchId int,

  OUT outParam VARCHAR(255) 
)
BEGIN

DECLARE v_all_users_ids varchar(1000);
DECLARE v_users_ids varchar(1000);
DECLARE v_player_one_id INT;
DECLARE v_player_two_id INT;
DECLARE v_team_one_id INT;
DECLARE v_team_two_id INT;
DECLARE strLen    INT DEFAULT 0;
DECLARE SubStrLen INT DEFAULT 0;
DECLARE v_count INT DEFAULT 0;
DECLARE v_user_id INT;
DECLARE errorCode CHAR(5) DEFAULT '00000';
DECLARE msg TEXT;
DECLARE v_batsmen_count INT;
DECLARE v_bowler_count INT;
DECLARE v_all_rounder_count INT;
DECLARE v_random_player_ids varchar(1000);
DECLARE v_win_team_id  INT;
DECLARE v_mom_id INT;

DECLARE hogaya INT DEFAULT FALSE;
 
DECLARE users_not_voted_cur CURSOR FOR SELECT user_master_tbl_id FROM user_master_tbl 
									    WHERE user_master_tbl_id NOT IN (SELECT user_id FROM user_selection_tbl WHERE match_fixture_id = matchId)
                                          AND is_active = 1;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET hogaya = TRUE;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
GET DIAGNOSTICS CONDITION 1  errorCode = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
SET outParam = CONCAT("ERROR ", msg);
SELECT CONCAT("ERROR ", msg);
END;


START TRANSACTION;

select count(1) into v_count from match_fixtures_tbl where match_fixtures_tbl_id = matchId;

IF v_count > 0 then
	
    SELECT team_one_id, team_two_id 
      INTO v_team_one_id, v_team_two_id 
      FROM ipl.match_fixtures_tbl 
	 WHERE match_fixtures_tbl_id = matchId;
    
	SELECT GROUP_CONCAT(user_master_tbl_id ORDER BY rand() SEPARATOR '|') 
      INTO v_all_users_ids 
      FROM ipl.user_master_tbl 
	 WHERE is_active = 1;
     
	select count(1) into v_count from user_fixtures_tbl where match_id = matchId;

	if v_count > 0 then
	DELETE FROM user_fixtures_tbl 
	WHERE
		match_id = matchId;
		#AND user_winner_id IS NOT NULL; 
	end if;

	do_this:
	  LOOP
		SET strLen = CHAR_LENGTH(v_all_users_ids);
		SET v_users_ids = SUBSTRING_INDEX(v_all_users_ids, '|', 2);
		
		SET v_player_one_id =SUBSTRING_INDEX(v_users_ids, '|', 1);
		SET v_player_two_id =SUBSTRING_INDEX(v_users_ids, '|', -1);
		
		#insert into test_tbl values (matchId,v_player_one_id,v_player_two_id);
		
		if v_player_one_id = v_player_two_id then
		set v_player_two_id = (select user_master_tbl_id from user_master_tbl where first_name = 'Bot');
		end if;
		
		
		insert into user_fixtures_tbl (match_id, user_one_id, user_two_id) values (matchId,v_player_one_id,v_player_two_id);
	   
		SET SubStrLen = CHAR_LENGTH(SUBSTRING_INDEX(v_all_users_ids, '|', 2)) + 2;
		SET v_all_users_ids = MID(v_all_users_ids, SubStrLen, strLen);

		IF v_all_users_ids = '' THEN
		  LEAVE do_this;
		END IF;
	  END LOOP do_this;

	### Assign dummy vote for the user who hasent voted
	SELECT CAST(st.system_parameter_value AS UNSIGNED) into v_batsmen_count FROM system_parameter_tbl st where st.system_parameter_name = 'BatsmenCount';
    SELECT CAST(st.system_parameter_value AS UNSIGNED) into v_bowler_count FROM system_parameter_tbl st where st.system_parameter_name = 'BowlerCount';
    SELECT CAST(st.system_parameter_value AS UNSIGNED) into v_all_rounder_count FROM system_parameter_tbl st where st.system_parameter_name = 'AllRounderCount';
    
	 OPEN users_not_voted_cur;
	 start_loop : LOOP
		FETCH users_not_voted_cur INTO v_user_id;
		
			IF hogaya THEN
				LEAVE start_loop;
				set hogaya = false;
			END IF;
			
			### logic for random selection of 7 players, man of the match, win team id
            SELECT concat((SUBSTRING_INDEX((GROUP_CONCAT(CASE pt.player_role_id WHEN 1 then pt.player_tbl_id END ORDER BY rand() SEPARATOR '|')),'|',v_batsmen_count)),'|',
				   (SUBSTRING_INDEX((GROUP_CONCAT(CASE pt.player_role_id WHEN 2 then pt.player_tbl_id END ORDER BY rand() SEPARATOR '|')),'|',v_bowler_count)),'|',
				   (SUBSTRING_INDEX((GROUP_CONCAT(CASE pt.player_role_id WHEN 3 then pt.player_tbl_id END ORDER BY rand() SEPARATOR '|')),'|',v_all_rounder_count)))
			  INTO v_random_player_ids
			  FROM ipl.player_tbl pt
			 WHERE player_team_id IN (v_team_one_id,v_team_two_id);
             
             SELECT teams_tbl_id INTO v_win_team_id FROM teams_tbl WHERE teams_tbl_id IN (v_team_one_id,v_team_two_id) ORDER BY rand() LIMIT 1;             
            		
			SET v_mom_id = CAST((SUBSTRING_INDEX(SUBSTRING_INDEX(v_random_player_ids, '|', rand()*(LENGTH(v_random_player_ids)-LENGTH(REPLACE(v_random_player_ids, '|', '')))+1),'|',-1)) AS UNSIGNED);
			###
            
            #insert into test_tbl values (v_random_player_ids,v_win_team_id, v_mom_id);
            set @outParam = '0';
            CALL prc_players_selection(v_user_id,matchId,v_mom_id,v_win_team_id,v_random_player_ids,@outParam);
            select @outParam;
            
	 END LOOP;
	 CLOSE users_not_voted_cur;
	 
     set outParam = 'success';


 ELSE
	SET outParam = 'noMatch';
 end if;
 
 commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-31 20:37:32
