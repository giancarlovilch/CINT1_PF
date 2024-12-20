-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: sb_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `uid` varchar(20) NOT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `fname` varchar(15) DEFAULT NULL,
  `lname` varchar(15) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `phno` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('giancarlovilch','e3b9c6a1d7611370f98211feb2ef9ddc31c3a38f3dd663cb629dfeb5d98d4d99','Vilcamiche','Gian','giancarlovilch@gmail.com','SJL',999999999),('giancarlovilchh','e3b9c6a1d7611370f98211feb2ef9ddc31c3a38f3dd663cb629dfeb5d98d4d99','Gian Carlo','Chavez','giancarlovilch@gmail.com','Canto Rey',935812267),('├▒o├▒oid','e3b9c6a1d7611370f98211feb2ef9ddc31c3a38f3dd663cb629dfeb5d98d4d99','├▒o├▒o','├▒andu','├▒o├▒o@gmail.com','sjl',123123123),('ravlich','e3b9c6a1d7611370f98211feb2ef9ddc31c3a38f3dd663cb629dfeb5d98d4d99','Roy','Vilcam','roy@gmail.com','Lioma',966610755);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `pid` varchar(15) NOT NULL,
  `pname` varchar(20) DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  `sid` varchar(15) NOT NULL,
  PRIMARY KEY (`pid`,`sid`),
  KEY `fk02` (`pname`),
  KEY `fk03` (`sid`),
  CONSTRAINT `fk01` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE,
  CONSTRAINT `fk02` FOREIGN KEY (`pname`) REFERENCES `product` (`pname`) ON DELETE CASCADE,
  CONSTRAINT `fk03` FOREIGN KEY (`sid`) REFERENCES `seller` (`sid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('7750936009112','VALPRAX',1,'giancarlovilch'),('7750936065866','ESOMEPRAZOL',5,'giancarlovilch'),('7750936066030','NOGESTROL',3,'giancarlovilch'),('8904112520970','BONACOXIB',4,'giancarlovilch'),('BAGMAR48016','NASTIZOL',2,'giancarlovilch'),('BAGO01','BISMUTOL',108,'giancarlovilch'),('BONMAR55646','DOBESIUM',4,'giancarlovilch'),('IBU2023','IBUPROFENO',4,'giancarlovilch'),('PAR2023','PARACETAMOL',7,'giancarlovilch');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(15) DEFAULT NULL,
  `sid` varchar(15) DEFAULT NULL,
  `uid` varchar(15) DEFAULT NULL,
  `orderdatetime` datetime DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  `price` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `fk04` (`pid`),
  KEY `fk05` (`sid`),
  KEY `fk06` (`uid`),
  CONSTRAINT `fk04` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE,
  CONSTRAINT `fk05` FOREIGN KEY (`sid`) REFERENCES `seller` (`sid`) ON DELETE CASCADE,
  CONSTRAINT `fk06` FOREIGN KEY (`uid`) REFERENCES `customer` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1000,'IBU2023','giancarlovilch','giancarlovilch','2024-09-25 16:36:01',1,5),(1001,'PAR2023','giancarlovilch','giancarlovilch','2024-09-25 16:36:11',1,2),(1002,'PAR2023','giancarlovilch','giancarlovilch','2024-11-03 04:02:39',3,6),(1003,'7750936009112','giancarlovilch','├▒o├▒oid','2024-11-03 09:44:17',2,4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER updatetime BEFORE INSERT ON orders FOR EACH ROW

BEGIN

    SET NEW.orderdatetime = NOW();

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER inventorytrigger AFTER INSERT ON orders

FOR EACH ROW

begin



DECLARE qnty int;

DECLARE productid varchar(20);



SELECT   pid INTO productid

FROM      orders

ORDER BY  oid DESC

LIMIT     1;



SELECT   quantity INTO qnty 

FROM      orders

ORDER BY  oid DESC

LIMIT     1;



UPDATE inventory

SET quantity=quantity-qnty

WHERE pid=productid;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `pid` varchar(15) NOT NULL,
  `pname` varchar(20) DEFAULT NULL,
  `manufacturer` varchar(20) DEFAULT NULL,
  `mfg` date DEFAULT NULL,
  `exp` date DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pname` (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('7750936009112','VALPRAX','ACFARMA','2024-01-24','2025-01-24',2),('7750936065866','ESOMEPRAZOL','ACFARMA','2024-01-24','2025-01-24',5),('7750936066030','NOGESTROL','ACFARMA','2024-01-24','2025-01-24',5),('8904112520970','BONACOXIB','BONAPHARM','2024-01-24','2025-01-24',5),('BAGMAR48016','NASTIZOL','BAGO','2024-01-24','2025-01-24',3),('BAGO01','BISMUTOL','BAGO','2024-01-24','2025-01-24',3),('BONMAR55646','DOBESIUM','BONAPHARM','2024-01-24','2025-01-24',3),('IBU2023','IBUPROFENO','GENFAR','2024-01-24','2025-01-24',5),('PAR2023','PARACETAMOL','TERBOL','2023-02-10','2025-02-10',2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `sid` varchar(15) NOT NULL,
  `sname` varchar(20) DEFAULT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `phno` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES ('giancarlovilch','Gian Carlo  ','2f8b349530c0fd98ca45333d0f685a3355d0d7f9379daf8f45adcdd4304a5d6f','SJL',935812267),('tonyy@gmail.com','tonyy','2f8b349530c0fd98ca45333d0f685a3355d0d7f9379daf8f45adcdd4304a5d6f','Panama',555555555);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06 22:09:10
