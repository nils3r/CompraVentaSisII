-- MySQL Script generated by MySQL Workbench
-- Fri Oct 15 20:37:13 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbventas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbventas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbventas` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `dbventas` ;

-- -----------------------------------------------------
-- Table `dbventas`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(225) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_rol` INT NOT NULL,
  `nombre` VARCHAR(70) NOT NULL,
  `tipo_documento` VARCHAR(20) NOT NULL,
  `nro_documento` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(70) NULL,
  `telefono` VARCHAR(15) NULL,
  `correo` VARCHAR(50) NULL,
  `contrasena` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_rol_idx` (`id_rol` ASC)  ,
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`id_rol`)
    REFERENCES `dbventas`.`rol` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_persona` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(70) NOT NULL,
  `tipo_documento` VARCHAR(20) NULL,
  `nro_documento` VARCHAR(20) NULL,
  `direccion` VARCHAR(70) NULL,
  `correo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`ingreso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(7) NULL,
  `nro_comprobante` VARCHAR(10) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ingreso_persona_idx` (`id_persona` ASC)  ,
  INDEX `fk_ingreso_usuario_idx` (`id_usuario` ASC)  ,
  CONSTRAINT `fk_ingreso_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `dbventas`.`persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingreso_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbventas`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NULL,
  `serie_comprobante` VARCHAR(7) NULL,
  `nro_comprobante` VARCHAR(10) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total` DECIMAL(11,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_persona_idx` (`id_persona` ASC)  ,
  INDEX `fk_venta_usuario_idx` (`id_usuario` ASC)  ,
  CONSTRAINT `fk_venta_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `dbventas`.`persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `dbventas`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`articulo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_categoria` INT NOT NULL,
  `codigo` VARCHAR(50) NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  `stock` INT NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  `imagen` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_articulo_categoria_idx` (`id_categoria` ASC)  ,
  CONSTRAINT `fk_articulo_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `dbventas`.`categoria` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`detalle_venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_venta` INT NOT NULL,
  `id_articulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(11,2) NOT NULL,
  `descuento` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalleventa_venta_idx` (`id_venta` ASC)  ,
  INDEX `fk_detalleventa_articulo_idx` (`id_articulo` ASC)  ,
  CONSTRAINT `fk_detalleventa_venta`
    FOREIGN KEY (`id_venta`)
    REFERENCES `dbventas`.`venta` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleventa_articulo`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `dbventas`.`articulo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbventas`.`detalle_ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbventas`.`detalle_ingreso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_ingreso` INT NOT NULL,
  `id_articulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalleingreso_ingreso_idx` (`id_ingreso` ASC)  ,
  INDEX `fk_detalleingreso_articulo_idx` (`id_articulo` ASC)  ,
  CONSTRAINT `fk_detalleingreso_ingreso`
    FOREIGN KEY (`id_ingreso`)
    REFERENCES `dbventas`.`ingreso` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleingreso_articulo`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `dbventas`.`articulo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;