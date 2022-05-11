CREATE TABLE `dicerollkingdom`.`personale` (
  `cf` VARCHAR(16) NOT NULL,
  `tipo_personale` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(13) UNIQUE NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `ruolo` VARCHAR(20) NULL,
  `operazioni_registrate` INT NULL,
  `stipendio` FLOAT NOT NULL,
  PRIMARY KEY (`cf`),
  CHECK (`tipo_personale` = 'commesso' OR `tipo_personale` = 'gestore'));



CREATE TABLE `dicerollkingdom`.`cliente` (
  `cod_tessera` INT NOT NULL AUTO_INCREMENT,
  `cf` VARCHAR(16) UNIQUE NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(30) NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `telefono` VARCHAR(13) NULL,
  `cf_personale` VARCHAR(16) NOT NULL,
  `data_tesseramento` DATE NOT NULL,
  PRIMARY KEY (`cod_tessera`),
  FOREIGN KEY (`cf_personale`)
    REFERENCES `dicerollkingdom`.`personale` (`cf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  

CREATE TABLE `dicerollkingdom`.`fornitori` (
  `cf` VARCHAR(16) NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(13) NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  PRIMARY KEY (`cf`));



CREATE TABLE `dicerollkingdom`.`collane_editoriali` (
  `idc` VARCHAR(10) NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_fine` DATE NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  PRIMARY KEY (`idc`),
  CHECK(`data_fine` >= `data_inizio`));



CREATE TABLE `dicerollkingdom`.`eventi` (
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  `durata` VARCHAR(20) NOT NULL,
  `tipologia` VARCHAR(20) NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  `num_partecipanti` INT NULL DEFAULT 0,
  PRIMARY KEY (`data`, `ora`),
  CHECK(`num_partecipanti` >= 0));



CREATE TABLE `dicerollkingdom`.`partecipanti` (
  `cod_tessera` INT NOT NULL,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  PRIMARY KEY (`cod_tessera`, `data`, `ora`),
    FOREIGN KEY (`cod_tessera`)
    REFERENCES `dicerollkingdom`.`cliente` (`cod_tessera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`data` , `ora`)
    REFERENCES `dicerollkingdom`.`eventi` (`data` , `ora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `dicerollkingdom`.`prodotti` (
  `idp` VARCHAR(10) NOT NULL,
  `idc` VARCHAR(10) NULL
  REFERENCES `dicerollkingdom`.`collane_editoriali` (`idc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  `tipologia` VARCHAR(7) NOT NULL,
  `titolo` VARCHAR(20) NOT NULL,
  `produttore` VARCHAR(20) NOT NULL,
  `prezzo` FLOAT NOT NULL,
  `durata` VARCHAR(15) NULL,
  `num_giocatori` VARCHAR(10) NULL,
  `categoria` VARCHAR(20) NULL,
  `disponibilità` INT NOT NULL,
  PRIMARY KEY (`idp`),
  CHECK (`tipologia` = 'gioco' OR `tipologia` = 'manuale'));



CREATE TABLE `dicerollkingdom`.`operazione` (
  `idop` VARCHAR(10) NOT NULL,
  `cod_tessera` INT NULL,
  `idp` VARCHAR(10) NOT NULL,
  `cf_personale` VARCHAR(16) NOT NULL,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  `tipologia` VARCHAR(15) NOT NULL,
  `incasso` FLOAT NULL,
  `acconto` FLOAT NULL,
  `rimborso` VARCHAR(20) NULL,
  PRIMARY KEY (`idop`),
  CHECK (`tipologia` = 'acquisto' OR `tipologia` = 'prenotazione' OR `tipologia` = 'reso'),
    FOREIGN KEY (`cod_tessera`)
    REFERENCES `dicerollkingdom`.`cliente` (`cod_tessera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`idp`)
    REFERENCES `dicerollkingdom`.`prodotti` (`idp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`cf_personale`)
    REFERENCES `dicerollkingdom`.`personale` (`cf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `dicerollkingdom`.`abbonamenti` (
  `ida` VARCHAR(10) NOT NULL,
  `cod_tessera` INT NOT NULL,
  `idc` VARCHAR(10) NOT NULL,
  `inizio` DATE NOT NULL,
  `fine` DATE NULL,
  `sconto` FLOAT NOT NULL,
  PRIMARY KEY (`ida`),
  CHECK(`fine` >= `inizio`),
    FOREIGN KEY (`cod_tessera`)
    REFERENCES `dicerollkingdom`.`cliente` (`cod_tessera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`idc`)
    REFERENCES `dicerollkingdom`.`collane_editoriali` (`idc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `dicerollkingdom`.`ordini` (
  `ido` VARCHAR(10) NOT NULL,
  `cf_personale` VARCHAR(16) NOT NULL,
  `cf_fornitore` VARCHAR(16) NULL,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  `arrivo_stimato` DATE NULL,
  `arrivo_effettivo` DATE NULL,
  `num_prodotti` INT NOT NULL,
  PRIMARY KEY (`ido`),
  CHECK(`arrivo_stimato` >= `data` AND `arrivo_effettivo` >= `data`),
    FOREIGN KEY (`cf_personale`)
    REFERENCES `dicerollkingdom`.`personale` (`cf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`cf_fornitore`)
    REFERENCES `dicerollkingdom`.`fornitori` (`cf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `dicerollkingdom`.`prodotti_contenuti` (
  `ido` VARCHAR(10) NOT NULL,
  `idp` VARCHAR(10) NOT NULL,
  `quantità` INT NOT NULL,
  PRIMARY KEY (`ido`, `idp`),
    FOREIGN KEY (`idp`)
    REFERENCES `dicerollkingdom`.`prodotti` (`idp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`ido`)
    REFERENCES `dicerollkingdom`.`ordini` (`ido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE `dicerollkingdom`.`eventi_pianificati` (
  `cf_personale` VARCHAR(16) NOT NULL,
  `data` DATE NOT NULL,
  `ora` TIME NOT NULL,
  PRIMARY KEY (`cf_personale`, `data`, `ora`),
    FOREIGN KEY (`cf_personale`)
    REFERENCES `dicerollkingdom`.`personale` (`cf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`data` , `ora`)
    REFERENCES `dicerollkingdom`.`eventi` (`data` , `ora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


