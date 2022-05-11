-- O1 --
INSERT INTO cliente VALUES
(cod_tessera, "cf", "nome", "cognome", "indirizzo", "telefono", "cf_personale", "data_tesseramento");


-- O2 --
INSERT INTO operazione VALUES
("idop", cod_tessera, "idp", "cf_personale", "data", "ora", "tipologia", incasso, acconto, "rimborso");


-- O3 --
INSERT INTO abbonamenti VALUES
("ida", cod_tessera, "idc", "inizio", "fine", sconto);


-- O4 --
DELETE FROM abbonamenti
WHERE ida = "ida";


-- O5 --
DELETE FROM operazione
WHERE idop = "idop";


-- O6 --
INSERT INTO partecipanti VALUES
(cod_tessera,"data","ora");


-- O7 --
INSERT INTO eventi_pianificati VALUES
("cf_personale", "data", "ora");

INSERT INTO eventi VALUES
("data", "ora", "durata", "tipologia", "descrizione", num_partecipanti);


-- O8 --
DELETE FROM eventi 
WHERE data = "data" AND ora = "ora";

DELETE FROM eventi_pianificati
WHERE cf_personale = "cf_personale"
AND data = "data"
AND ora = "ora";


-- O9 --
INSERT INTO ordini VALUES
("ido", "cf_personale", "cf_fornitore", "data", "ora", "arrivo_stimato", "arrivo_effettivo", num_prodotti);


-- O10 --
INSERT INTO prodotti_contenuti VALUES
("ido", "idp", quantità);


-- O11 --
DELETE FROM prodotti_contenuti
WHERE ido = "ido" AND idp = "idp";


-- O12 --
UPDATE ordini 
SET cf_fornitore = "cf_fornitore"
WHERE ido = "ido";


-- O13 --
SELECT cf, nome, cognome, operazioni_registrate
FROM personale 
WHERE tipo_personale = "commesso";


-- O14 --
SELECT * 
FROM operazione 
WHERE cod_tessera = cod_tessera;


-- O15 --

SELECT cod_tessera, idc 
FROM abbonamenti
WHERE cod_tessera = cod_tessera;


-- O16 --
SELECT ido, sum(prezzo*quantità) AS "costo totale"
FROM prodotti_contenuti JOIN prodotti ON prodotti_contenuti.idp = prodotti.idp
WHERE ido = "ido";


-- O17 --
SELECT *
FROM ordini
WHERE cf_personale = "cf_personale";


-- O18 --
SELECT partecipanti.cod_tessera, nome, cognome, data, ora
FROM partecipanti JOIN cliente ON partecipanti.cod_tessera = cliente.cod_tessera
WHERE data = "data" AND ora = "ora";


-- O19 --
SELECT data, ora, num_partecipanti
FROM eventi;