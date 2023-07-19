-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `art_gallery` ;

-- -----------------------------------------------------
-- Schema art_gallery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `art_gallery` DEFAULT CHARACTER SET utf8 ;
USE `art_gallery` ;

-- -----------------------------------------------------
-- Table `art_gallery`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artist` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artist` (
  `Artist_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(25) NOT NULL,
  `mname` VARCHAR(25) NULL,
  `lname` VARCHAR(25) NOT NULL,
  `dob` INT NULL,
  `dod` INT NULL,
  `country` VARCHAR(45) NOT NULL,
  `local` ENUM('y', 'n') NULL DEFAULT 'n',
  PRIMARY KEY (`Artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork` (
  `Artwork_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `year` INT NULL,
  `period` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `file` VARCHAR(45) NULL,
  `Artist_id` INT NOT NULL,
  PRIMARY KEY (`Artwork_id`, `Artist_id`),
  INDEX `fk_Artwork_Artist_idx` (`Artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artwork_Artist`
    FOREIGN KEY (`Artist_id`)
    REFERENCES `art_gallery`.`artist` (`Artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`keyword` (
  `keyword_id` INT NOT NULL AUTO_INCREMENT,
  `keyword` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`keyword_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `art_gallery`.`artwork_has_keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `art_gallery`.`artwork_has_keyword` ;

CREATE TABLE IF NOT EXISTS `art_gallery`.`artwork_has_keyword` (
  `Artwork_id` INT NOT NULL,
  `Artist_id` INT NOT NULL,
  `keyword_id` INT NOT NULL,
  PRIMARY KEY (`Artwork_id`, `Artist_id`, `keyword_id`),
  INDEX `fk_Artwork_has_keyword_keyword1_idx` (`keyword_id` ASC) VISIBLE,
  INDEX `fk_Artwork_has_keyword_Artwork1_idx` (`Artwork_id` ASC, `Artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_Artwork_has_keyword_Artwork1`
    FOREIGN KEY (`Artwork_id` , `Artist_id`)
    REFERENCES `art_gallery`.`artwork` (`Artwork_id` , `Artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artwork_has_keyword_keyword1`
    FOREIGN KEY (`keyword_id`)
    REFERENCES `art_gallery`.`keyword` (`keyword_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO artist (fname, mname, lname, dob, dod, country, local) VALUES
 ('Vincent', NULL, 'van Gogh', 1853, 1890, 'France', 'n'),
 ('Rembrandt', 'Harmenszoon', 'van Rijn', 1606, 1669, 'Netherlands', 'n'),
 ('Leonardo', NULL, 'da Vinci', 1452, 1519, 'Italy', 'n'),
 ('Venture', 'Lonzo', 'Coy', 1965, NULL, 'United States', 'y'),
 ('Deborah', NULL, 'Gill', 1970, NULL, 'United States', 'y'), 
 ('Claude', NULL, 'Monet', 1840, 1926, 'France', 'n'),
 ('Pablo', NULL, 'Picasso', 1904, 1973, 'Spain', 'n'), 
 ('Michelangelo', 'di Lobovico', 'Simoni', 1475, 1564, 'Italy', 'n');
 
INSERT INTO artwork (title, year, period, type, file, artist_id)
VALUES
  ('Irises', 1889, 'Impressionism', 'Oil', 'irises.jpg', 1),
  ('The Starry Night', 1889, 'Post-Impressionism', 'Oil', 'starrynight.jpg', 1),
  ('Sunflowers', 1888, 'Post-impressionism', 'Oil', 'sunflowers.jpg', 1),
  ('Night Watch', 1642, 'Baroque', 'Oil', 'nightwatch.jpg', 2),
  ('Storm on the Sea of Galilee', 1633, 'Dutch Golden Age', 'Oil', 'stormgalilee.jpg', 2),
  ('Head of a Woman', 1508, 'High Renaissance', 'Oil', 'headwoman.jpg', 3),
  ('Last Supper', 1498, 'Renaissance', 'Tempra', 'lastsupper.jpg', 3),
  ('Mona Lisa', 1517, 'Renaissance', 'Oil', 'monalisa.jpg', 3),
  ('Hillside Stream', 2005, 'Modern', 'Oil', 'hillsidestream.jpg', 4),
  ('Old Barn', 1992, 'Modern', 'Oil', 'oldbarn.jpg', 4),
  ('Beach Baby', 1999, 'Modern', 'Watercolor', 'beachbaby.jpg', 5),
  ('Women in the Garden', 1866, 'Impressionism', 'Oil', 'womengarden.jpg', 6),
  ('Old Guitarist', 1904, 'Modern', 'Oil', 'guitarist.jpg', 7);

INSERT INTO keyword (keyword)
VALUES
  ('flowers'),
  ('blue'),
  ('landscape'),
  ('people'),
  ('battle'),
  ('boat'),
  ('water'),
  ('Christ'),
  ('food'),
  ('girl'),
  ('baby');

 

INSERT INTO artist (fname, mname, lname, dob, dod, country, local) VALUES
 ('Vincent', NULL, 'van Gogh', 1853, 1890, 'France', 'n'),
 ('Rembrandt', 'Harmenszoon', 'van Rijn', 1606, 1669, 'Netherlands', 'n'),
 ('Leonardo', NULL, 'da Vinci', 1452, 1519, 'Italy', 'n'),
 ('Venture', 'Lonzo', 'Coy', 1965, NULL, 'United States', 'y'),
 ('Deborah', NULL, 'Gill', 1970, NULL, 'United States', 'y'), 
 ('Claude', NULL, 'Monet', 1840, 1926, 'France', 'n'),
 ('Pablo', NULL, 'Picasso', 1904, 1973, 'Spain', 'n'), 
 ('Michelangelo', 'di Lobovico', 'Simoni', 1475, 1564, 'Italy', 'n');
 
INSERT INTO artwork (title, year, period, type, file, artist_id)
VALUES
  ('Irises', 1889, 'Impressionism', 'Oil', 'irises.jpg', 1),
  ('The Starry Night', 1889, 'Post-Impressionism', 'Oil', 'starrynight.jpg', 1),
  ('Sunflowers', 1888, 'Post-impressionism', 'Oil', 'sunflowers.jpg', 1),
  ('Night Watch', 1642, 'Baroque', 'Oil', 'nightwatch.jpg', 2),
  ('Storm on the Sea of Galilee', 1633, 'Dutch Golden Age', 'Oil', 'stormgalilee.jpg', 2),
  ('Head of a Woman', 1508, 'High Renaissance', 'Oil', 'headwoman.jpg', 3),
  ('Last Supper', 1498, 'Renaissance', 'Tempra', 'lastsupper.jpg', 3),
  ('Mona Lisa', 1517, 'Renaissance', 'Oil', 'monalisa.jpg', 3),
  ('Hillside Stream', 2005, 'Modern', 'Oil', 'hillsidestream.jpg', 4),
  ('Old Barn', 1992, 'Modern', 'Oil', 'oldbarn.jpg', 4),
  ('Beach Baby', 1999, 'Modern', 'Watercolor', 'beachbaby.jpg', 5),
  ('Women in the Garden', 1866, 'Impressionism', 'Oil', 'womengarden.jpg', 6),
  ('Old Guitarist', 1904, 'Modern', 'Oil', 'guitarist.jpg', 7);

INSERT INTO keyword (keyword)
VALUES
  ('flowers'),
  ('blue'),
  ('landscape'),
  ('people'),
  ('battle'),
  ('boat'),
  ('water'),
  ('Christ'),
  ('food'),
  ('girl'),
  ('baby');

SELECT * FROM artist;

SELECT * FROM artwork;

SELECT * FROM keyword;


 