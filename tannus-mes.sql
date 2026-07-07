CREATE DATABASE  IF NOT EXISTS `tanus` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tanus`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: tanus
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `export_change_request`
--

DROP TABLE IF EXISTS `export_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_change_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `export_order_id` bigint NOT NULL,
  `request_user` varchar(50) DEFAULT NULL,
  `request_reason` text,
  `request_content` text,
  `status` varchar(20) DEFAULT 'WAITING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `checked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_change_request`
--

LOCK TABLES `export_change_request` WRITE;
/*!40000 ALTER TABLE `export_change_request` DISABLE KEYS */;
INSERT INTO `export_change_request` VALUES (1,4,'물류팀','수량부족','40-622 1개더 추가 요청드립니다.','REJECTED','2026-05-19 15:41:20','2026-05-22 04:17:12'),(2,4,'물류팀','수량부족','29 퓨전 4개 더 요청드립니다.','APPROVED','2026-05-22 05:25:52','2026-05-22 06:11:36'),(3,8,'물류팀','기타','수량변경','APPROVED','2026-06-27 06:20:04','2026-06-27 06:37:33'),(4,9,'물류팀','수량부족','29퓨전 1개만 요청드립니다.','APPROVED','2026-06-29 12:22:01','2026-06-29 12:22:15'),(5,9,'물류팀','수량부족','29퓨전 재고 찾았습니다.','APPROVED','2026-06-29 12:24:42','2026-06-29 12:25:21'),(6,12,'물류팀','수량부족','44-507 1개부족합니다.','APPROVED','2026-07-01 17:19:15','2026-07-01 17:20:02');
/*!40000 ALTER TABLE `export_change_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_order`
--

DROP TABLE IF EXISTS `export_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_date` varchar(20) DEFAULT NULL,
  `worker_name` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'WAITING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `stock_applied` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_order`
--

LOCK TABLES `export_order` WRITE;
/*!40000 ALTER TABLE `export_order` DISABLE KEYS */;
INSERT INTO `export_order` VALUES (1,'2026-05-21','관리자','대만 수출','DONE','2026-05-19 02:41:14','N'),(2,'2026-05-20','관리자','일본','CANCELLED','2026-05-19 13:43:06','N'),(3,'2026-05-22','관리자','중국 쿤산','DONE','2026-05-19 13:44:34','N'),(4,'2026-05-20','관리자','호주 출고','CANCELLED','2026-05-19 15:39:41','Y'),(5,'2026-05-20','관리자','네덜란드 긴급호출','DONE','2026-05-19 16:43:33','Y'),(6,'2026-05-20','관리자','타케다 긴급요청','DONE','2026-05-20 01:29:35','Y'),(7,'2026-05-21','관리자','중국 쿤산','CANCELLED','2026-05-20 01:35:11','N'),(8,'2026-06-27','관리자','이탈리아 긴급출하','DONE','2026-06-27 06:18:58','Y'),(9,'2026-06-29','관리자','긴급 입고','DONE','2026-06-29 12:20:24','Y'),(10,'2026-06-29','관리자','이탈리아 긴급출하','DONE','2026-06-29 17:53:34','Y'),(11,'2026-06-30','관리자','긴급','DONE','2026-06-30 12:00:19','Y'),(12,'2026-07-01','관리자','대만 수출','DONE','2026-07-01 13:45:15','Y');
/*!40000 ALTER TABLE `export_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_order_detail`
--

DROP TABLE IF EXISTS `export_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `export_order_id` bigint NOT NULL,
  `product_type` varchar(30) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `hardness` varchar(20) DEFAULT NULL,
  `base_qty` int DEFAULT '0',
  `box_count` int DEFAULT '0',
  `each_qty` int DEFAULT '0',
  `total_qty` int DEFAULT '0',
  `display_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `outbound_status` varchar(30) DEFAULT 'WAITING',
  `outbound_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `export_order_id` (`export_order_id`),
  CONSTRAINT `export_order_detail_ibfk_1` FOREIGN KEY (`export_order_id`) REFERENCES `export_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_order_detail`
--

LOCK TABLES `export_order_detail` WRITE;
/*!40000 ALTER TABLE `export_order_detail` DISABLE KEYS */;
INSERT INTO `export_order_detail` VALUES (1,1,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'TIRE / 44-559 / MIDNIGHT / R','2026-05-19 02:41:14','DONE','2026-06-27 13:27:51'),(2,1,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'TIRE / 44-507 / MIDNIGHT / R','2026-05-19 02:41:14','DONE','2026-06-29 14:27:30'),(3,1,'ARMOUR','40-622','RED','R',51,1,0,51,'ARMOUR / 40-622 / RED / R','2026-05-19 02:41:14','WAITING',NULL),(4,1,'ARMOUR','63-622','RED','R',24,0,2,2,'ARMOUR / 63-622 / RED / R','2026-05-19 02:41:14','WAITING',NULL),(5,1,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'TUBELESS / 27.5 (Fusion) / BLACK / R','2026-05-19 02:41:14','DONE','2026-06-30 14:23:14'),(6,1,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'TUBELESS / 29 (Fusion) / BLACK / R','2026-05-19 02:41:14','DONE','2026-07-01 17:24:01'),(8,3,'TIRE','51-559','MIDNIGHT','R',15,2,0,30,'TIRE / 51-559 / MIDNIGHT / R','2026-05-19 13:44:34','DONE','2026-05-19 13:47:00'),(9,3,'TIRE','44-559','MIDNIGHT','R',20,1,0,20,'TIRE / 44-559 / MIDNIGHT / R','2026-05-19 13:44:34','DONE','2026-05-19 13:46:30'),(12,5,'TIRE','44-559','MIDNIGHT','R',20,2,0,40,'TIRE / 44-559 / MIDNIGHT / R','2026-05-19 16:43:33','DONE','2026-05-19 17:40:57'),(13,5,'TIRE','51-559','MIDNIGHT','R',15,0,6,6,'TIRE / 51-559 / MIDNIGHT / R','2026-05-19 16:43:33','DONE','2026-05-19 17:41:06'),(14,6,'ARMOUR','40-622','RED','R',51,0,5,5,'ARMOUR / 40-622 / RED / R','2026-05-20 01:29:35','WAITING',NULL),(15,6,'TIRE','44-559','MIDNIGHT','R',20,2,0,40,'TIRE / 44-559 / MIDNIGHT / R','2026-05-20 01:29:35','DONE','2026-05-20 01:30:33'),(23,7,'TIRE','44-559','MIDNIGHT','R',20,7,4,144,NULL,'2026-05-22 04:17:26','WAITING',NULL),(28,4,'ARMOUR','40-622','RED','R',51,0,25,25,NULL,'2026-05-22 06:06:50','WAITING',NULL),(29,4,'TUBELESS','29 (Fusion)','BLACK','R',24,0,7,7,NULL,'2026-05-22 06:06:50','WAITING',NULL),(34,8,'TIRE','44-559','MIDNIGHT','R',20,2,2,42,'TIRE / 44-559 / MIDNIGHT / R','2026-06-27 06:37:33','DONE','2026-06-27 12:09:43'),(35,2,'TIRE','44-559','MIDNIGHT','R',20,4,0,80,'TIRE / 44-559 / MIDNIGHT / R','2026-06-27 19:51:37','WAITING',NULL),(40,9,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'TUBELESS / 29 (Fusion) / BLACK / R','2026-06-29 12:25:21','DONE','2026-06-29 15:18:04'),(41,9,'TUBELESS','27.5 (Pro)','BLACK','R',24,1,2,26,'TUBELESS / 27.5 (Pro) / BLACK / R','2026-06-29 12:25:21','DONE','2026-06-29 15:18:21'),(42,10,'ARMOUR','120-559','RED','R',16,0,1,1,'ARMOUR / 120-559 / RED / R','2026-06-29 17:53:34','DONE','2026-06-29 18:20:31'),(43,11,'TUBELESS','26mm Lite','BLACK','R',50,1,0,50,'TUBELESS / 26mm Lite / BLACK / R','2026-06-30 12:00:19','DONE','2026-06-30 14:23:40'),(44,11,'ARMOUR','75-622','RED','R',20,1,0,20,'ARMOUR / 75-622 / RED / R','2026-06-30 12:00:19','DONE','2026-06-30 14:23:28'),(51,12,'TIRE','44-559','CARROT','R',20,2,2,42,'TIRE / 44-559 / CARROT / R','2026-07-01 17:20:02','DONE','2026-07-01 17:23:50'),(52,12,'TIRE','44-507','MIDNIGHT','R',28,0,3,3,'TIRE / 44-507 / MIDNIGHT / R','2026-07-01 17:20:02','DONE','2026-07-01 17:23:56');
/*!40000 ALTER TABLE `export_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_outbound_scan`
--

DROP TABLE IF EXISTS `export_outbound_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_outbound_scan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `export_order_id` bigint NOT NULL,
  `detail_id` bigint NOT NULL,
  `unit_type` varchar(20) NOT NULL,
  `unit_no` int NOT NULL,
  `qty` int NOT NULL,
  `scan_status` varchar(20) DEFAULT 'WAITING',
  `scanned_at` datetime DEFAULT NULL,
  `stock_applied` varchar(1) DEFAULT 'N',
  `stock_applied_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `qr_type` varchar(30) DEFAULT 'EXPORT',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_outbound_scan`
--

LOCK TABLES `export_outbound_scan` WRITE;
/*!40000 ALTER TABLE `export_outbound_scan` DISABLE KEYS */;
INSERT INTO `export_outbound_scan` VALUES (1,8,34,'BOX',1,20,'DONE','2026-06-27 10:49:22','N',NULL,'2026-06-27 10:39:13','EXPORT'),(2,8,34,'BOX',2,20,'DONE','2026-06-27 10:49:32','N',NULL,'2026-06-27 10:39:13','EXPORT'),(3,8,34,'EACH',1,2,'DONE','2026-06-27 12:09:43','N',NULL,'2026-06-27 10:39:13','EXPORT'),(4,8,1,'UNPLANNED',1,4,'DONE','2026-06-27 13:27:51','N',NULL,'2026-06-27 11:39:48','UNPLANNED_EXPORT'),(5,4,28,'EACH',1,25,'WAITING',NULL,'N',NULL,'2026-06-27 17:48:59','EXPORT'),(6,4,29,'EACH',1,7,'WAITING',NULL,'N',NULL,'2026-06-27 17:48:59','EXPORT'),(52,9,40,'EACH',1,2,'DONE','2026-06-29 15:18:04','N',NULL,'2026-06-29 15:12:35','EXPORT'),(53,9,41,'BOX',1,24,'DONE','2026-06-29 15:18:15','N',NULL,'2026-06-29 15:12:35','EXPORT'),(54,9,41,'EACH',1,2,'DONE','2026-06-29 15:18:21','N',NULL,'2026-06-29 15:12:35','EXPORT'),(55,9,2,'UNPLANNED',1,2,'DONE','2026-06-29 15:17:51','N',NULL,'2026-06-29 15:12:35','UNPLANNED_EXPORT'),(56,10,42,'EACH',1,1,'DONE','2026-06-29 18:36:37','N',NULL,'2026-06-29 18:20:07','EXPORT'),(57,11,43,'BOX',1,50,'DONE','2026-06-30 14:23:40','N',NULL,'2026-06-30 14:22:49','EXPORT'),(58,11,44,'BOX',1,20,'DONE','2026-06-30 14:23:28','N',NULL,'2026-06-30 14:22:49','EXPORT'),(59,11,5,'UNPLANNED',1,50,'DONE','2026-06-30 14:23:23','N',NULL,'2026-06-30 14:22:49','UNPLANNED_EXPORT'),(60,12,51,'BOX',1,20,'DONE','2026-07-01 17:23:50','N',NULL,'2026-07-01 17:20:44','EXPORT'),(61,12,51,'BOX',2,20,'DONE','2026-07-01 17:23:43','N',NULL,'2026-07-01 17:20:44','EXPORT'),(62,12,51,'EACH',1,2,'DONE','2026-07-01 17:23:36','N',NULL,'2026-07-01 17:20:44','EXPORT'),(63,12,52,'EACH',1,3,'DONE','2026-07-01 17:23:56','N',NULL,'2026-07-01 17:20:44','EXPORT'),(64,12,6,'UNPLANNED',1,2,'DONE','2026-07-01 17:24:01','N',NULL,'2026-07-01 17:20:44','UNPLANNED_EXPORT');
/*!40000 ALTER TABLE `export_outbound_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_type` varchar(30) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `hardness` varchar(20) NOT NULL,
  `base_qty` int DEFAULT '0',
  `current_qty` int DEFAULT '0',
  `location` varchar(100) DEFAULT NULL,
  `last_in_date` datetime DEFAULT NULL,
  `last_out_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `item_type` varchar(20) DEFAULT '정매대',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_item_option` (`product_type`,`model_name`,`color`,`hardness`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'TIRE','40-622','MIDNIGHT','R',20,179,NULL,NULL,'2026-06-29 15:33:22','2026-06-29 10:42:16','정매대'),(2,'TIRE','32-622','MIDNIGHT','R',24,240,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(3,'TIRE','51-559','MIDNIGHT','R',15,75,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(4,'TIRE','44-559','MIDNIGHT','R',20,158,NULL,NULL,'2026-07-01 23:49:45','2026-06-29 10:42:16','정매대'),(5,'TIRE','35-590','MIDNIGHT','R',24,96,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(6,'TIRE','35-559','MIDNIGHT','R',24,120,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(7,'TIRE','44-507','MIDNIGHT','R',28,78,NULL,NULL,'2026-07-01 23:49:45','2026-06-29 10:42:16','정매대'),(8,'TIRE','40-540','MIDNIGHT','R',28,112,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(9,'TIRE','40-501','MIDNIGHT','R',28,56,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(10,'TIRE','51-406','MIDNIGHT','R',15,45,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(11,'TIRE','40-406','MIDNIGHT','R',28,196,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(12,'TIRE','40-355','MIDNIGHT','R',28,28,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(13,'TIRE','40-349','MIDNIGHT','R',28,84,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(14,'TIRE','40-305','MIDNIGHT','R',28,140,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(15,'TIRE','28-622','MIDNIGHT','R',30,300,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(16,'TIRE','25-622','MIDNIGHT','R',30,210,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(17,'TIRE','23-622','MIDNIGHT','R',30,93,NULL,'2026-06-30 12:29:53',NULL,'2026-06-29 10:42:16','정매대'),(18,'TIRE','28-451','MIDNIGHT','R',30,60,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(19,'TIRE','32-406','MIDNIGHT','R',30,150,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(20,'TIRE','32-349','MIDNIGHT','R',30,30,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(21,'TIRE','32-305','MIDNIGHT','R',30,120,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(22,'ARMOUR','47-559','RED','R',40,120,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(23,'ARMOUR','63-559','RED','R',24,72,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(24,'ARMOUR','63-584','RED','R',24,96,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(25,'ARMOUR','40-622','RED','R',51,153,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(26,'ARMOUR','47-622','RED','R',38,114,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(27,'ARMOUR','63-622','RED','R',24,51,NULL,'2026-06-30 04:08:48',NULL,'2026-06-29 10:42:16','정매대'),(28,'ARMOUR','63-406','RED','R',30,90,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(29,'ARMOUR','63-507','RED','R',26,52,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(30,'ARMOUR','34-622','RED','R',57,171,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(31,'ARMOUR','54-559','RED','R',28,84,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(32,'ARMOUR','50-406','RED','R',60,180,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(33,'ARMOUR','75-584','RED','R',20,40,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(34,'ARMOUR','75-622','RED','R',20,40,NULL,NULL,'2026-06-30 14:23:43','2026-06-29 10:42:16','정매대'),(35,'ARMOUR','40-540','RED','R',56,112,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(36,'ARMOUR','75-559','RED','R',20,20,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(37,'ARMOUR','34-590','RED','R',57,57,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(38,'ARMOUR','37-540','RED','R',57,171,NULL,'2026-07-02 02:03:16',NULL,'2026-06-29 10:42:16','정매대'),(39,'ARMOUR','120-559','RED','R',16,31,NULL,NULL,'2026-06-29 18:36:43','2026-06-29 10:42:16','정매대'),(40,'ARMOUR','100-406','RED','R',20,80,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(41,'ARMOUR','120-406','RED','R',20,40,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(42,'ARMOUR','100-507','RED','R',20,60,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(43,'ARMOUR','80-90-17','RED','R',24,48,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(44,'ARMOUR','70-90-17','RED','R',24,72,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(45,'TUBELESS','27.5 (Pro)','BLACK','R',24,46,NULL,NULL,'2026-06-29 15:18:25','2026-06-29 10:42:16','정매대'),(46,'TUBELESS','29 (Pro)','BLACK','R',24,120,NULL,'2026-06-30 12:29:53',NULL,'2026-06-29 10:42:16','정매대'),(47,'TUBELESS','27.5 (Fusion)','BLACK','R',24,72,NULL,'2026-07-01 17:01:30',NULL,'2026-06-29 10:42:16','정매대'),(48,'TUBELESS','29 (Fusion)','BLACK','R',24,70,NULL,NULL,'2026-06-29 15:18:25','2026-06-29 10:42:16','정매대'),(49,'TUBELESS','26mm Lite','BLACK','R',50,50,NULL,NULL,'2026-06-30 14:23:43','2026-06-29 10:42:16','정매대'),(50,'TUBELESS','32mm Lite','BLACK','R',50,150,NULL,NULL,NULL,'2026-06-29 10:42:16','정매대'),(51,'TUBELESS','27.5 Lite (32mm)','BLACK','R',50,52,NULL,'2026-07-01 17:01:30',NULL,'2026-06-29 10:42:16','정매대'),(52,'TIRE','63-622','MIDNIGHT','R',20,20,'미지정','2026-06-29 16:09:22',NULL,'2026-06-29 16:09:22','정매대'),(55,'TIRE','34-622','MIDNIGHT','R',24,3,'미지정','2026-06-29 17:25:23','2026-06-30 14:11:24','2026-06-29 17:25:23','정매대'),(56,'TIRE','44-559','CARROT','R',20,0,'미지정','2026-07-01 17:01:30','2026-07-01 23:49:45','2026-07-01 17:01:30','정매대'),(57,'TIRE','25-622','VOLCANO','R',30,1,'미지정','2026-07-01 17:01:30',NULL,'2026-07-01 17:01:30','정매대');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packing_change_request`
--

DROP TABLE IF EXISTS `packing_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packing_change_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `packing_order_id` bigint NOT NULL,
  `request_user` varchar(50) DEFAULT NULL,
  `request_reason` text,
  `request_content` text,
  `status` varchar(20) DEFAULT 'WAITING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `checked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packing_change_request`
--

LOCK TABLES `packing_change_request` WRITE;
/*!40000 ALTER TABLE `packing_change_request` DISABLE KEYS */;
INSERT INTO `packing_change_request` VALUES (1,3,'포장팀','fd','fdsa','REJECTED','2026-04-26 11:58:51','2026-05-09 23:27:49'),(2,3,'포장팀','fdsa','fdsa','REJECTED','2026-04-26 11:59:30','2026-05-09 23:27:43'),(3,4,'포장팀','ㄹㅇㄴ','ㄹㅇㄴㅁㄹㅇ','REJECTED','2026-04-26 12:47:07','2026-05-09 23:27:39'),(4,4,'포장팀','fdsa','fdsafsd','REJECTED','2026-04-26 13:34:12','2026-04-26 16:54:25'),(5,4,'포장팀','tret','tretre','REJECTED','2026-04-27 07:46:54','2026-05-09 23:27:28'),(6,2,'포장팀','tretre','tretre','APPROVED','2026-04-27 07:47:04','2026-05-09 12:43:47'),(7,5,'포장팀','실수했습니다.. 아닙니다..','갯수','REJECTED','2026-05-02 11:41:04','2026-05-02 11:41:22'),(8,2,'포장팀','fdsa','fdas','APPROVED','2026-05-09 12:44:43','2026-05-09 16:11:04'),(9,6,'포장팀','44-559 총42개입니다..','확인부탁드립니다.','REJECTED','2026-05-10 01:15:18','2026-05-15 02:20:05'),(10,7,'포장팀','수량변경','44-559 2개 더 요청드립니다.','APPROVED','2026-05-22 04:20:05','2026-05-22 06:11:53'),(11,7,'포장팀','수량변경','40개로 요청변경','APPROVED','2026-05-22 06:38:13','2026-05-22 06:38:53'),(12,7,'포장팀','수량변경','40개로 요청 드립니다.','APPROVED','2026-05-22 06:40:14','2026-05-22 06:45:39'),(13,1,'포장팀','29fusion은 빼주시면 될듯합니다.\r\n불량입니다.','불량','APPROVED','2026-06-26 01:40:30','2026-06-26 01:41:32'),(14,10,'포장팀','3개로 늘려주셔도 됩니다.','3개요청','APPROVED','2026-06-29 19:00:31','2026-06-29 19:00:50'),(15,12,'포장팀','생산 1개 더 했습니다.','44-559 낱개 1개 더해주시면 됩니다.','APPROVED','2026-07-01 14:36:24','2026-07-01 14:48:33');
/*!40000 ALTER TABLE `packing_change_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packing_inbound_scan`
--

DROP TABLE IF EXISTS `packing_inbound_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packing_inbound_scan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `packing_order_id` bigint NOT NULL,
  `detail_id` bigint NOT NULL,
  `unit_type` varchar(20) NOT NULL,
  `unit_no` int NOT NULL,
  `qty` int NOT NULL,
  `scan_status` varchar(20) DEFAULT 'WAITING',
  `scanned_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `stock_applied` varchar(1) DEFAULT 'N',
  `stock_applied_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packing_inbound_scan`
--

LOCK TABLES `packing_inbound_scan` WRITE;
/*!40000 ALTER TABLE `packing_inbound_scan` DISABLE KEYS */;
INSERT INTO `packing_inbound_scan` VALUES (1,4,32,'BOX',1,20,'DONE','2026-06-26 17:09:39','2026-06-26 17:01:55','Y','2026-06-26 17:10:09'),(2,4,32,'BOX',2,20,'DONE','2026-06-26 17:04:31','2026-06-26 17:01:55','Y','2026-06-26 17:10:09'),(4,4,32,'EACH',1,1,'DONE','2026-06-26 17:04:12','2026-06-26 17:01:55','Y','2026-06-26 17:10:09'),(5,4,33,'EACH',1,1,'DONE','2026-06-26 17:10:02','2026-06-26 17:01:55','Y','2026-06-26 17:10:09'),(7,3,13,'BOX',1,20,'DONE','2026-06-26 17:31:26','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(8,3,13,'BOX',2,20,'DONE','2026-06-26 17:30:27','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(9,3,13,'EACH',1,1,'DONE','2026-06-26 17:28:54','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(10,3,14,'EACH',1,1,'DONE','2026-06-26 17:32:10','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(11,3,15,'BOX',1,51,'DONE','2026-06-26 17:31:55','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(12,3,16,'EACH',1,2,'DONE','2026-06-26 17:31:41','2026-06-26 17:28:31','Y','2026-06-26 17:35:44'),(13,3,17,'BOX',1,24,'WAITING',NULL,'2026-06-26 17:28:31','N',NULL),(14,1,79,'BOX',1,20,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(15,1,79,'BOX',2,20,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(16,1,79,'EACH',1,1,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(17,1,80,'EACH',1,1,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(18,1,81,'BOX',1,51,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(19,1,82,'EACH',1,2,'DONE','2026-06-26 18:40:04','2026-06-26 17:35:34','Y','2026-06-26 18:40:25'),(20,1,83,'BOX',1,24,'WAITING',NULL,'2026-06-26 17:35:34','N',NULL),(21,10,90,'EACH',1,3,'DONE','2026-06-30 03:40:16','2026-06-30 02:01:48','Y','2026-06-30 04:08:48'),(22,10,19,'UNPLANNED_BOX',1,20,'DONE','2026-06-30 04:08:41','2026-06-30 02:24:27','N',NULL),(23,10,19,'UNPLANNED_BOX',2,20,'DONE','2026-06-30 03:56:30','2026-06-30 02:24:27','N',NULL),(24,11,91,'EACH',1,3,'DONE','2026-06-30 12:29:48','2026-06-30 12:28:33','Y','2026-06-30 12:29:53'),(25,11,22,'UNPLANNED_BOX',1,24,'DONE','2026-06-30 12:29:32','2026-06-30 12:29:11','N',NULL),(26,12,98,'BOX',1,20,'DONE','2026-07-01 16:55:37','2026-07-01 14:53:11','Y','2026-07-01 17:01:30'),(27,12,98,'BOX',2,20,'DONE','2026-07-01 16:55:47','2026-07-01 14:53:11','Y','2026-07-01 17:01:30'),(28,12,98,'EACH',1,3,'DONE','2026-07-01 16:56:00','2026-07-01 14:53:11','Y','2026-07-01 17:01:30'),(29,12,99,'BOX',1,24,'DONE','2026-07-01 17:01:28','2026-07-01 14:53:11','Y','2026-07-01 17:01:30'),(30,12,23,'UNPLANNED_EACH',1,1,'DONE','2026-07-01 16:56:25','2026-07-01 15:31:10','N',NULL),(31,12,27,'UNPLANNED_EACH',1,2,'DONE','2026-07-01 16:56:15','2026-07-01 16:35:13','N',NULL),(32,14,101,'BOX',1,57,'DONE','2026-07-02 02:03:05','2026-07-02 02:01:57','Y','2026-07-02 02:03:16');
/*!40000 ALTER TABLE `packing_inbound_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packing_order`
--

DROP TABLE IF EXISTS `packing_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packing_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_date` date NOT NULL,
  `requested_by` varchar(100) NOT NULL,
  `target_team` varchar(50) DEFAULT '포장팀',
  `status` varchar(50) DEFAULT 'REQUESTED',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packing_order`
--

LOCK TABLES `packing_order` WRITE;
/*!40000 ALTER TABLE `packing_order` DISABLE KEYS */;
INSERT INTO `packing_order` VALUES (1,'2026-04-29','관리자','포장팀','RECEIVED','','2026-04-24 00:53:00','2026-06-26 01:46:05'),(2,'2026-04-29','관리자','포장팀','RECEIVED','','2026-04-24 00:53:12','2026-06-25 14:59:59'),(3,'2026-04-27','관리자','포장팀','RECEIVED','','2026-04-24 01:25:33','2026-06-26 01:47:29'),(4,'2026-04-30','관리자','포장팀','RECEIVED','','2026-04-26 01:55:09','2026-05-22 12:40:52'),(5,'2026-05-11','관리자','포장팀','RECEIVED','','2026-05-02 11:39:01','2026-05-22 04:20:46'),(6,'2026-06-02','관리자','포장팀','RECEIVED','','2026-05-10 00:53:05','2026-05-19 02:55:10'),(7,'2026-05-12','관리자','포장팀','RECEIVED','','2026-05-10 03:30:19','2026-05-22 06:54:36'),(8,'2026-06-26','관리자','포장팀','CANCELLED','긴급 입고','2026-06-26 19:51:04',NULL),(9,'2026-06-27','관리자','포장팀','CANCELLED','긴급 입고','2026-06-27 17:53:39',NULL),(10,'2026-06-29','관리자','포장팀','RECEIVED','긴급 입고','2026-06-29 17:50:41','2026-06-30 00:07:53'),(11,'2026-06-30','관리자','포장팀','RECEIVED','긴급','2026-06-30 12:00:49','2026-06-30 12:11:48'),(12,'2026-07-01','관리자','포장팀','RECEIVED','포장입고','2026-07-01 13:31:59','2026-07-01 14:53:08'),(13,'2026-07-02','관리자','포장팀','CANCELLED','생산','2026-07-02 01:49:50',NULL),(14,'2026-07-02','관리자','포장팀','RECEIVED','생산','2026-07-02 02:00:58','2026-07-02 02:01:53');
/*!40000 ALTER TABLE `packing_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packing_order_detail`
--

DROP TABLE IF EXISTS `packing_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packing_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `packing_order_id` bigint NOT NULL,
  `product_type` varchar(50) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `hardness` varchar(20) DEFAULT NULL,
  `base_qty` int DEFAULT '0',
  `box_count` int DEFAULT '0',
  `each_qty` int DEFAULT '0',
  `total_qty` int DEFAULT '0',
  `inbound_status` varchar(30) DEFAULT 'WAITING',
  `inbound_at` datetime DEFAULT NULL,
  `packing_scan_status` varchar(20) DEFAULT 'WAITING',
  `packing_scan_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `packing_order_id` (`packing_order_id`),
  CONSTRAINT `packing_order_detail_ibfk_1` FOREIGN KEY (`packing_order_id`) REFERENCES `packing_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packing_order_detail`
--

LOCK TABLES `packing_order_detail` WRITE;
/*!40000 ALTER TABLE `packing_order_detail` DISABLE KEYS */;
INSERT INTO `packing_order_detail` VALUES (13,3,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'WAITING',NULL,'DONE','2026-06-26 01:46:58'),(14,3,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'DONE','2026-05-20 01:27:40','DONE','2026-06-26 01:47:05'),(15,3,'ARMOUR','40-622','RED','R',51,1,0,51,'DONE','2026-05-20 01:28:02','DONE','2026-06-26 01:47:10'),(16,3,'ARMOUR','63-622','RED','R',24,0,2,2,'WAITING',NULL,'DONE','2026-06-26 01:47:26'),(17,3,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'WAITING',NULL,'DONE','2026-06-26 01:47:18'),(18,3,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'WAITING',NULL,'WAITING',NULL),(25,5,'TIRE','51-559','MIDNIGHT','R',15,3,3,48,'DONE','2026-05-14 23:11:37','DONE','2026-05-22 12:02:40'),(26,5,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'DONE','2026-05-14 23:11:28','DONE','2026-05-22 12:02:28'),(27,5,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'WAITING','2026-05-14 23:11:17','WAITING',NULL),(28,5,'ARMOUR','40-622','RED','R',51,1,0,51,'WAITING','2026-05-14 23:11:06','WAITING',NULL),(29,5,'ARMOUR','63-622','RED','R',24,0,2,2,'DONE','2026-05-12 07:58:39','WAITING',NULL),(30,5,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'DONE','2026-05-12 07:47:04','WAITING',NULL),(31,5,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'DONE','2026-05-12 07:40:14','WAITING',NULL),(32,4,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'DONE','2026-06-26 17:10:09','DONE','2026-05-22 12:40:49'),(33,4,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'DONE','2026-06-26 17:10:09','DONE','2026-05-22 12:40:41'),(34,4,'ARMOUR','40-622','RED','R',51,1,0,51,'WAITING',NULL,'WAITING',NULL),(35,4,'ARMOUR','63-622','RED','R',24,0,2,2,'WAITING',NULL,'WAITING',NULL),(36,4,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'WAITING',NULL,'WAITING',NULL),(37,4,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'WAITING',NULL,'WAITING',NULL),(50,2,'TIRE','44-559','MIDNIGHT','R',20,2,1500,1540,'DONE','2026-05-15 01:49:53','DONE','2026-06-25 14:59:53'),(51,2,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'DONE','2026-05-15 01:49:43','WAITING',NULL),(52,2,'ARMOUR','40-622','RED','R',51,1,0,51,'DONE','2026-05-15 01:49:33','DONE','2026-06-25 14:59:46'),(53,2,'ARMOUR','63-622','RED','R',24,0,2,2,'DONE','2026-05-15 01:49:18','DONE','2026-06-25 14:59:13'),(54,2,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'DONE','2026-05-15 01:49:09','DONE','2026-06-25 14:59:38'),(55,2,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'DONE','2026-05-15 01:50:11','DONE','2026-06-25 14:59:23'),(69,6,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'WAITING','2026-05-19 17:40:30','WAITING',NULL),(70,6,'TIRE','44-507','MIDNIGHT','R',28,3,0,84,'WAITING',NULL,'WAITING',NULL),(71,6,'ARMOUR','40-622','RED','R',51,1,0,51,'WAITING',NULL,'WAITING',NULL),(72,6,'ARMOUR','63-622','RED','R',24,0,2,2,'WAITING',NULL,'WAITING',NULL),(73,6,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'WAITING',NULL,'WAITING',NULL),(74,6,'TUBELESS','29 (Fusion)','BLACK','R',24,0,2,2,'WAITING',NULL,'WAITING',NULL),(78,7,'TIRE','44-559','MIDNIGHT','R',20,2,4,44,'WAITING',NULL,'DONE','2026-05-22 11:55:53'),(79,1,'TIRE','44-559','MIDNIGHT','R',20,2,1,41,'WAITING',NULL,'DONE','2026-06-26 01:44:34'),(80,1,'TIRE','44-507','MIDNIGHT','R',28,0,1,1,'WAITING',NULL,'DONE','2026-06-26 01:44:50'),(81,1,'ARMOUR','40-622','RED','R',51,1,0,51,'WAITING',NULL,'DONE','2026-06-26 01:44:59'),(82,1,'ARMOUR','63-622','RED','R',24,0,2,2,'WAITING',NULL,'DONE','2026-06-26 01:45:55'),(83,1,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'WAITING',NULL,'DONE','2026-06-26 01:45:37'),(84,1,'TUBELESS','29 (Fusion)','BLACK','R',24,0,0,0,'WAITING',NULL,'DONE','2026-06-26 01:45:19'),(87,8,'ARMOUR','63-584','RED','R',24,1,2,26,'WAITING',NULL,'WAITING',NULL),(88,9,'TIRE','44-559','MIDNIGHT','R',20,1,0,20,'WAITING',NULL,'WAITING',NULL),(90,10,'ARMOUR','63-622','RED','R',24,0,3,3,'WAITING',NULL,'WAITING',NULL),(91,11,'TIRE','23-622','MIDNIGHT','R',30,0,3,3,'WAITING',NULL,'DONE','2026-06-30 12:26:32'),(98,12,'TIRE','44-559','CARROT','R',20,2,3,43,'WAITING',NULL,'DONE','2026-07-01 14:53:08'),(99,12,'TUBELESS','27.5 (Fusion)','BLACK','R',24,1,0,24,'WAITING',NULL,'DONE','2026-07-01 14:52:20'),(100,13,'ARMOUR','47-559','RED','R',40,0,2,2,'WAITING',NULL,'WAITING',NULL),(101,14,'ARMOUR','37-540','RED','R',57,1,0,57,'WAITING',NULL,'DONE','2026-07-02 02:01:53');
/*!40000 ALTER TABLE `packing_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packing_outbound_scan`
--

DROP TABLE IF EXISTS `packing_outbound_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packing_outbound_scan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `packing_order_id` bigint NOT NULL,
  `detail_id` bigint NOT NULL,
  `scan_type` varchar(20) NOT NULL,
  `scan_seq` int NOT NULL,
  `qty` int NOT NULL,
  `status` varchar(20) DEFAULT 'WAITING',
  `scanned_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packing_outbound_scan`
--

LOCK TABLES `packing_outbound_scan` WRITE;
/*!40000 ALTER TABLE `packing_outbound_scan` DISABLE KEYS */;
INSERT INTO `packing_outbound_scan` VALUES (40,10,90,'EACH',1,3,'DONE','2026-06-30 00:07:48','2026-06-29 23:58:00'),(41,10,19,'UNPLANNED_BOX',1,20,'DONE','2026-06-30 00:07:44','2026-06-29 23:58:00'),(42,10,19,'UNPLANNED_BOX',2,20,'DONE','2026-06-30 00:07:53','2026-06-29 23:58:00'),(43,11,91,'EACH',1,3,'DONE','2026-06-30 12:02:19','2026-06-30 12:01:58'),(44,11,22,'UNPLANNED_BOX',1,24,'DONE','2026-06-30 12:11:48','2026-06-30 12:01:58'),(45,12,98,'BOX',1,20,'DONE','2026-07-01 14:53:08','2026-07-01 14:50:37'),(46,12,98,'BOX',2,20,'DONE','2026-07-01 14:50:54','2026-07-01 14:50:37'),(47,12,98,'EACH',1,3,'DONE','2026-07-01 14:50:48','2026-07-01 14:50:37'),(48,12,99,'BOX',1,24,'DONE','2026-07-01 14:52:20','2026-07-01 14:50:37'),(49,12,23,'UNPLANNED_EACH',1,1,'DONE','2026-07-01 14:51:14','2026-07-01 14:50:37'),(50,14,101,'BOX',1,57,'DONE','2026-07-02 02:01:53','2026-07-02 02:01:35');
/*!40000 ALTER TABLE `packing_outbound_scan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ORDERED',
  `memo` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_detail`
--

DROP TABLE IF EXISTS `purchase_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `purchase_order_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `current_stock` int NOT NULL,
  `min_stock` int NOT NULL,
  `order_unit` int NOT NULL,
  `order_qty` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  CONSTRAINT `purchase_order_detail_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_detail`
--

LOCK TABLES `purchase_order_detail` WRITE;
/*!40000 ALTER TABLE `purchase_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_adjust_history`
--

DROP TABLE IF EXISTS `stock_adjust_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_adjust_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint NOT NULL,
  `before_stock` int NOT NULL,
  `after_stock` int NOT NULL,
  `adjust_qty` int NOT NULL,
  `reason` varchar(100) NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `stock_adjust_history_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_adjust_history`
--

LOCK TABLES `stock_adjust_history` WRITE;
/*!40000 ALTER TABLE `stock_adjust_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjust_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_history`
--

DROP TABLE IF EXISTS `stock_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `history_type` varchar(30) DEFAULT NULL,
  `product_type` varchar(50) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `hardness` varchar(30) DEFAULT NULL,
  `before_qty` int DEFAULT '0',
  `change_qty` int DEFAULT '0',
  `after_qty` int DEFAULT '0',
  `created_by` varchar(100) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_history`
--

LOCK TABLES `stock_history` WRITE;
/*!40000 ALTER TABLE `stock_history` DISABLE KEYS */;
INSERT INTO `stock_history` VALUES (7,'ADJUST','TIRE','44-559','MIDNIGHT','R',0,1663,1663,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(8,'ADJUST','TIRE','51-559','MIDNIGHT','R',0,93,93,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(9,'ADJUST','ARMOUR','63-622','RED','R',0,6,6,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(10,'ADJUST','TUBELESS','27.5 (Fusion)','BLACK','R',0,72,72,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(11,'ADJUST','TUBELESS','29 (Fusion)','BLACK','R',0,6,6,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(12,'ADJUST','ARMOUR','63-559','RED','R',0,20,20,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(13,'ADJUST','ARMOUR','47-622','RED','R',0,20,20,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(14,'ADJUST','TIRE','44-507','MIDNIGHT','R',0,2,2,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(15,'ADJUST','ARMOUR','40-622','RED','R',0,102,102,'관리자','기존 재고 초기화','2026-05-18 20:42:50'),(22,'ADJUST','TIRE','44-559','MIDNIGHT','R',1663,-13,1650,'관리자','재고 불량','2026-05-19 01:47:30'),(23,'OUT','ARMOUR','40-622','RED','R',102,-20,82,'물류팀','수출출고','2026-05-20 01:15:53'),(24,'OUT','TUBELESS','29 (Fusion)','BLACK','R',6,-3,3,'물류팀','수출출고','2026-05-20 01:15:53'),(25,'IN','TIRE','44-559','MIDNIGHT','R',1650,41,1691,'물류팀','정상입고','2026-05-20 01:28:07'),(26,'IN','TIRE','44-507','MIDNIGHT','R',2,1,3,'물류팀','정상입고','2026-05-20 01:28:07'),(27,'IN','ARMOUR','40-622','RED','R',82,51,133,'물류팀','정상입고','2026-05-20 01:28:07'),(28,'OUT','TIRE','44-559','MIDNIGHT','R',1691,-40,1651,'물류팀','수출출고','2026-05-20 01:30:37'),(29,'OUT','TIRE','44-559','MIDNIGHT','R',1651,-40,1611,'물류팀','수출출고','2026-05-22 11:26:33'),(30,'OUT','TIRE','51-559','MIDNIGHT','R',93,-6,87,'물류팀','수출출고','2026-05-22 11:26:34'),(31,'IN','TIRE','44-559','MIDNIGHT','R',1611,1540,3151,'물류팀','정상입고','2026-06-25 15:54:14'),(32,'IN','TIRE','44-507','MIDNIGHT','R',3,1,4,'물류팀','정상입고','2026-06-25 15:54:14'),(33,'IN','ARMOUR','40-622','RED','R',133,51,184,'물류팀','정상입고','2026-06-25 15:54:14'),(34,'IN','ARMOUR','63-622','RED','R',6,2,8,'물류팀','정상입고','2026-06-25 15:54:14'),(35,'IN','TUBELESS','27.5 (Fusion)','BLACK','R',72,24,96,'물류팀','정상입고','2026-06-25 15:54:14'),(36,'IN','TUBELESS','29 (Fusion)','BLACK','R',3,2,5,'물류팀','정상입고','2026-06-25 15:54:14'),(37,'IN','TUBELESS','29 (Fusion)','BLACK','R',5,2,7,'물류팀','무발주 입고','2026-06-25 15:54:14'),(38,'IN','TUBELESS','29 (Fusion)','BLACK','R',7,2,9,'물류팀','무발주 입고','2026-06-25 15:54:14'),(39,'IN','TIRE','51-559','MIDNIGHT','R',87,45,132,'물류팀','무발주 입고','2026-06-25 15:54:14'),(40,'IN','TIRE','51-559','MIDNIGHT','R',132,3,135,'물류팀','무발주 입고','2026-06-25 15:55:33'),(41,'IN','ARMOUR','47-622','RED','R',20,20,40,'물류팀','무발주 입고','2026-06-26 16:40:22'),(42,'IN','ARMOUR','63-559','RED','R',20,20,40,'물류팀','무발주 입고','2026-06-26 16:40:22'),(43,'IN','TIRE','44-559','MIDNIGHT','R',3151,41,3192,'물류팀','정상입고','2026-06-26 17:10:09'),(44,'IN','TIRE','44-507','MIDNIGHT','R',4,1,5,'물류팀','정상입고','2026-06-26 17:10:09'),(45,'IN','TIRE','44-559','MIDNIGHT','R',3192,41,3233,'물류팀','정상입고','2026-06-26 17:35:44'),(46,'IN','TIRE','44-507','MIDNIGHT','R',5,1,6,'물류팀','정상입고','2026-06-26 17:35:44'),(47,'IN','ARMOUR','40-622','RED','R',184,51,235,'물류팀','정상입고','2026-06-26 17:35:44'),(48,'IN','ARMOUR','63-622','RED','R',8,2,10,'물류팀','정상입고','2026-06-26 17:35:44'),(49,'IN','ARMOUR','63-622','RED','R',10,2,12,'물류팀','정상입고','2026-06-26 18:40:25'),(50,'OUT','TIRE','44-559','MIDNIGHT','R',3233,-42,3191,'물류팀','수출출고','2026-06-27 13:28:00'),(51,'OUT','TUBELESS','29 (Fusion)','BLACK','R',72,-2,70,'물류팀','수출출고','2026-06-29 15:18:25'),(52,'OUT','TUBELESS','27.5 (Pro)','BLACK','R',72,-26,46,'물류팀','수출출고','2026-06-29 15:18:25'),(53,'ADJUST','TIRE','40-622','MIDNIGHT','R',0,180,180,'관리자','초기재고 보정','2026-06-29 15:27:19'),(54,'ADJUST','TIRE','32-622','MIDNIGHT','R',0,240,240,'관리자','초기재고 보정','2026-06-29 15:27:19'),(55,'ADJUST','TIRE','51-559','MIDNIGHT','R',135,-60,75,'관리자','초기재고 보정','2026-06-29 15:27:19'),(56,'ADJUST','TIRE','44-559','MIDNIGHT','R',3191,-3031,160,'관리자','초기재고 보정','2026-06-29 15:27:19'),(57,'ADJUST','TIRE','35-590','MIDNIGHT','R',0,96,96,'관리자','초기재고 보정','2026-06-29 15:27:19'),(58,'ADJUST','TIRE','35-559','MIDNIGHT','R',0,120,120,'관리자','초기재고 보정','2026-06-29 15:27:19'),(59,'ADJUST','TIRE','44-507','MIDNIGHT','R',6,78,84,'관리자','초기재고 보정','2026-06-29 15:27:19'),(60,'ADJUST','TIRE','40-540','MIDNIGHT','R',0,112,112,'관리자','초기재고 보정','2026-06-29 15:27:19'),(61,'ADJUST','TIRE','40-501','MIDNIGHT','R',0,56,56,'관리자','초기재고 보정','2026-06-29 15:27:19'),(62,'ADJUST','TIRE','51-406','MIDNIGHT','R',0,45,45,'관리자','초기재고 보정','2026-06-29 15:27:19'),(63,'ADJUST','TIRE','40-406','MIDNIGHT','R',0,196,196,'관리자','초기재고 보정','2026-06-29 15:27:19'),(64,'ADJUST','TIRE','40-355','MIDNIGHT','R',0,28,28,'관리자','초기재고 보정','2026-06-29 15:27:19'),(65,'ADJUST','TIRE','40-349','MIDNIGHT','R',0,84,84,'관리자','초기재고 보정','2026-06-29 15:27:19'),(66,'ADJUST','TIRE','40-305','MIDNIGHT','R',0,140,140,'관리자','초기재고 보정','2026-06-29 15:27:19'),(67,'ADJUST','TIRE','28-622','MIDNIGHT','R',0,300,300,'관리자','초기재고 보정','2026-06-29 15:27:19'),(68,'ADJUST','TIRE','25-622','MIDNIGHT','R',0,210,210,'관리자','초기재고 보정','2026-06-29 15:27:19'),(69,'ADJUST','TIRE','23-622','MIDNIGHT','R',0,90,90,'관리자','초기재고 보정','2026-06-29 15:27:19'),(70,'ADJUST','TIRE','28-451','MIDNIGHT','R',0,60,60,'관리자','초기재고 보정','2026-06-29 15:27:19'),(71,'ADJUST','TIRE','32-406','MIDNIGHT','R',0,150,150,'관리자','초기재고 보정','2026-06-29 15:27:19'),(72,'ADJUST','TIRE','32-349','MIDNIGHT','R',0,30,30,'관리자','초기재고 보정','2026-06-29 15:27:19'),(73,'ADJUST','TIRE','32-305','MIDNIGHT','R',0,120,120,'관리자','초기재고 보정','2026-06-29 15:27:19'),(74,'ADJUST','ARMOUR','47-559','RED','R',0,120,120,'관리자','초기재고 보정','2026-06-29 15:27:19'),(75,'ADJUST','ARMOUR','63-559','RED','R',40,32,72,'관리자','초기재고 보정','2026-06-29 15:27:19'),(76,'ADJUST','ARMOUR','63-584','RED','R',0,96,96,'관리자','초기재고 보정','2026-06-29 15:27:19'),(77,'ADJUST','ARMOUR','40-622','RED','R',235,-82,153,'관리자','초기재고 보정','2026-06-29 15:27:19'),(78,'ADJUST','ARMOUR','47-622','RED','R',40,74,114,'관리자','초기재고 보정','2026-06-29 15:27:19'),(79,'ADJUST','ARMOUR','63-622','RED','R',12,36,48,'관리자','초기재고 보정','2026-06-29 15:27:19'),(80,'ADJUST','ARMOUR','63-406','RED','R',0,90,90,'관리자','초기재고 보정','2026-06-29 15:27:19'),(81,'ADJUST','ARMOUR','63-507','RED','R',0,52,52,'관리자','초기재고 보정','2026-06-29 15:27:19'),(82,'ADJUST','ARMOUR','34-622','RED','R',0,171,171,'관리자','초기재고 보정','2026-06-29 15:27:19'),(83,'ADJUST','ARMOUR','54-559','RED','R',0,84,84,'관리자','초기재고 보정','2026-06-29 15:27:19'),(84,'ADJUST','ARMOUR','50-406','RED','R',0,180,180,'관리자','초기재고 보정','2026-06-29 15:27:19'),(85,'ADJUST','ARMOUR','75-584','RED','R',0,40,40,'관리자','초기재고 보정','2026-06-29 15:27:19'),(86,'ADJUST','ARMOUR','75-622','RED','R',0,60,60,'관리자','초기재고 보정','2026-06-29 15:27:19'),(87,'ADJUST','ARMOUR','40-540','RED','R',0,112,112,'관리자','초기재고 보정','2026-06-29 15:27:19'),(88,'ADJUST','ARMOUR','75-559','RED','R',0,20,20,'관리자','초기재고 보정','2026-06-29 15:27:19'),(89,'ADJUST','ARMOUR','34-590','RED','R',0,57,57,'관리자','초기재고 보정','2026-06-29 15:27:19'),(90,'ADJUST','ARMOUR','37-540','RED','R',0,114,114,'관리자','초기재고 보정','2026-06-29 15:27:19'),(91,'ADJUST','ARMOUR','120-559','RED','R',0,32,32,'관리자','초기재고 보정','2026-06-29 15:27:19'),(92,'ADJUST','ARMOUR','100-406','RED','R',0,80,80,'관리자','초기재고 보정','2026-06-29 15:27:19'),(93,'ADJUST','ARMOUR','120-406','RED','R',0,40,40,'관리자','초기재고 보정','2026-06-29 15:27:19'),(94,'ADJUST','ARMOUR','100-507','RED','R',0,60,60,'관리자','초기재고 보정','2026-06-29 15:27:19'),(95,'ADJUST','ARMOUR','80-90-17','RED','R',0,48,48,'관리자','초기재고 보정','2026-06-29 15:27:19'),(96,'ADJUST','ARMOUR','70-90-17','RED','R',0,72,72,'관리자','초기재고 보정','2026-06-29 15:27:19'),(97,'ADJUST','TUBELESS','29 (Pro)','BLACK','R',0,96,96,'관리자','초기재고 보정','2026-06-29 15:27:19'),(98,'ADJUST','TUBELESS','27.5 (Fusion)','BLACK','R',96,-48,48,'관리자','초기재고 보정','2026-06-29 15:27:19'),(99,'ADJUST','TUBELESS','26mm Lite','BLACK','R',0,100,100,'관리자','초기재고 보정','2026-06-29 15:27:19'),(100,'ADJUST','TUBELESS','32mm Lite','BLACK','R',0,150,150,'관리자','초기재고 보정','2026-06-29 15:27:19'),(101,'ADJUST','TUBELESS','27.5 Lite (32mm)','BLACK','R',0,50,50,'관리자','초기재고 보정','2026-06-29 15:27:19'),(116,'ADJUST','TIRE','40-622','MIDNIGHT','R',180,-1,179,'관리자','훼손','2026-06-29 15:33:22'),(117,'IN','TIRE','34-622','MELON','R',0,3,3,'관리자','관리자 상품 신규등록','2026-06-29 16:32:28'),(118,'OUT','ARMOUR','120-559','RED','R',32,-1,31,'물류팀','수출출고','2026-06-29 18:36:43'),(119,'IN','ARMOUR','63-622','RED','R',48,3,51,'물류팀','정상입고','2026-06-30 04:08:48'),(120,'IN','TIRE','23-622','MIDNIGHT','R',90,3,93,'물류팀','정상입고','2026-06-30 12:29:53'),(121,'IN','TUBELESS','29 (Pro)','BLACK','R',96,24,120,'물류팀','무발주 입고','2026-06-30 12:29:53'),(122,'ADJUST','TIRE','34-622','MIDNIGHT','R',0,0,0,'관리자','관리자 상품정보 등록','2026-06-30 13:51:37'),(123,'ADJUST','TIRE','63-622','MIDNIGHT','R',0,20,20,'관리자','관리자 상품정보 등록','2026-06-30 13:51:37'),(125,'ADJUST','TIRE','34-622','MIDNIGHT','R',0,3,3,'관리자','물류팀 바로 전달','2026-06-30 14:11:24'),(126,'OUT','TUBELESS','26mm Lite','BLACK','R',100,-50,50,'물류팀','수출출고','2026-06-30 14:23:43'),(127,'OUT','ARMOUR','75-622','RED','R',60,-20,40,'물류팀','수출출고','2026-06-30 14:23:43'),(128,'IN','TIRE','44-559','CARROT','R',0,43,43,'물류팀','정상입고','2026-07-01 17:01:30'),(129,'IN','TUBELESS','27.5 (Fusion)','BLACK','R',48,24,72,'물류팀','정상입고','2026-07-01 17:01:30'),(130,'IN','TIRE','25-622','VOLCANO','R',0,1,1,'물류팀','무발주 입고','2026-07-01 17:01:30'),(131,'IN','TUBELESS','27.5 Lite (32mm)','BLACK','R',50,2,52,'물류팀','무발주 입고','2026-07-01 17:01:30'),(132,'OUT','TIRE','44-559','CARROT','R',43,-42,1,'물류팀','수출출고','2026-07-01 17:24:14'),(133,'OUT','TIRE','44-507','MIDNIGHT','R',84,-3,81,'물류팀','수출출고','2026-07-01 17:24:14'),(134,'OUT','TIRE','44-559','CARROT','R',1,-42,0,'물류팀','수출출고','2026-07-01 23:49:45'),(135,'OUT','TIRE','44-507','MIDNIGHT','R',81,-3,78,'물류팀','수출출고','2026-07-01 23:49:45'),(136,'OUT','TIRE','44-559','MIDNIGHT','R',160,-2,158,'물류팀','무발주 출고','2026-07-01 23:49:45'),(137,'IN','ARMOUR','37-540','RED','R',114,57,171,'물류팀','정상입고','2026-07-02 02:03:16');
/*!40000 ALTER TABLE `stock_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_code` varchar(30) NOT NULL,
  `supplier_no` varchar(30) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `use_yn` char(1) DEFAULT 'Y',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier_code` (`supplier_code`),
  UNIQUE KEY `supplier_no` (`supplier_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unplanned_export`
--

DROP TABLE IF EXISTS `unplanned_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unplanned_export` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `export_order_id` bigint NOT NULL,
  `product_type` varchar(50) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `hardness` varchar(50) NOT NULL,
  `base_qty` int DEFAULT '0',
  `box_count` int DEFAULT '0',
  `each_qty` int DEFAULT '0',
  `total_qty` int DEFAULT '0',
  `reason` varchar(500) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'PENDING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `checked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unplanned_export`
--

LOCK TABLES `unplanned_export` WRITE;
/*!40000 ALTER TABLE `unplanned_export` DISABLE KEYS */;
INSERT INTO `unplanned_export` VALUES (1,8,'TIRE','44-559','MIDNIGHT','R',20,0,4,4,'긴급출하요청','APPROVED','2026-06-27 07:22:23','2026-06-27 08:17:40'),(2,9,'TUBELESS','26mm Lite','BLACK','R',10,0,2,2,'긴급출하요청','APPROVED','2026-06-29 12:22:55','2026-06-29 13:24:07'),(3,10,'TIRE','34-622','MIDNIGHT','R',24,0,2,2,'긴급요청','REJECTED','2026-06-29 18:17:19','2026-06-29 18:19:41'),(5,11,'TUBELESS','27.5 Lite (32mm)','BLACK','R',50,1,0,50,'긴급 출하 요청 - 일본','APPROVED','2026-06-30 14:21:26','2026-06-30 14:21:45'),(6,12,'TIRE','44-559','MIDNIGHT','R',20,0,2,2,'추가 뉴질랜드 출고','APPROVED','2026-07-01 17:14:25','2026-07-01 17:14:39');
/*!40000 ALTER TABLE `unplanned_export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unplanned_purchase`
--

DROP TABLE IF EXISTS `unplanned_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unplanned_purchase` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `packing_order_id` bigint NOT NULL,
  `product_type` varchar(50) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `hardness` varchar(50) DEFAULT NULL,
  `qty` int NOT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PENDING',
  `inbound_status` varchar(20) NOT NULL DEFAULT 'WAITING',
  `inbound_at` datetime DEFAULT NULL,
  `request_user` varchar(50) DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `approved_at` datetime DEFAULT NULL,
  `base_qty` int DEFAULT '0',
  `box_count` int DEFAULT '0',
  `each_qty` int DEFAULT '0',
  `total_qty` int DEFAULT '0',
  `stock_applied` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unplanned_purchase`
--

LOCK TABLES `unplanned_purchase` WRITE;
/*!40000 ALTER TABLE `unplanned_purchase` DISABLE KEYS */;
INSERT INTO `unplanned_purchase` VALUES (1,5,'ARMOUR','37-540','RED','R',9,'','REJECTED','WAITING',NULL,'물류팀','관리자','2026-05-13 10:58:34','2026-05-14 21:10:32',0,0,0,0,'N'),(3,5,'ARMOUR','47-622','RED','R',20,'','APPROVED','DONE','2026-06-26 13:55:26','물류팀','관리자','2026-05-13 11:07:32','2026-05-14 21:10:32',10,2,0,20,'N'),(4,5,'ARMOUR','34-590','RED','R',20,'','REJECTED','WAITING',NULL,'물류팀','관리자','2026-05-13 12:02:13','2026-05-14 21:10:31',10,2,0,20,'N'),(5,5,'ARMOUR','63-559','RED','R',20,'','APPROVED','DONE','2026-06-26 13:57:15','물류팀','관리자','2026-05-14 19:12:02','2026-05-14 21:10:29',10,2,0,20,'N'),(6,2,'TIRE','51-559','MIDNIGHT','R',45,'','APPROVED','WAITING',NULL,'물류팀','관리자','2026-05-15 01:45:14','2026-05-15 01:51:01',15,3,0,45,'N'),(11,6,'TIRE','51-559','MIDNIGHT','R',3,'','APPROVED','WAITING',NULL,'물류팀','관리자','2026-05-22 04:07:10','2026-06-25 15:33:24',15,0,3,3,'N'),(12,2,'TUBELESS','29 (Fusion)','BLACK','R',2,'','APPROVED','WAITING',NULL,'포장팀','관리자','2026-06-25 14:37:17','2026-06-25 15:33:23',10,0,2,2,'N'),(13,2,'TUBELESS','29 (Fusion)','BLACK','R',2,'','APPROVED','WAITING',NULL,'물류팀','관리자','2026-06-25 15:50:01','2026-06-25 15:50:16',10,0,2,2,'N'),(15,1,'TUBELESS','27.5 (Fusion)','BLACK','R',5,'','APPROVED','WAITING',NULL,'포장팀','관리자','2026-06-26 01:43:01','2026-06-26 01:43:24',10,0,5,5,'N'),(18,3,'ARMOUR','37-540','RED','R',3,'긴급요청','APPROVED','WAITING',NULL,'물류팀','관리자','2026-06-26 17:34:40','2026-06-26 17:35:11',10,0,3,3,'N'),(19,10,'ARMOUR','75-584','RED','R',40,'긴급출하요청','APPROVED','DONE','2026-06-30 04:08:41','포장팀','관리자','2026-06-29 20:42:52','2026-06-29 20:46:57',20,2,0,40,'Y'),(22,11,'TUBELESS','29 (Pro)','BLACK','R',24,'','APPROVED','DONE','2026-06-30 12:29:32','포장팀','관리자','2026-06-30 12:01:09','2026-06-30 12:01:26',24,1,0,24,'Y'),(23,12,'TIRE','25-622','VOLCANO','R',1,'생산추가','APPROVED','DONE','2026-07-01 17:00:46','포장팀','관리자','2026-07-01 14:49:45','2026-07-01 14:50:08',30,0,1,1,'Y'),(26,12,'TIRE','28-451','MELON','R',1,'긴급추가','REJECTED','WAITING',NULL,'포장팀','관리자','2026-07-01 15:59:27','2026-07-01 16:33:57',30,0,1,1,'N'),(27,12,'TUBELESS','27.5 Lite (32mm)','BLACK','R',2,'생산추가입고','APPROVED','DONE','2026-07-01 17:01:00','포장팀','관리자','2026-07-01 16:34:46','2026-07-01 16:35:01',10,0,2,2,'Y');
/*!40000 ALTER TABLE `unplanned_purchase` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-04  4:00:55
