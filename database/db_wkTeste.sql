CREATE DATABASE `db_wkteste` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

CREATE TABLE `pedidos_venda` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` decimal(15,2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `codigo_cliente` (`codigo_cliente`),
  CONSTRAINT `pedidos_venda_ibfk_1` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;

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

CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) NOT NULL,
  `precoVenda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;