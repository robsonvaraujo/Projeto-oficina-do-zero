SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- Oficina Mecânica
Create database IF NOT EXISTS `Oficina_Mecânica` DEFAULT CHARACTER SET utf8 ;
USE `Oficina_Mecânica` ;


-- Table `Oficina Mecânica`.`Clientes`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Clientes` (
  `idClientes` INT NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NULL,
  `Endereço` VARCHAR(150) NULL,
  `cpf` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `complamento` VARCHAR(50) NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- Tabela `Oficina Mecânica`.`Ordem de serviço`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Ordem_de_serviço` (
  `idOrdem_de_serviço` INT NOT NULL AUTO_INCREMENT,
  `Tipo_de_veículo` VARCHAR(45) NOT NULL,
  `Data` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `Valor` DECIMAL(10,2) NULL,
  `Status` VARCHAR(45) NULL,
  `Data_de_entrega` DATE NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `Defeito` VARCHAR(150) NULL,
  `Serviço` VARCHAR(45) NULL,
  `Responsavel` VARCHAR(50) NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idOrdem_de_serviço`, `Clientes_idClientes`),
  INDEX `fk_Ordem_de_serviço_Clientes_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_de_serviço_Clientes`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `Oficina_Mecânica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Tabela `Oficina Mecânica`.`Funcionários`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Funcionários` (
  `inFuncionario` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Função` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Area_de_atuação` VARCHAR(45) NOT NULL,
  `Código` VARCHAR(45) NULL,
  PRIMARY KEY (`inFuncionario`))
ENGINE = InnoDB;


-- Tabela `Oficina Mecânica`.`Peças`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Peças` (
  `idPeça` INT NOT NULL,
  `Referencia` VARCHAR(45) NULL,
  `Aplicação` VARCHAR(200) NULL,
  `Preço` DECIMAL(10,2) NULL,
  `Ordem_de_serviço_idOrdem_de_serviço` INT NOT NULL,
  `Ordem_de_serviço_Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idPeça`, `Ordem_de_serviço_idOrdem_de_serviço`, `Ordem_de_serviço_Clientes_idClientes`),
  INDEX `fk_Peça_Ordem_de_serviço1_idx` (`Ordem_de_serviço_idOrdem_de_serviço` ASC, `Ordem_de_serviço_Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Peça_Ordem_de_serviço1`
    FOREIGN KEY (`Ordem_de_serviço_idOrdem_de_serviço` , `Ordem_de_serviço_Clientes_idClientes`)
    REFERENCES `Oficina_Mecânica`.`Ordem_de_serviço` (`idOrdem_de_serviço` , `Clientes_idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Tabela `Oficina Mecânica`.`Tabela de referência de mão-de-obra`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Tabela_de_referência_de_mão-de-obra` (
  `idConcerto` INT NOT NULL,
  `tipo` VARCHAR(200) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `Ordem_de_serviço_idOrdem_de_serviço` INT NOT NULL,
  PRIMARY KEY (`idConcerto`, `Ordem_de_serviço_idOrdem_de_serviço`),
  INDEX `fk_Serviços_Ordem_de_serviço1_idx` (`Ordem_de_serviço_idOrdem_de_serviço` ASC) VISIBLE,
  CONSTRAINT `fk_Serviços_Ordem_de_serviço1`
    FOREIGN KEY (`Ordem_de_serviço_idOrdem_de_serviço`)
    REFERENCES `Oficina Mecânica`.`Ordem_de_serviço` (`idOrdem_de_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Tabela `Oficina Mecânica`.`Funcionários gera e executa OS`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Funcionários_gera_e_executa_OS` (
  `Funcionários_inFuncionario` INT NOT NULL,
  `Ordem_de_serviço_idOrdem_de_serviço` INT NOT NULL,
  `Ordem_de_serviço_Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`Funcionários_inFuncionario`, `Ordem_de_serviço_idOrdem_de_serviço`, `Ordem_de_serviço_Clientes_idClientes`),
  INDEX `fk_Funcionários_has_Ordem_de_serviço_Ordem_de_serviço1_idx` (`Ordem_de_serviço_idOrdem_de_serviço` ASC, `Ordem_de_serviço_Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Funcionários_has_Ordem_de_serviço_Funcionários1_idx` (`Funcionários_inFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionários_has_Ordem_de_serviço_Funcionários1`
    FOREIGN KEY (`Funcionários_inFuncionario`)
    REFERENCES `Oficina_Mecânica`.`Funcionários` (`inFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionários_has_Ordem_de_serviço_Ordem_de_serviço1`
    FOREIGN KEY (`Ordem_de_serviço_idOrdem_de_serviço` , `Ordem_de_serviço_Clientes_idClientes`)
    REFERENCES `Oficina_Mecânica`.`Ordem_de_serviço` (`idOrdem_de_serviço` , `Clientes_idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Tabela `Oficina Mecânica`.`Funcionario avalia`
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Funcionario_avalia` (
  `Clientes_idClientes` INT NOT NULL,
  `Funcionários_inFuncionario` INT NOT NULL,
  PRIMARY KEY (`Clientes_idClientes`, `Funcionários_inFuncionario`),
  INDEX `fk_Clientes_has_Funcionários_Funcionários1_idx` (`Funcionários_inFuncionario` ASC) VISIBLE,
  INDEX `fk_Clientes_has_Funcionários_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_has_Funcionários_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `Oficina_Mecânica`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_Funcionários_Funcionários1`
    FOREIGN KEY (`Funcionários_inFuncionario`)
    REFERENCES `Oficina_Mecânica`.`Funcionários` (`inFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;