SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `LittleLemonDB` ;
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customers` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `FullName` VARCHAR(200) NOT NULL ,
  `ContactNumber` VARCHAR(20) NOT NULL ,
  `Email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`CustomerID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Staffs` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`Staffs` (
  `StaffID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `FullName` VARCHAR(200) NOT NULL ,
  `Role` VARCHAR(100) NOT NULL ,
  `MonthlySalary` DECIMAL(10,2) UNSIGNED NOT NULL ,
  PRIMARY KEY (`StaffID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`MenuItems` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `CourseName` VARCHAR(200) NOT NULL ,
  `StarterName` VARCHAR(200) NOT NULL ,
  `DesertName` VARCHAR(200) NOT NULL ,
  `UnitPrice` DECIMAL(10,2) UNSIGNED NOT NULL ,
  PRIMARY KEY (`MenuItemID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menus` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `MenuName` VARCHAR(200) NOT NULL ,
  `Cuisine` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`MenuID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenusAndMenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`MenusAndMenuItems` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`MenusAndMenuItems` (
  `MenusAndMenuItemsID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `MenuID` INT UNSIGNED NOT NULL ,
  `MenuItemID` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`MenusAndMenuItemsID`) ,
  INDEX `MenuItemID_FK` (`MenuItemID` ASC) ,
  INDEX `Menu_FK_idx` (`MenuID` ASC) ,
  CONSTRAINT `MenuItemID_FK`
    FOREIGN KEY (`MenuItemID` )
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Menu_FK`
    FOREIGN KEY (`MenuID` )
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `CustomerID` INT UNSIGNED NOT NULL ,
  `MenusAndMenuItemsID` INT UNSIGNED NOT NULL ,
  `Quantity` INT UNSIGNED NOT NULL ,
  `TotalCost` DECIMAL(10,2) UNSIGNED NOT NULL ,
  `OrderDate` DATE NOT NULL DEFAULT (CURRENT_DATE()) ,
  PRIMARY KEY (`OrderID`) ,
  INDEX `CustomerID_FK` (`CustomerID` ASC) ,
  CONSTRAINT `CustomerID_FK`
    FOREIGN KEY (`CustomerID` )
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MenusAndMenuItemsID_FK`
    FOREIGN KEY (`MenusAndMenuItemsID` )
    REFERENCES `LittleLemonDB`.`MenusAndMenuItems` (`MenusAndMenuItemsID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderDeliveryStatus` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `DeliveryID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `OrderID` INT UNSIGNED NOT NULL ,
  `DeliveryDate` DATE NOT NULL DEFAULT (CURRENT_DATE()) ,
  `Status` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`DeliveryID`) ,
  CONSTRAINT `OrderID_FK`
    FOREIGN KEY (`OrderID` )
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE  TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `CustomerID` INT UNSIGNED NOT NULL ,
  `BookingDate` DATE NOT NULL DEFAULT (CURRENT_DATE()) ,
  `TableNumber` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`BookingID`) ,
  INDEX `CustomerID_Bookings_idx` (`CustomerID` ASC) ,
  CONSTRAINT `CustomerID_Bookings_FK`
    FOREIGN KEY (`CustomerID` )
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `LittleLemonDB` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
