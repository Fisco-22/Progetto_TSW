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

-- Creiamo il viaggio a Marsa Alam associandolo all'email dell'admin appena creato
INSERT INTO VIAGGIO(Codice_Viaggio, Destinazione, Costo_Totale, n_posti, Email_Admin)
VALUES(
    1, 
    'Marsa Alam', 
    469.98, 
    600, 
    'francescopagliuchi@admin.com'
);


-- =========================================================================
-- PASSO 3: PRENOTAZIONE DEL VIAGGIO (Operazione eseguita dall'Utente)
-- =========================================================================

-- L'utente 'f.verdi@gmail.com' prenota il viaggio con Codice_Viaggio = 1
INSERT INTO PRENOTARE(Email_Utente, Codice_Viaggio, Stato_Pagamento, Data_Prenotazione)
VALUES(
    'f.verdi@gmail.com', 
    1, 
    'In sospeso', 
    CURDATE() -- CURDATE() inserisce in automatico la data di oggi
);


-- =========================================================================
-- PASSO 4: INSERIMENTO DI UNA RECENSIONE (Operazione eseguita dall'Utente)
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