-- Edwin Rodriguez Valle
-- Solving constrinst in a already make squema

CREATE SCHEMA bestellingen;
USE bestellingen ;


CREATE TABLE Klant (
  klantnr INT NOT NULL,
  klantnaam VARCHAR(45) NOT NULL,
  plaats VARCHAR(45) NOT NULL
);


CREATE TABLE Bestelling (
  bestelnr INT NOT NULL,
  klantnr INT NOT NULL,
  besteldatum DATE NOT NULL
);


CREATE TABLE Artikel (
  artikelcode VARCHAR(12) NOT NULL,
  artikelnaam VARCHAR(45) NOT NULL,
  btwtarief VARCHAR(4) NOT NULL,
  artikelprijs DECIMAL(6,2) NOT NULL,
  voorraad INT NOT NULL
);


CREATE TABLE Bestelregel (
  bestelnr INT NOT NULL,
  artikelcode VARCHAR(12) NOT NULL,
  aantal INT NOT NULL
);

ALTER TABLE `bestellingen`.`Klant` 
ADD CONSTRAINT pk_Klant PRIMARY KEY (`klantnr`);

ALTER TABLE `bestellingen`.`Bestelling` 
ADD CONSTRAINT pk_Bestelling PRIMARY KEY (`bestelnr`);

ALTER TABLE `bestellingen`.`Klant` 
CHANGE COLUMN `klantnr` `klantnr` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `bestellingen`.`Bestelling` 
ADD INDEX `fk_Bestelling_Klant_idx` (`klantnr` ASC);

ALTER TABLE `bestellingen`.`Bestelling` 
ADD CONSTRAINT `fk_Bestelling_Klant`
  FOREIGN KEY (`klantnr`)
  REFERENCES `bestellingen`.`Klant` (`klantnr`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

-- ------------------------------------------------------------------ 
-- Solvinf the excersices 2
-- ------------------------------------------------------------------ 

ALTER TABLE `bestellingen`.`Artikel` 
ADD PRIMARY KEY pk_artikel (`artikelcode`);

ALTER TABLE `bestellingen`.`Bestelregel` 
ADD PRIMARY KEY pk_bestelrege (`bestelnr`, `artikelcode`);

-- Opdracht 2b
ALTER TABLE `bestellingen`.`Bestelling` 
CHANGE COLUMN `bestelnr` `bestelnr` INT NOT NULL AUTO_INCREMENT ;

-- Opdracht 2c
ALTER TABLE `bestellingen`.`Bestelregel` 
ADD CONSTRAINT `fk_Bestelregel_Bestelling`
  FOREIGN KEY (`bestelnr`)
  REFERENCES `bestellingen`.`Bestelling` (`bestelnr`)
  ON DELETE CASCADE
  ON UPDATE RESTRICT;

ALTER TABLE `bestellingen`.`Bestelregel` 
ADD CONSTRAINT `fk_Bestelregel_Artikel`
  FOREIGN KEY (`artikelcode`)
  REFERENCES `bestellingen`.`Artikel` (`artikelcode`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
-- Opdracht 2d
ALTER TABLE `bestellingen`.`Artikel` 
ADD CONSTRAINT `co_voorraad`
CHECK (`voorraad` >= 0);

ALTER TABLE `bestellingen`.`Bestelregel` 
ADD CONSTRAINT `co_aantal`
CHECK (`aantal` >= 0);

-- Opdracht 2e
CREATE UNIQUE INDEX uk_klant_datum
ON `bestellingen`.`bestelling`(klantnr, besteldatum);

