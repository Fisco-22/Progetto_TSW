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
    '7f9ed89c7297f99669b6e79d9d8d404d19f160ca40b40f42896506fa7942786b', 
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
    'd730ead8ecca48ae5563ad20c6b048305394b7934fba47cf68dce9f61002a9cb', 
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
(1, 'Barcellona, Spagna', 'Ottima posizione, a 20 metri dalla Ramblas, per chi vuole godersi al massimo il soggiorno. Struttura moderna con terrazza panoramica e colazione inclusa.', 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?auto=format&fit=crop&w=500&q=80', 109.00, 150, 'francescopagliuchi@admin.com'),

(2, 'Parigi, Francia', 'Hotel in stile informale con arredi ispirati al design moderno e vicino ai musei principali. Camere dotate di ogni comfort, ideali per un weekend romantico a due passi dalla metropolitana.', 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=500&q=80', 164.00, 120, 'francescopagliuchi@admin.com'),

(3, 'Amsterdam, Paesi Bassi', 'Splendido alloggio ricavato in una struttura storica, con diverse tipologie di camere. Atmosfera accogliente e artistica, a pochi minuti dai canali principali e dalle attrazioni culturali.', 'https://images.unsplash.com/photo-1534351590666-13e3e96b5017?auto=format&fit=crop&w=500&q=80', 260.00, 80, 'francescopagliuchi@admin.com'),

(4, 'Roma, Italia', 'Camere spaziose immerse nel verde del quartiere EUR, ottimi collegamenti con il centro storico tramite la metro. Ideale per chi cerca tranquillità senza rinunciare alle meraviglie della Capitale.', 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?auto=format&fit=crop&w=500&q=80', 128.00, 200, 'francescopagliuchi@admin.com'),

(5, 'Venezia, Italia', 'Affacciato direttamente sulle acque del canale principale, interni eleganti in stile classico veneziano. Un\'esperienza magica e senza tempo nel cuore della città galleggiante più bella del mondo.', 'https://images.unsplash.com/photo-1520175480921-4edfa2983e0f?auto=format&fit=crop&w=500&q=80', 195.00, 95, 'francescopagliuchi@admin.com');

-- =========================================================================
-- PASSO 3: INSERIMENTO DI UNA RECENSIONE (Operazione eseguita dall'Utente)
-- =========================================================================

-- Ora che l'utente esiste e il viaggio 1 esiste, la recensione funzionerà alla perfezione!
INSERT INTO RECENSIONE(Voto, Commento, Data_Recensione, Email_Utente, Codice_Viaggio)
VALUES(
    5, 
    'Viaggio fantastico, organizzazione perfetta e hotel stupendo. Consigliatissimo!', 
    CURDATE(), 
    'f.verdi@gmail.com', 
    1
);

-- PASSO 4: ORDINE DI PROVA (l'utente compra il viaggio 1 a prezzo storico)
INSERT INTO ORDINE(Email_Utente, Totale_Ordine, Indirizzo_Spedizione, Metodo_Pagamento, Ultime4Cifre)
VALUES('f.verdi@gmail.com', 218.00, 'Via delle Puglie 21, Benevento', 'Carta di credito', '4242');

INSERT INTO DETTAGLIO_ORDINE(Codice_Ordine, Codice_Viaggio, Destinazione, Prezzo_Acquisto, Data_Partenza, Num_Posti)
VALUES(LAST_INSERT_ID(), 1, 'Barcellona, Spagna', 109.00, '2026-10-15', 2);