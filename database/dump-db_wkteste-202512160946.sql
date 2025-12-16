/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_wkteste
-- ------------------------------------------------------
-- Server version	11.8.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
(1,'JOSE SILVEIRA','SÃO PAULO','SP'),
(2,'ANDRE RODRIGUES','RECIFE','PE'),
(3,'ANTONIO SILVERO','CURITIBA','PR'),
(4,'TULIO SILVA','PALMAS','TO'),
(5,'JULIO CESAR','PETROLINA','PE'),
(6,'LUIZ HENRIQUE','PETROLINA','PE'),
(7,'RENATO BARRO','JUAZEIRO','BA'),
(8,'SILVIO ANDRADE','RIO DE JANEIRO','RJ'),
(9,'AUGUSTO CESAR','PALMAS','TO'),
(10,'ANISIO MORENO','SALGUEIRO','PE'),
(11,'RICARDO TORRES','LONDRINA','PR'),
(12,'ADRIANO SILVEIRA','PELOTAS','RS'),
(13,'GERALDO LUIZ','SAO PAULO','SP'),
(14,'TEREZA RAQUEL','BRASILIA','DF'),
(15,'LUIZA MARIA','BELO HORIZONTE','MG'),
(16,'RENATA SANTOS','FEIRA DE SANTANA','BA'),
(17,'HELLEN FERREIRA','RIO BRANCO','AC'),
(18,'JOSÉ ALUISIO','SAO BERNARDO','SP'),
(19,'FELIPE MOREIRA','ARACAJU','SE'),
(20,'MARIO HENRIQUE','SAO LUIZ','MA');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_venda`
--

DROP TABLE IF EXISTS `pedidos_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_venda` (
  `numero_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int(11) NOT NULL,
  `valor_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `codigo_cliente` (`codigo_cliente`),
  CONSTRAINT `pedidos_venda_ibfk_1` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_venda`
--

LOCK TABLES `pedidos_venda` WRITE;
/*!40000 ALTER TABLE `pedidos_venda` DISABLE KEYS */;
INSERT INTO `pedidos_venda` VALUES
(1,'2025-12-15',4,0.00),
(2,'2025-12-15',7,0.00),
(3,'2025-12-15',2,0.00),
(4,'2025-12-15',3,0.00),
(5,'2025-12-15',5,0.00),
(6,'2025-12-15',9,0.00),
(7,'2025-12-15',11,0.00),
(8,'2025-12-15',2,0.00),
(9,'2025-12-15',4,0.00),
(10,'2025-12-15',9,0.00),
(11,'2025-12-15',10,0.00);
/*!40000 ALTER TABLE `pedidos_venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_vendas_itens`
--

DROP TABLE IF EXISTS `pedidos_vendas_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_vendas_itens` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `numero_pedido` int(11) NOT NULL,
  `codigo_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_numero_pedido` (`numero_pedido`),
  KEY `idx_codigo_produto` (`codigo_produto`),
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `pedidos_vendas_itens_ibfk_1` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos_venda` (`numero_pedido`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_vendas_itens`
--

LOCK TABLES `pedidos_vendas_itens` WRITE;
/*!40000 ALTER TABLE `pedidos_vendas_itens` DISABLE KEYS */;
INSERT INTO `pedidos_vendas_itens` VALUES
(46,1,5,1,899.00,899.00),
(47,2,8,1,200.00,200.00),
(48,2,1,1,45.00,45.00),
(49,1,4,1,80.00,80.00),
(50,2,4,1,80.00,80.00),
(51,1,2,1,499.00,499.00),
(52,3,1,1,45.00,45.00),
(53,4,5,1,899.00,899.00),
(54,1,4,1,80.00,80.00),
(55,1,8,1,200.00,200.00),
(56,2,6,1,39.00,39.00),
(57,5,3,2,20.00,40.00),
(58,2,8,1,200.00,200.00),
(59,4,8,1,200.00,200.00),
(60,4,6,1,39.00,39.00),
(61,4,3,1,20.00,20.00),
(62,1,8,1,200.00,200.00),
(63,6,7,1,150.00,150.00),
(64,6,8,1,200.00,200.00),
(65,5,7,20,150.00,3000.00),
(66,3,1,1,45.00,45.00),
(67,5,6,1,39.00,39.00),
(68,5,8,1,200.00,200.00),
(69,5,3,1,20.00,20.00),
(70,7,7,1,150.00,150.00),
(71,8,8,1,200.00,200.00),
(72,5,8,2,200.00,400.00),
(73,9,8,1,200.00,200.00),
(74,9,2,1,499.00,499.00),
(75,9,3,10,20.00,200.00),
(76,5,8,10,200.00,2000.00),
(77,2,7,10,150.00,1500.00),
(78,5,8,1,200.00,200.00),
(79,10,5,10,899.00,8990.00),
(80,11,7,1,150.00,150.00);
/*!40000 ALTER TABLE `pedidos_vendas_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) NOT NULL,
  `precoVenda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES
(1,'CHAVE DE RODA CELTA',45.00),
(2,'AMORTECEDOR DIANTEIRO',499.00),
(3,'LAMPADA TRASEIRA LOGAN',20.00),
(4,'ROLAMENTO DIANTEIRO',80.00),
(5,'KIT AMORTECEDOR GOL',899.00),
(6,'OLEO DE MOTOR 10/40W',39.00),
(7,'CORREIA DENTADA ASTRA',150.00),
(8,'CAIXA DA BATERIA TEMPRA',200.00);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_pedidos_venda`
--

DROP TABLE IF EXISTS `vw_pedidos_venda`;
/*!50001 DROP VIEW IF EXISTS `vw_pedidos_venda`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_pedidos_venda` AS SELECT
 1 AS `numero_pedido`,
  1 AS `data_emissao`,
  1 AS `nome_cliente`,
  1 AS `valor_total` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'db_wkteste'
--

--
-- Final view structure for view `vw_pedidos_venda`
--

/*!50001 DROP VIEW IF EXISTS `vw_pedidos_venda`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pedidos_venda` AS select `p`.`numero_pedido` AS `numero_pedido`,date_format(`p`.`data_emissao`,'%d/%m/%Y') AS `data_emissao`,`c`.`nome` AS `nome_cliente`,format(`p`.`valor_total`,2,'pt_BR') AS `valor_total` from (`pedidos_venda` `p` left join `clientes` `c` on(`c`.`codigo` = `p`.`codigo_cliente`)) */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-12-16  9:46:46
