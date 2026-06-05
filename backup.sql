-- MySQL dump 10.13  Distrib 8.3.0, for Win64 (x86_64)
--
-- Host: localhost    Database: autos_amistosos
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `automovil`
--

DROP TABLE IF EXISTS `automovil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automovil` (
  `idAutomovil` char(17) NOT NULL,
  `Modelo` varchar(45) DEFAULT NULL,
  `Precio_Lista` decimal(10,2) DEFAULT NULL,
  `FechaFabricacion` date DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `Kilometraje_Entrega` int DEFAULT NULL,
  `Condicion` enum('NUEVO','USADO') NOT NULL DEFAULT 'USADO',
  `Tipo_Carroceria` enum('Sedan','SUV','Hatchback','Camioneta','Deportivo') DEFAULT NULL,
  `Estado` enum('DISPONIBLE','VENDIDO') NOT NULL DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`idAutomovil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automovil`
--

LOCK TABLES `automovil` WRITE;
/*!40000 ALTER TABLE `automovil` DISABLE KEYS */;
INSERT INTO `automovil` VALUES ('A1B-2C3D4E5F6G7','Outback',35500.00,'2023-02-18','Plata',15000,'USADO','SUV','VENDIDO'),('AAA-00112233445','Corolla',26750.00,'2024-03-01','Negro',0,'NUEVO','Sedan','VENDIDO'),('ABC-00000000001','CRV',665000.00,'2022-04-10','Blanco',30000,'USADO','SUV','VENDIDO'),('ABC-1234567890123','Focus',25500.00,'2024-05-15','Rojo',0,'NUEVO','Sedan','VENDIDO'),('ABC-12345678912','Model Y',49990.00,'2025-01-01','Gris',0,'USADO','SUV','VENDIDO'),('BBB-55667788990','Bronco',55900.50,'2023-11-20','Verde',0,'USADO','SUV','VENDIDO'),('DEF-98765432109','Civic',30000.50,'2023-10-20','Azul',0,'NUEVO','Hatchback','VENDIDO'),('FGH-45678901234','Fusion',42000.00,'2023-08-15','Plata',0,'NUEVO','Sedan','DISPONIBLE'),('H8I-9J0K1L2M3N4','Ram 1500',65000.00,'2024-04-12','Negro',0,'NUEVO','Camioneta','DISPONIBLE'),('IJK-11223344556','Pathfinder',55000.00,'2024-01-20','Negro',0,'NUEVO','SUV','DISPONIBLE'),('LMN-67890123456','Mustang',48000.00,'2022-05-10','Rojo',25000,'USADO','Deportivo','DISPONIBLE'),('OPQ-33445566778','Tundra',62000.00,'2023-09-01','Blanco',1000,'USADO','Camioneta','DISPONIBLE'),('P5Q-6R7S8T9U0V1','CX-5',29000.00,'2023-07-05','Rojo',5000,'USADO','SUV','DISPONIBLE'),('RST-99001122334','A3',31000.00,'2024-03-10','Gris',0,'NUEVO','Sedan','DISPONIBLE'),('US-23456789012','Silverado',39000.00,'2020-05-15','Negro',60000,'USADO','Camioneta','VENDIDO'),('US-45678901234','Challenger',28500.00,'2018-03-25','Naranja',55000,'USADO','Deportivo','VENDIDO'),('US-56789012345','Rio',11000.00,'2017-11-10','Azul',110000,'USADO','Hatchback','VENDIDO'),('UVW-55667788990','Explorer',49500.00,'2021-11-25','Azul',40000,'USADO','SUV','DISPONIBLE'),('XYZ-12345678901','Jeep GC',450000.00,'2024-05-01','Verde',0,'NUEVO','SUV','VENDIDO');
/*!40000 ALTER TABLE `automovil` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dianita`@`%`*/ /*!50003 TRIGGER `tr_auditar_cambio_precio_automovil` BEFORE UPDATE ON `automovil` FOR EACH ROW BEGIN
    IF OLD.Precio_Lista <> NEW.Precio_Lista THEN
        INSERT INTO Automovil_Auditoria_Precios (
            idAutomovil_fk,
            Precio_Anterior,
            Precio_Nuevo,
            Usuario_Modifica
        )
        VALUES (
            OLD.idAutomovil,   
            OLD.Precio_Lista,     
            NEW.Precio_Lista,     
            USER()               
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `automovil_auditoria_precios`
--

DROP TABLE IF EXISTS `automovil_auditoria_precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automovil_auditoria_precios` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `idAutomovil_fk` varchar(50) NOT NULL,
  `Precio_Anterior` decimal(10,2) NOT NULL,
  `Precio_Nuevo` decimal(10,2) NOT NULL,
  `Fecha_Cambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Usuario_Modifica` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automovil_auditoria_precios`
--

LOCK TABLES `automovil_auditoria_precios` WRITE;
/*!40000 ALTER TABLE `automovil_auditoria_precios` DISABLE KEYS */;
INSERT INTO `automovil_auditoria_precios` VALUES (1,'XYZ-12345678901',58000.00,450000.00,'2025-12-11 13:23:20','dianita@localhost'),(3,'ABC-00000000001',35000.00,665000.00,'2025-12-11 15:40:51','dianita@localhost');
/*!40000 ALTER TABLE `automovil_auditoria_precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido1` varchar(45) DEFAULT NULL,
  `Apellido2` varchar(45) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Marcela ','Cortez','Diaz','DOMINGO DORADO #9','4941018956','zul@gmail.com'),(5,'Juan','Ortega','asa','DOMINGO DORADO #9','4941018956','a@gmail.com'),(6,'Luke','Skylwaljer','','DOMINGO DORADO #9','4941018956','correo@gmail.com'),(8,'Diana Rebeca','Ortega','Salas','DOMINGO DORADO #9','4941018956','dianaort931@gmail.com'),(9,'Buscando','a','Nemo','DOMINGO DORADO #9','4941018956','dianaort931@gmail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_potencial`
--

DROP TABLE IF EXISTS `cliente_potencial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_potencial` (
  `idCliente_Potencial` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellido1` varchar(45) NOT NULL,
  `Apellido2` varchar(45) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `Fuente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCliente_Potencial`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_potencial`
--

LOCK TABLES `cliente_potencial` WRITE;
/*!40000 ALTER TABLE `cliente_potencial` DISABLE KEYS */;
INSERT INTO `cliente_potencial` VALUES (1,'Juan','Ortega','','','bb@gmail.com','PUBLICIDAD'),(2,'Juan','Ortega','','','bb@gmail.com','PUBLICIDAD'),(3,'Juan','','','','',''),(4,'Juan','Ortega','','','',''),(5,'','','','','',''),(6,'','','','','',''),(7,'Juan','ss','','','','REFERIDO'),(8,'Juan','Ortega','','','bb@gmail.com','FERIA'),(9,'Juan','Ortega','','','a@gmail.com','REFERIDO'),(10,'DIANA REBECA','Ortega','','DOMINGO DORADO #9','dianaort931@gmail.com','WEB'),(11,'w','w','w','','w@gmail.com','FERIA'),(12,'w','w','w','','w@gmail.com','FERIA'),(13,'w','w','w','','w@gmail.com','FERIA'),(14,'z','z','z','z','z@gmail.com','FERIA'),(15,'z','z','z','z','z@gmail.com','FERIA'),(16,'z','z','z','z','z@gmail.com','FERIA'),(17,'e','e','e','e','e@gmail.com','REFERIDO'),(18,'f','f','f','f','f@gmail.com','REFERIDO'),(19,'k','k','k','k','k@gmail.com','WEB'),(20,'Diana','Ortega','Salas','DOMINGO DORADO #9','dianaort931@gmail.com','PUBLICIDAD'),(21,'Diana','Ortega','Salas','DOMINGO DORADO #9','dianaort931@gmail.com','PUBLICIDAD'),(22,'Juan','Ortega','asa','DOMINGO DORADO #9','j@gmail.com','FERIA'),(23,'sss','w','w','2','2@gmail.com','PUBLICIDAD'),(24,'daiana','Rebec','Ortega','DOMINGO DORADO #9','a@gmail.com','WEB'),(25,'daiana','Rebec','Ortega','DOMINGO DORADO #9','luke@gmail.com','WEB');
/*!40000 ALTER TABLE `cliente_potencial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `garantia`
--

DROP TABLE IF EXISTS `garantia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `garantia` (
  `idGarantia` int NOT NULL,
  `Nombre_Garantia` varchar(45) DEFAULT NULL,
  `Costo` decimal(8,2) DEFAULT NULL,
  `Duracion_Meses` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idGarantia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garantia`
--

LOCK TABLES `garantia` WRITE;
/*!40000 ALTER TABLE `garantia` DISABLE KEYS */;
INSERT INTO `garantia` VALUES (1,'Garantía Extendida 1 Año',500.00,12),(2,'Garantía Básica 3 Meses',150.00,3);
/*!40000 ALTER TABLE `garantia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos`
--

DROP TABLE IF EXISTS `puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puestos` (
  `ID_Puesto` int NOT NULL AUTO_INCREMENT,
  `Nombre_Puesto` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Puesto`),
  UNIQUE KEY `Nombre_Puesto` (`Nombre_Puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (3,'Administrador'),(1,'Gerente'),(2,'Vendedor');
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `ID_Usuario` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Perfil` enum('dueno','administrador','vendedor') NOT NULL,
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE KEY `Usuario` (`Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Administrador Principal','admin','8cb2237d0679ca88db6464eac60da96345513964','administrador'),(2,'Jim Amistoso','dueno','8cb2237d0679ca88db6464eac60da96345513964','dueno'),(3,'Carlos Vendedor','cvendedor','8cb2237d0679ca88db6464eac60da96345513964','vendedor'),(4,'Diana Rebeca','diana','1b2fc9341a16ae4e30082965d537ae47c21a0f27fd43eab78330ed81751ae6db','administrador'),(5,'Ana Garcia','ana','72019bbac0b3dac88beac9ddfef0ca808919104f','vendedor'),(6,'Rosa Marquez','rosa','5efc86ca883e265ab0bf38d45731d8612695cafa','dueno');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `idVendedor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellido1` varchar(45) NOT NULL,
  `Apellido2` varchar(45) DEFAULT NULL,
  `Salario_Base` decimal(9,2) DEFAULT NULL,
  `Porcentaje_Comision` decimal(5,4) DEFAULT NULL,
  PRIMARY KEY (`idVendedor`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (3,'Danonino','Arandano','Vicente',15000.00,0.3000),(8,'Sandra','Eduardo','Mendoza',200.00,0.0000),(9,'Esteban','Ortega','Dena',15000.00,0.0150),(10,'Alejandra','Ortega','',15000.00,0.0150),(12,'Maria','Maza',NULL,2222.00,0.2500),(14,'Alameda','TestApellido','',1000.00,0.0500),(15,'Rebeca','García','duran',5454.00,0.4400),(19,'Lucrecia','Ortega','',15000.00,0.0150),(20,'Alma','Maria','',15000.00,0.0150),(24,'Dana','Ortega','Salas',22.00,0.0001),(26,'Almendra','Jimenes','avarretes',2242.00,0.0100),(27,'Sushi','Ortega','Salas',0.01,0.0001),(28,'Adobada','Ortega','Salas',22.00,0.0001),(29,'fresa','Ortega','Salas',0.02,0.0001),(30,'Diana Rebeca','Ortega','Salas',0.02,0.0001),(31,'Diana Rebeca','Ortega','Salas',0.01,0.0004),(32,'Nopal','Ortega','Salas',0.01,0.0001),(33,'Diana Rebeca','Ortega','Salas',0.01,0.0001);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `Fecha_Venta` timestamp NOT NULL,
  `Precio_Final` decimal(10,2) DEFAULT NULL,
  `Impuesto_Venta` decimal(10,2) DEFAULT NULL,
  `Costo_Licencia` decimal(10,2) DEFAULT NULL,
  `Vendedor_idVendedor` int NOT NULL,
  `Cliente_idCliente` int NOT NULL,
  `idAutomovil` char(17) NOT NULL,
  `idGarantia` int DEFAULT NULL,
  `VIN_Intercambio` char(17) DEFAULT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `Vendedor_idVendedor` (`Vendedor_idVendedor`),
  KEY `Cliente_idCliente` (`Cliente_idCliente`),
  KEY `idAutomovil` (`idAutomovil`),
  KEY `idGarantia` (`idGarantia`),
  KEY `VIN_Intercambio` (`VIN_Intercambio`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`Vendedor_idVendedor`) REFERENCES `vendedor` (`idVendedor`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`idAutomovil`) REFERENCES `automovil` (`idAutomovil`),
  CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`idGarantia`) REFERENCES `garantia` (`idGarantia`),
  CONSTRAINT `venta_ibfk_5` FOREIGN KEY (`VIN_Intercambio`) REFERENCES `automovil` (`idAutomovil`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (3,'2025-12-01 18:34:36',444.00,0.04,0.00,3,1,'ABC-12345678912',NULL,NULL),(4,'2025-12-01 18:40:35',333.00,0.03,0.00,3,1,'US-56789012345',NULL,NULL),(6,'2025-12-01 20:24:12',777.00,0.07,0.00,3,1,'AAA-00112233445',2,NULL),(7,'2025-12-02 01:02:48',111.00,0.01,0.00,3,1,'ABC-00000000001',2,NULL),(10,'2025-12-11 18:24:57',88.00,0.08,0.08,3,1,'DEF-98765432109',NULL,NULL),(11,'2025-12-11 18:29:04',5.00,0.05,0.05,3,5,'A1B-2C3D4E5F6G7',1,NULL),(12,'2025-12-13 02:22:19',100.00,0.00,0.00,3,6,'XYZ-12345678901',1,NULL),(13,'2026-06-12 06:00:00',2.00,0.01,0.01,3,1,'FGH-45678901234',NULL,NULL),(14,'2026-06-28 06:00:00',2.00,0.02,0.02,3,1,'LMN-67890123456',NULL,NULL);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vistaventa`
--

DROP TABLE IF EXISTS `vistaventa`;
/*!50001 DROP VIEW IF EXISTS `vistaventa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaventa` AS SELECT 
 1 AS `idVenta`,
 1 AS `Fecha_Venta`,
 1 AS `Precio_Final`,
 1 AS `Impuesto_Venta`,
 1 AS `Costo_Licencia`,
 1 AS `Nombre_Vendedor`,
 1 AS `Nombre_Cliente`,
 1 AS `idAutomovil`,
 1 AS `Modelo_Automovil`,
 1 AS `Color_Automovil`,
 1 AS `Condicion_Automovil`,
 1 AS `Tipo_Vehiculo`,
 1 AS `Precio_Lista`,
 1 AS `Kilometraje_Entrega`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaventavendedor`
--

DROP TABLE IF EXISTS `vistaventavendedor`;
/*!50001 DROP VIEW IF EXISTS `vistaventavendedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaventavendedor` AS SELECT 
 1 AS `idVenta`,
 1 AS `Fecha_Venta`,
 1 AS `Precio_Final`,
 1 AS `Vendedor_idVendedor`,
 1 AS `Nombre_Vendedor`,
 1 AS `Nombre_Cliente`,
 1 AS `Apellido1_Cliente`,
 1 AS `idAutomovil`,
 1 AS `Modelo_Automovil`,
 1 AS `Kilometraje_Entrega`,
 1 AS `Condicion_Automovil`,
 1 AS `Tipo_Vehiculo`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vistaventa`
--

/*!50001 DROP VIEW IF EXISTS `vistaventa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dianita`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaventa` AS select `v`.`idVenta` AS `idVenta`,`v`.`Fecha_Venta` AS `Fecha_Venta`,`v`.`Precio_Final` AS `Precio_Final`,`v`.`Impuesto_Venta` AS `Impuesto_Venta`,`v`.`Costo_Licencia` AS `Costo_Licencia`,`vu`.`Nombre` AS `Nombre_Vendedor`,`c`.`Nombre` AS `Nombre_Cliente`,`a`.`idAutomovil` AS `idAutomovil`,`a`.`Modelo` AS `Modelo_Automovil`,`a`.`Color` AS `Color_Automovil`,`a`.`Condicion` AS `Condicion_Automovil`,`a`.`Tipo_Carroceria` AS `Tipo_Vehiculo`,`a`.`Precio_Lista` AS `Precio_Lista`,`a`.`Kilometraje_Entrega` AS `Kilometraje_Entrega` from (((`venta` `v` join `automovil` `a` on((`v`.`idAutomovil` = `a`.`idAutomovil`))) join `bd_usuarios_autosamistosos_2025`.`usuarios` `vu` on((`v`.`Vendedor_idVendedor` = `vu`.`ID_Usuario`))) join `cliente` `c` on((`v`.`Cliente_idCliente` = `c`.`idCliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaventavendedor`
--

/*!50001 DROP VIEW IF EXISTS `vistaventavendedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dianita`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaventavendedor` AS select `v`.`idVenta` AS `idVenta`,`v`.`Fecha_Venta` AS `Fecha_Venta`,`v`.`Precio_Final` AS `Precio_Final`,`v`.`Vendedor_idVendedor` AS `Vendedor_idVendedor`,`vu`.`Nombre` AS `Nombre_Vendedor`,`c`.`Nombre` AS `Nombre_Cliente`,`c`.`Apellido1` AS `Apellido1_Cliente`,`a`.`idAutomovil` AS `idAutomovil`,`a`.`Modelo` AS `Modelo_Automovil`,`a`.`Kilometraje_Entrega` AS `Kilometraje_Entrega`,`a`.`Condicion` AS `Condicion_Automovil`,`a`.`Tipo_Carroceria` AS `Tipo_Vehiculo` from (((`venta` `v` join `automovil` `a` on((`v`.`idAutomovil` = `a`.`idAutomovil`))) join `bd_usuarios_autosamistosos_2025`.`usuarios` `vu` on((`v`.`Vendedor_idVendedor` = `vu`.`ID_Usuario`))) join `cliente` `c` on((`v`.`Cliente_idCliente` = `c`.`idCliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-04 21:31:28
