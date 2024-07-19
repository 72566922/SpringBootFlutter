CREATE DATABASE  IF NOT EXISTS `db_jorgecolors` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_jorgecolors`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: db_jorgecolors
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `ID_CATEGORIA` int NOT NULL AUTO_INCREMENT,
  `CATEGORIA` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `HABILITAR` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'LATEX','PAREDES Y TECHOS','HABILITADO'),(2,'ACRILICA','INTERIORES Y EXTERIORES','HABILITADO'),(3,'AGUA','MADERA Y METAL','HABILITADO'),(4,'ANTIHUMEDAD','BAÑOS Y COCINAS','HABILITADO'),(5,'ANTICORROSIVA','METALES Y REJAS','HABILITADO'),(6,'PISOS','CONCRETO Y TERRAZAS','HABILITADO'),(7,'AEROSOL','RETOQUES Y ARTE','HABILITADO'),(252,'aea','fgfg','HABILITADO');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias_seq`
--

DROP TABLE IF EXISTS `categorias_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias_seq`
--

LOCK TABLES `categorias_seq` WRITE;
/*!40000 ALTER TABLE `categorias_seq` DISABLE KEYS */;
INSERT INTO `categorias_seq` VALUES (401);
/*!40000 ALTER TABLE `categorias_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `ID_CLIENTE` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `ID_DISTRITO` int NOT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `celular` varchar(255) DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `sexo` varchar(255) NOT NULL,
  `habilitar` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`),
  KEY `fk_5` (`ID_DISTRITO`),
  CONSTRAINT `fk_5` FOREIGN KEY (`ID_DISTRITO`) REFERENCES `distrito` (`ID_DISTRITO`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'78546346','JULIA','AGUIRRE','STR 6 GR 5 MZ 9',102,'8645246','234326436','ghjsjs@gmail.com','Femenino','INHABILITADO'),(52,'86346346','afgha','gfhafgh','htrsh5',2,'6735634','999999999','fgsjg@gmail.com','Femenino','HABILITADO');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_seq`
--

DROP TABLE IF EXISTS `clientes_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_seq`
--

LOCK TABLES `clientes_seq` WRITE;
/*!40000 ALTER TABLE `clientes_seq` DISABLE KEYS */;
INSERT INTO `clientes_seq` VALUES (151);
/*!40000 ALTER TABLE `clientes_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distrito`
--

DROP TABLE IF EXISTS `distrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distrito` (
  `ID_DISTRITO` int NOT NULL AUTO_INCREMENT,
  `DISTRITO` varchar(255) NOT NULL,
  `HABILITAR` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_DISTRITO`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distrito`
--

LOCK TABLES `distrito` WRITE;
/*!40000 ALTER TABLE `distrito` DISABLE KEYS */;
INSERT INTO `distrito` VALUES (1,'VILLA EL SALVADOR','HABILITADO'),(2,'SAN JUAN DE MIRAFLORES','HABILITADO'),(102,'CALLAO','HABILITADO');
/*!40000 ALTER TABLE `distrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distrito_seq`
--

DROP TABLE IF EXISTS `distrito_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distrito_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distrito_seq`
--

LOCK TABLES `distrito_seq` WRITE;
/*!40000 ALTER TABLE `distrito_seq` DISABLE KEYS */;
INSERT INTO `distrito_seq` VALUES (251);
/*!40000 ALTER TABLE `distrito_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `ID_EMPLEADO` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `ID_DISTRITO` int NOT NULL,
  `ID_ROL` int NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `celular` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `EDAD` int NOT NULL,
  `sexo` varchar(255) NOT NULL,
  `habilitar` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_EMPLEADO`),
  KEY `FK_1` (`ID_DISTRITO`),
  KEY `FK_2` (`ID_ROL`),
  CONSTRAINT `FK_1` FOREIGN KEY (`ID_DISTRITO`) REFERENCES `distrito` (`ID_DISTRITO`),
  CONSTRAINT `FK_2` FOREIGN KEY (`ID_ROL`) REFERENCES `rol` (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=1104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1003,'86435252','sonia','molina','str6 grp8 mz 34',2,202,'6765252','952324526','sonia@gmail.com',56,'Femenino','deshabilitado'),(1103,'56346','fffff','ggggg','trheh34',2,52,'5646363','967363462','fgbs@gfkapinha',44,'Masculino','HABILITADO');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados_seq`
--

DROP TABLE IF EXISTS `empleados_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados_seq`
--

LOCK TABLES `empleados_seq` WRITE;
/*!40000 ALTER TABLE `empleados_seq` DISABLE KEYS */;
INSERT INTO `empleados_seq` VALUES (1201);
/*!40000 ALTER TABLE `empleados_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `ID_MARCAS` int NOT NULL AUTO_INCREMENT,
  `marca` varchar(255) NOT NULL,
  `habilitar` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_MARCAS`)
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'pato','HABILITADO'),(152,'tekno','HABILITADO'),(252,'agagagaga','HABILITADO');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas_seq`
--

DROP TABLE IF EXISTS `marcas_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas_seq`
--

LOCK TABLES `marcas_seq` WRITE;
/*!40000 ALTER TABLE `marcas_seq` DISABLE KEYS */;
INSERT INTO `marcas_seq` VALUES (401);
/*!40000 ALTER TABLE `marcas_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `ID_PERSON` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_PERSON`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'KEVINMORALES.WEB97@GMAIL.COM','DOTERO97','MORALES1234'),(2,'JULI1234@HOTMAIL.COM','POMPINCHU','AEA3456');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_seq`
--

DROP TABLE IF EXISTS `person_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_seq`
--

LOCK TABLES `person_seq` WRITE;
/*!40000 ALTER TABLE `person_seq` DISABLE KEYS */;
INSERT INTO `person_seq` VALUES (1);
/*!40000 ALTER TABLE `person_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `ID_PRODUCTOS` int NOT NULL AUTO_INCREMENT,
  `color` varchar(255) DEFAULT NULL,
  `p_costo` double NOT NULL,
  `p_venta` double NOT NULL,
  `ID_MARCAS` int NOT NULL,
  `ID_CATEGORIA` int NOT NULL,
  `CANTIDAD` int NOT NULL,
  `habilitar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCTOS`),
  KEY `FK_3` (`ID_MARCAS`),
  KEY `FK_4` (`ID_CATEGORIA`),
  CONSTRAINT `FK_3` FOREIGN KEY (`ID_MARCAS`) REFERENCES `marcas` (`ID_MARCAS`),
  CONSTRAINT `FK_4` FOREIGN KEY (`ID_CATEGORIA`) REFERENCES `categorias` (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'AZUL',23,34,152,3,45,'HABILITADO'),(2,'rojo',12,14,252,5,3,'HABILITADO'),(52,'griss',12,45,152,4,23,'DESHABILITADO'),(102,'blanco',66,134,252,252,456,'DESHABILITADO'),(152,'jj',34,233,152,4,4,'HABILITADO');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_seq`
--

DROP TABLE IF EXISTS `productos_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_seq`
--

LOCK TABLES `productos_seq` WRITE;
/*!40000 ALTER TABLE `productos_seq` DISABLE KEYS */;
INSERT INTO `productos_seq` VALUES (251);
/*!40000 ALTER TABLE `productos_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `ID_ROL` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `salario` double NOT NULL,
  `habilitar` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'ADMINISTRADOR','MANEJO DE PERSONAL Y RECURSOS',2340.7,'HABILITADO'),(52,'PROGRAMADOR','CREACION DE APLICACIONES',3000.9,'HABILITADO'),(202,'reponedor','fghaha',1222,'HABILITADO');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_seq`
--

DROP TABLE IF EXISTS `rol_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_seq`
--

LOCK TABLES `rol_seq` WRITE;
/*!40000 ALTER TABLE `rol_seq` DISABLE KEYS */;
INSERT INTO `rol_seq` VALUES (301);
/*!40000 ALTER TABLE `rol_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `ID_VENTA` int NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int NOT NULL,
  `ID_EMPLEADO` int NOT NULL,
  `ID_PRODUCTOS` int NOT NULL,
  `UNIDADES` int NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`ID_VENTA`),
  KEY `fk_6` (`ID_CLIENTE`),
  KEY `fk_7` (`ID_EMPLEADO`),
  KEY `fk_8` (`ID_PRODUCTOS`),
  CONSTRAINT `fk_6` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `clientes` (`ID_CLIENTE`),
  CONSTRAINT `fk_7` FOREIGN KEY (`ID_EMPLEADO`) REFERENCES `empleados` (`ID_EMPLEADO`),
  CONSTRAINT `fk_8` FOREIGN KEY (`ID_PRODUCTOS`) REFERENCES `productos` (`ID_PRODUCTOS`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (103,1,1103,52,43,1935);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_seq`
--

DROP TABLE IF EXISTS `ventas_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_seq`
--

LOCK TABLES `ventas_seq` WRITE;
/*!40000 ALTER TABLE `ventas_seq` DISABLE KEYS */;
INSERT INTO `ventas_seq` VALUES (201);
/*!40000 ALTER TABLE `ventas_seq` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-07 14:21:10
