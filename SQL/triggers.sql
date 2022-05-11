DROP TRIGGER IF EXISTS `dicerollkingdom`.`prodotti_contenuti_AFTER_INSERT`;

DELIMITER $$
USE `dicerollkingdom`$$
CREATE DEFINER = CURRENT_USER TRIGGER `dicerollkingdom`.`prodotti_contenuti_AFTER_INSERT` 
AFTER INSERT ON `prodotti_contenuti` 
FOR EACH ROW
BEGIN
    DECLARE x integer;
    SELECT sum(quantità) INTO x
        FROM prodotti_contenuti
        WHERE idp = new.idp;
        UPDATE ordini 
        SET num_prodotti = num_prodotti + x
        WHERE ido = new.ido;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `dicerollkingdom`.`prodotti_contenuti_AFTER_DELETE`;

DELIMITER $$
USE `dicerollkingdom`$$
CREATE DEFINER = CURRENT_USER TRIGGER `dicerollkingdom`.`prodotti_contenuti_AFTER_DELETE` 
AFTER DELETE ON `prodotti_contenuti` 
FOR EACH ROW
BEGIN
    DECLARE x integer;
    SELECT sum(quantità) INTO x
        FROM prodotti_contenuti
        WHERE idp <> old.idp
        AND ido = old.ido;
        UPDATE ordini 
        SET num_prodotti = x
        WHERE ido = old.ido;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `dicerollkingdom`.`operazione_AFTER_INSERT`;

DELIMITER $$
USE `dicerollkingdom`$$
CREATE DEFINER = CURRENT_USER TRIGGER `dicerollkingdom`.`operazione_AFTER_INSERT` 
AFTER INSERT ON `operazione` 
FOR EACH ROW
BEGIN
    DECLARE x integer;
    UPDATE personale
        SET operazioni_registrate = operazioni_registrate + 1
        WHERE cf = new.cf_personale;
    SELECT count(*) INTO x
        FROM operazione
        WHERE idop = new.idop
        AND tipologia ="acquisto";
    UPDATE prodotti
        SET disponibilità = disponibilità - x
        WHERE idp = new.idp;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `dicerollkingdom`.`partecipanti_AFTER_INSERT`;

DELIMITER $$
USE `dicerollkingdom`$$
CREATE DEFINER = CURRENT_USER TRIGGER `dicerollkingdom`.`partecipanti_AFTER_INSERT` 
AFTER INSERT ON `partecipanti` 
FOR EACH ROW
BEGIN
    UPDATE eventi
        SET num_partecipanti = num_partecipanti + 1
        WHERE data = new.data AND ora = new.ora;
END$$
DELIMITER ;