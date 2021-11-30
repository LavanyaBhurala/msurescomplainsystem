-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: aidesk
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.4-MariaDB-1:10.6.4+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ticket_action_logs`
--

DROP TABLE IF EXISTS `ticket_action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_action_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `action_id` int(10) unsigned NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_actn_lgs_tkt_usr` (`user_id`),
  KEY `fk_tkt_actn_lgs_tkt` (`ticket_id`),
  KEY `fk_tkt_actn_lgs_tkt_actn_mstr` (`action_id`),
  CONSTRAINT `fk_tkt_actn_lgs_tkt` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  CONSTRAINT `fk_tkt_actn_lgs_tkt_actn_mstr` FOREIGN KEY (`action_id`) REFERENCES `ticket_action_master` (`id`),
  CONSTRAINT `fk_tkt_actn_lgs_tkt_usr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_action_logs`
--

LOCK TABLES `ticket_action_logs` WRITE;
/*!40000 ALTER TABLE `ticket_action_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_action_master`
--

DROP TABLE IF EXISTS `ticket_action_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_action_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_action_master`
--

LOCK TABLES `ticket_action_master` WRITE;
/*!40000 ALTER TABLE `ticket_action_master` DISABLE KEYS */;
INSERT INTO `ticket_action_master` VALUES (1,'CREATED','Ticket was created.','N','Y','2021-10-30 11:53:29','2021-10-30 11:53:29'),(2,'UPDATED','Ticket was updated.','N','Y','2021-10-30 11:53:29','2021-10-30 11:53:29'),(3,'MARKED_DUPLICATE','Ticket was marked duplicate.','N','Y','2021-10-30 11:53:29','2021-10-30 11:53:29'),(4,'COMMENTED','Comment was added on ticket.','N','Y','2021-10-30 11:53:29','2021-10-30 11:53:29'),(5,'CHANGED_STATUS','Ticket status was changed.','N','Y','2021-10-30 11:53:29','2021-10-30 11:53:29');
/*!40000 ALTER TABLE `ticket_action_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_assignee_mappings`
--

DROP TABLE IF EXISTS `ticket_assignee_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_assignee_mappings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_asgn_mpng_tkt_usr` (`user_id`),
  KEY `fk_tkt_asgn_mpng_tkt` (`ticket_id`),
  CONSTRAINT `fk_tkt_asgn_mpng_tkt` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  CONSTRAINT `fk_tkt_asgn_mpng_tkt_usr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_assignee_mappings`
--

LOCK TABLES `ticket_assignee_mappings` WRITE;
/*!40000 ALTER TABLE `ticket_assignee_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_assignee_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_comments`
--

DROP TABLE IF EXISTS `ticket_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `comment` text NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_cmnts_tkt_usr` (`user_id`),
  KEY `fk_tkt_cmnts_tkt` (`ticket_id`),
  CONSTRAINT `fk_tkt_cmnts_tkt` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`),
  CONSTRAINT `fk_tkt_cmnts_tkt_usr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_comments`
--

LOCK TABLES `ticket_comments` WRITE;
/*!40000 ALTER TABLE `ticket_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_documents`
--

DROP TABLE IF EXISTS `ticket_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ticket_id` int(10) unsigned NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_doc_tkt` (`ticket_id`),
  CONSTRAINT `fk_tkt_doc_tkt` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_documents`
--

LOCK TABLES `ticket_documents` WRITE;
/*!40000 ALTER TABLE `ticket_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_resolution`
--

DROP TABLE IF EXISTS `ticket_resolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_resolution` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) unsigned NOT NULL,
  `desc` text NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_rsltn_tkt` (`ticket_id`),
  CONSTRAINT `fk_tkt_rsltn_tkt` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_resolution`
--

LOCK TABLES `ticket_resolution` WRITE;
/*!40000 ALTER TABLE `ticket_resolution` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_resolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_status_master`
--

DROP TABLE IF EXISTS `ticket_status_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_status_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_status_master`
--

LOCK TABLES `ticket_status_master` WRITE;
/*!40000 ALTER TABLE `ticket_status_master` DISABLE KEYS */;
INSERT INTO `ticket_status_master` VALUES (1,'CREATED','Ticket Created.','N','Y','2021-10-30 12:06:49','2021-10-30 12:06:49'),(2,'DUPLICATE','Duplicate Ticket.','N','Y','2021-10-30 12:06:49','2021-10-30 12:06:49'),(3,'RESOLVED','Resolved Ticket.','N','Y','2021-10-30 12:06:49','2021-10-30 12:06:49'),(4,'REOPENED','Ticket Reopened.','N','Y','2021-10-30 12:06:49','2021-10-30 12:06:49');
/*!40000 ALTER TABLE `ticket_status_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `desc` text DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_tkt_tkt_usr` (`user_id`),
  KEY `fk_tkt_tkt_sts` (`status_id`),
  CONSTRAINT `fk_tkt_tkt_sts` FOREIGN KEY (`status_id`) REFERENCES `ticket_status_master` (`id`),
  CONSTRAINT `fk_tkt_tkt_usr` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'test','Test',4,1,'N','Y','2021-10-30 18:05:29','2021-10-30 18:05:29');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type_master`
--

DROP TABLE IF EXISTS `user_type_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type_master` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type_master`
--

LOCK TABLES `user_type_master` WRITE;
/*!40000 ALTER TABLE `user_type_master` DISABLE KEYS */;
INSERT INTO `user_type_master` VALUES (1,'Student','Student user who primarily logs the ticket.','N','Y','2021-10-27 20:22:56','2021-10-27 20:22:56'),(2,'Worker','Worker is the assignee of the ticket.','N','Y','2021-10-27 20:22:56','2021-10-27 20:22:56'),(3,'Admin','Admin/ Manager assigns the student\'s ticket to one of the worker','N','Y','2021-10-27 20:22:56','2021-10-27 20:22:56');
/*!40000 ALTER TABLE `user_type_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `mobile` mediumtext DEFAULT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `is_deleted` char(1) DEFAULT 'N',
  `is_active` char(1) DEFAULT 'Y',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_usr_usr_type` (`type_id`),
  CONSTRAINT `fk_usr_usr_type` FOREIGN KEY (`type_id`) REFERENCES `user_type_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'Nishant Arora','nishanta454@gmail.com','test@123','9582965097',1,'N','Y','2021-10-30 11:23:15','2021-10-30 11:23:15'),(5,'Admin','nishanta455@gmail.com',NULL,'admin@123',3,'N','Y','2021-10-30 18:15:26','2021-10-30 18:15:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'aidesk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-31  4:00:13
