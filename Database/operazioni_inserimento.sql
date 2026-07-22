USE travelbooking_db;

-- =========================================================================
-- PASSO 1: INSERIMENTO UTENTI DI PROVA
-- =========================================================================

-- 1. Inseriamo l'Amministratore del sito (Ruolo: 'admin')
INSERT INTO UTENTE(Email, Nome, Cognome, Password, Ruolo, Data_Nascita, Indirizzo)
VALUES(
    'francescopagliuchi@admin.com', 
    'Francesco', 
    'Pagliuchi', 
    '4d0b24ccade22df6d154778cd66baf04288aae26df97a961f3ea3dd616fbe06dcebecc9bbe4ce93c8e12dca21e5935c08b0954534892c568b8c12b92f26a2448', -- SHA-512 di: Admin123
    'admin', 
    '1995-01-01', 
    'Via Roma 1, Milano'
);

-- 2. Inseriamo un Utente Cliente Standard (Ruolo: 'utente')
INSERT INTO UTENTE(Email, Nome, Cognome, Password, Ruolo, Data_Nascita, Indirizzo)
VALUES(
    'f.verdi@gmail.com', 
    'Francesco', 
    'Verdi', 
    '718415384172b85cd17aaa51f9ee557b5981751ec517b9af79a051dad0048382984c3cf3757d5822151dde056d9e84a576526036ee1dc24b522f6d2ffadcc5a9', -- SHA-512 di: Verdi123
    'utente', 
    '1998-09-07', 
    'Via delle Puglie 21, Benevento'
);


-- =========================================================================
-- PASSO 2: ORGANIZZAZIONE DI UN VIAGGIO (Operazione eseguita dall'Admin)
-- =========================================================================



-- INSERIMENTO DEI 5 VIAGGI DI INDEX.HTML
INSERT INTO VIAGGIO(Codice_Viaggio, Destinazione, Descrizione, Immagine_URL, Costo_Totale, n_posti, Email_Admin)
VALUES
(1, 'Barcellona, Spagna', 'Ottima posizione, a 20 metri dalla Ramblas, per chi vuole godersi al massimo il soggiorno. Struttura moderna con terrazza panoramica e colazione inclusa.', 'images/Barcellona.jpg', 109.00, 150, 'francescopagliuchi@admin.com'),

(2, 'Parigi, Francia', 'Hotel in stile informale con arredi ispirati al design moderno e vicino ai musei principali. Camere dotate di ogni comfort, ideali per un weekend romantico a due passi dalla metropolitana.', 'images/Parigi.jpg', 164.00, 120, 'francescopagliuchi@admin.com'),

(3, 'Amsterdam, Paesi Bassi', 'Splendido alloggio ricavato in una struttura storica, con diverse tipologie di camere. Atmosfera accogliente e artistica, a pochi minuti dai canali principali e dalle attrazioni culturali.', 'images/Amsterdam.jpg', 260.00, 80, 'francescopagliuchi@admin.com'),

(4, 'Roma, Italia', 'Camere spaziose immerse nel verde del quartiere EUR, ottimi collegamenti con il centro storico tramite la metro. Ideale per chi cerca tranquillità senza rinunciare alle meraviglie della Capitale.', 'images/Roma.jpg', 128.00, 200, 'francescopagliuchi@admin.com'),

(5, 'Venezia, Italia', 'Affacciato direttamente sulle acque del canale principale, interni eleganti in stile classico veneziano. Un\'esperienza magica e senza tempo nel cuore della città galleggiante più bella del mondo.', 'images/Venezia.jpg', 195.00, 95, 'francescopagliuchi@admin.com');

-- PASSO 3: ORDINE DI PROVA (l'utente compra il viaggio 1 a prezzo storico)
INSERT INTO ORDINE(Email_Utente, Totale_Ordine, Indirizzo_Spedizione, Metodo_Pagamento, Ultime4Cifre)
VALUES('f.verdi@gmail.com', 218.00, 'Via delle Puglie 21, Benevento', 'Carta di credito', '4242');

INSERT INTO DETTAGLIO_ORDINE(Codice_Ordine, Codice_Viaggio, Destinazione, Prezzo_Acquisto, Data_Partenza, Num_Posti)
VALUES(LAST_INSERT_ID(), 1, 'Barcellona, Spagna', 109.00, '2026-10-15', 2);


UPDATE VIAGGIO SET Immagine_URL = 'images/Barcellona.jpg' WHERE Codice_Viaggio = 1;
UPDATE VIAGGIO SET Immagine_URL = 'images/Parigi.jpg'     WHERE Codice_Viaggio = 2;
UPDATE VIAGGIO SET Immagine_URL = 'images/Amsterdam.jpg'  WHERE Codice_Viaggio = 3;
UPDATE VIAGGIO SET Immagine_URL = 'images/Roma.jpg'       WHERE Codice_Viaggio = 4;
UPDATE VIAGGIO SET Immagine_URL = 'images/Venezia.jpg'    WHERE Codice_Viaggio = 5;