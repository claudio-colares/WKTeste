-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: db_wkteste
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'JOSE SILVEIRA','SÃO PAULO','SP'),(2,'ANDRE RODRIGUES','RECIFE','PE'),(3,'ANTONIO SILVERO','CURITIBA','PR'),(4,'TULIO SILVA','PALMAS','TO'),(5,'JULIO CESAR','PETROLINA','PE'),(6,'LUIZ HENRIQUE','PETROLINA','PE'),(7,'RENATO BARRO','JUAZEIRO','BA'),(8,'SILVIO ANDRADE','RIO DE JANEIRO','RJ'),(9,'AUGUSTO CESAR','PALMAS','TO'),(10,'ANISIO MORENO','SALGUEIRO','PE'),(11,'RICARDO TORRES','LONDRINA','PR'),(12,'ADRIANO SILVEIRA','PELOTAS','RS'),(13,'GERALDO LUIZ','SAO PAULO','SP'),(14,'TEREZA RAQUEL','BRASILIA','DF'),(15,'LUIZA MARIA','BELO HORIZONTE','MG'),(16,'RENATA SANTOS','FEIRA DE SANTANA','BA'),(17,'HELLEN FERREIRA','RIO BRANCO','AC'),(18,'JOSÉ ALUISIO','SAO BERNARDO','SP'),(19,'FELIPE MOREIRA','ARACAJU','SE'),(20,'MARIO HENRIQUE','SAO LUIZ','MA');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_venda`
--

DROP TABLE IF EXISTS `pedidos_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_venda` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `codigo_cliente` (`codigo_cliente`),
  CONSTRAINT `pedidos_venda_ibfk_1` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_venda`
--

LOCK TABLES `pedidos_venda` WRITE;
/*!40000 ALTER TABLE `pedidos_venda` DISABLE KEYS */;
INSERT INTO `pedidos_venda` VALUES (2,'2025-12-15',7,203.00),(3,'2025-12-15',2,649.00),(6,'2025-12-15',9,350.00),(8,'2025-12-15',2,0.00),(9,'2025-12-16',5,450.00),(12,'2025-12-16',13,285.00),(14,'2025-12-17',3,379.00),(15,'2025-12-17',4,245.00);
/*!40000 ALTER TABLE `pedidos_venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_vendas_itens`
--

DROP TABLE IF EXISTS `pedidos_vendas_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_vendas_itens` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_numero_pedido` (`numero_pedido`),
  KEY `idx_codigo_produto` (`codigo_produto`),
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `pedidos_vendas_itens_ibfk_1` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos_venda` (`numero_pedido`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_vendas_itens`
--

LOCK TABLES `pedidos_vendas_itens` WRITE;
/*!40000 ALTER TABLE `pedidos_vendas_itens` DISABLE KEYS */;
INSERT INTO `pedidos_vendas_itens` VALUES (48,2,1,1,45.00,45.00),(50,2,4,1,80.00,80.00),(56,2,6,2,39.00,78.00),(63,6,7,1,150.00,150.00),(64,6,8,1,200.00,200.00),(83,8,7,1,150.00,150.00),(87,12,4,2,80.00,160.00),(88,12,4,1,80.00,80.00),(89,12,1,1,45.00,45.00),(92,3,7,1,150.00,150.00),(93,3,2,1,499.00,499.00),(95,9,1,10,45.00,450.00),(104,2,1,1,45.00,0.00),(105,6,1,1,45.00,45.00),(106,14,4,1,80.00,80.00),(107,14,5,1,299.00,299.00),(108,15,1,1,45.00,45.00),(109,15,8,1,200.00,200.00),(111,8,8,1,200.00,200.00);
/*!40000 ALTER TABLE `pedidos_vendas_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) NOT NULL,
  `precoVenda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'CHAVE DE RODA CELTA',45.00),(2,'AMORTECEDOR DIANTEIRO',499.00),(3,'LAMPADA TRASEIRA LOGAN',20.00),(4,'ROLAMENTO DIANTEIRO',80.00),(5,'KIT AMORTECEDOR GOL',899.00),(6,'OLEO DE MOTOR 10/40W',39.00),(7,'CORREIA DENTADA ASTRA',150.00),(8,'CAIXA DA BATERIA TEMPRA',200.00);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_wkteste'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-17  9:27:03
