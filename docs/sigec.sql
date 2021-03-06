SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `sigec` ;
CREATE SCHEMA IF NOT EXISTS `sigec` DEFAULT CHARACTER SET utf8 ;
USE `sigec` ;

-- -----------------------------------------------------
-- Table `sigec`.`GRUPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`GRUPO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESC_GRUPO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`FAMILIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`FAMILIA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESC_FAMILIA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`LOCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`LOCAL` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESC_LOCAL` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`FORNECEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`FORNECEDOR` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RAZAO` VARCHAR(45) NOT NULL,
  `NOME_FANTASIA` VARCHAR(45)  NOT NULL,
  `CNPJ` VARCHAR(14) NOT NULL,
  `IE` VARCHAR(45) NULL,
  `END` VARCHAR(45) NOT NULL,
  `BAIRRO` VARCHAR(45) NOT NULL,
  `ESTADO` VARCHAR(45) NOT NULL,
  `TEL` VARCHAR(11) NOT NULL,
  `CIDADE` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(45) NULL,
  `CONTATO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`PRODUTO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESC_PROD` VARCHAR(45) NOT NULL,
  `ESTOQ_MIN` INT NOT NULL,
  `ESTOQ_MAX` INT NOT NULL,
  `VALOR_CUSTO` DECIMAL(10,2) NOT NULL,
  `VALOR_VENDA` DECIMAL(10,2) NOT NULL,
  `OBS` VARCHAR(100) NULL,
  `QTDE` INT NOT NULL,
  `GRUPO_ID` INT NOT NULL,
  `FAMILIA_ID` INT NOT NULL,
  `LOCAL_ID` INT NOT NULL,
  `FORNECEDOR_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PRODUTO_GRUPO1_idx` (`GRUPO_ID` ASC),
  INDEX `fk_PRODUTO_FAMILIA1_idx` (`FAMILIA_ID` ASC),
  INDEX `fk_PRODUTO_LOCAL1_idx` (`LOCAL_ID` ASC),
  INDEX `fk_PRODUTO_FORNECEDOR1_idx` (`FORNECEDOR_ID` ASC),
  CONSTRAINT `fk_PRODUTO_GRUPO1`
    FOREIGN KEY (`GRUPO_ID`)
    REFERENCES `sigec`.`GRUPO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_FAMILIA1`
    FOREIGN KEY (`FAMILIA_ID`)
    REFERENCES `sigec`.`FAMILIA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_LOCAL1`
    FOREIGN KEY (`LOCAL_ID`)
    REFERENCES `sigec`.`LOCAL` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_FORNECEDOR1`
    FOREIGN KEY (`FORNECEDOR_ID`)
    REFERENCES `sigec`.`FORNECEDOR` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`CLIENTE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  `NOME_MAE` VARCHAR(45) NOT NULL,
  `END` VARCHAR(45) NOT NULL,
  `TEL` VARCHAR(11) NOT NULL,
  `CPF_CNPJ` VARCHAR(14) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  `CIDADE` VARCHAR(45) NOT NULL,
  `ESTADO` VARCHAR(45) NOT NULL,
  `BAIRRO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sigec`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`USUARIO` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  `LOGIN` VARCHAR(45) NOT NULL UNIQUE,
  `SENHA` VARCHAR(45) NOT NULL,
  `PERFIL_USUARIO` VARCHAR(45) NOT NULL,
  `ATIVO` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sigec`.`VENDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sigec`.`VENDA` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TOTAL` DECIMAL(10,2) NULL,
  `QTDE_PRODUTO` INT NULL,
  `APRAZO` INT NULL,
  `AVISTA` INT NULL,
  `CLIENTE_ID` INT NOT NULL,
  `USUARIO_ID` INT NOT NULL,
  `PRODUTO_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `CLIENTE_ID`, `USUARIO_ID`, `PRODUTO_ID`),
  INDEX `fk_VENDA_CLIENTE1_idx` (`CLIENTE_ID` ASC),
  INDEX `fk_VENDA_USUARIO1_idx` (`USUARIO_ID` ASC),
  INDEX `fk_VENDA_PRODUTO1_idx` (`PRODUTO_ID` ASC),
  CONSTRAINT `fk_VENDA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_ID`)
    REFERENCES `sigec`.`CLIENTE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENDA_USUARIO1`
    FOREIGN KEY (`USUARIO_ID`)
    REFERENCES `sigec`.`USUARIO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENDA_PRODUTO1`
    FOREIGN KEY (`PRODUTO_ID`)
    REFERENCES `sigec`.`PRODUTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO USUARIO VALUES (1, 'Administrador', 'admin', md5('admin'), 'administrador', 1);
INSERT INTO FORNECEDOR VALUES(1, 'temp', 'temp', 'temp','temp','temp','temp','temp','temp','temp','temp','temp');
INSERT INTO GRUPO VALUES(1, 'temp');                                                                                                                                                                                          
INSERT INTO FAMILIA VALUES(1, 'temp');                                                                                                                                                                                        
INSERT INTO LOCAL VALUES(1, 'temp');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

