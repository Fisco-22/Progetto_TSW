-- ============================================================================
-- Operazioni SQL eseguite dai DAO dell'applicazione TravelBooking.
-- Versione con valori d'esempio, pronta da eseguire in MySQL.
--
-- NOTA sulle password: nel DB sono salvate come hash SHA-512 in esadecimale
-- (128 caratteri). In MySQL lo stesso hash si ottiene con SHA2('...', 512),
-- quindi un utente creato qui potra' fare login anche dal sito.
-- ============================================================================
USE travelbooking_db;

-- ============================================================================
-- ViaggioDAO
-- ============================================================================

-- getViaggioById: dettaglio di un singolo viaggio
SELECT * FROM VIAGGIO WHERE Codice_Viaggio = 1;

-- getAllViaggi: elenco completo dei viaggi (home / catalogo)
SELECT * FROM VIAGGIO;

-- salvaViaggio: inserimento di un nuovo viaggio (area amministratore)
INSERT INTO VIAGGIO (Destinazione, Descrizione, Immagine_URL, Costo_Totale, n_posti, Email_Admin)
VALUES ('Lisbona, Portogallo', 'Soggiorno panoramico nel cuore della citta, colazione inclusa.',
        'images/Lisbona.jpg', 149.00, 100, 'francescopagliuchi@admin.com');

-- aggiornaViaggio: modifica di un viaggio esistente
UPDATE VIAGGIO
SET Destinazione = 'Barcellona, Spagna',
    Descrizione  = 'Ottima posizione a due passi dalla Ramblas.',
    Immagine_URL = 'images/Barcellona.jpg',
    Costo_Totale = 119.00,
    n_posti      = 140
WHERE Codice_Viaggio = 1;

-- cancellaViaggio: cancellazione di un viaggio (qui l'esempio inserito sopra)
DELETE FROM VIAGGIO WHERE Codice_Viaggio = 6;

-- ============================================================================
-- UtenteDAO
-- ============================================================================

-- salvaUtente: registrazione di un nuovo utente
INSERT INTO UTENTE (Email, Nome, Cognome, Password, Ruolo, Data_Nascita, Indirizzo)
VALUES ('mario.rossi@gmail.com', 'Mario', 'Rossi', SHA2('Password1', 512),
        'utente', '2000-05-14', 'Via Roma 1, Salerno');

-- salvaUtente: inserimento di un numero di telefono associato all'utente
INSERT INTO TELEFONO_UTENTE (Email_Utente, Numero_Telefono)
VALUES ('mario.rossi@gmail.com', '333-1234567');

-- checkLogin: verifica delle credenziali (email + password hashata)
SELECT * FROM UTENTE
WHERE Email = 'mario.rossi@gmail.com' AND Password = SHA2('Password1', 512);

-- checkLogin: recupero dei telefoni dell'utente autenticato
SELECT Numero_Telefono FROM TELEFONO_UTENTE WHERE Email_Utente = 'mario.rossi@gmail.com';

-- ============================================================================
-- OrdineDAO
-- ============================================================================

-- salvaOrdine (1/2): salvataggio della testata dell'ordine (checkout)
INSERT INTO ORDINE (Email_Utente, Totale_Ordine, Indirizzo_Spedizione, Metodo_Pagamento, Ultime4Cifre)
VALUES ('f.verdi@gmail.com', 218.00, 'Via Napoli 10, Salerno', 'Carta di credito', '3456');

-- salvaOrdine (2/2): salvataggio di una riga dell'ordine appena creato
-- (LAST_INSERT_ID() = Codice_Ordine generato dall'INSERT precedente)
INSERT INTO DETTAGLIO_ORDINE (Codice_Ordine, Codice_Viaggio, Destinazione, Prezzo_Acquisto, Data_Partenza, Num_Posti)
VALUES (LAST_INSERT_ID(), 1, 'Barcellona, Spagna', 109.00, '2026-10-15', 2);

-- getOrdiniByUtente: ordini di un cliente
-- (area personale del cliente e ricerca admin "per cliente")
SELECT * FROM ORDINE WHERE Email_Utente = 'f.verdi@gmail.com' ORDER BY Data_Ordine DESC;

-- getOrdiniByPeriodo: ordini in un intervallo di date (ricerca admin "per periodo")
SELECT * FROM ORDINE
WHERE DATE(Data_Ordine) BETWEEN '2026-01-01' AND '2026-12-31'
ORDER BY Data_Ordine DESC;

-- dettagli di uno specifico ordine (righe collegate alla testata)
SELECT * FROM DETTAGLIO_ORDINE WHERE Codice_Ordine = 1;
