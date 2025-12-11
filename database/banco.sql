CREATE SCHEMA IF NOT EXISTS `db_wkteste` DEFAULT CHARACTER SET latin1 ;
USE `db_wkteste` ;

CREATE TABLE IF NOT EXISTS `db_wkteste`.`clientes` (
  `codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `cidade` VARCHAR(100) NULL DEFAULT NULL,
  `uf` CHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `db_wkteste`.`pedidos_venda` (
  `numero_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `data_emissao` DATE NOT NULL,
  `codigo_cliente` INT(11) NOT NULL,
  `valor_total` DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  INDEX `codigo_cliente` (`codigo_cliente` ASC) VISIBLE,
  CONSTRAINT `pedidos_venda_ibfk_1`
    FOREIGN KEY (`codigo_cliente`)
    REFERENCES `db_wkteste`.`clientes` (`codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `db_wkteste`.`produtos` (
  `codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NOT NULL,
  `precoVenda` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `db_wkteste`.`pedidos_vendas_itens` (
  `codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `numero_pedido` INT(11) NOT NULL,
  `codigo_produto` INT(11) NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `valor_unitario` DECIMAL(10,2) NOT NULL,
  `valor_total` DECIMAL(15,2) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `idx_numero_pedido` (`numero_pedido` ASC) VISIBLE,
  INDEX `idx_codigo_produto` (`codigo_produto` ASC) VISIBLE,
  CONSTRAINT `pedidos_vendas_itens_ibfk_1`
    FOREIGN KEY (`numero_pedido`)
    REFERENCES `db_wkteste`.`pedidos_venda` (`numero_pedido`)
    ON DELETE CASCADE,
  CONSTRAINT `itens_pedido_ibfk_2`
    FOREIGN KEY (`codigo_produto`)
    REFERENCES `db_wkteste`.`produtos` (`codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = latin1;

