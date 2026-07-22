-- 1. Crea ed entra nel database
CREATE DATABASE IF NOT EXISTS travelbooking_db;
USE travelbooking_db;

-- 2. Ripulitura (prima i figli, poi i padri)
DROP TABLE IF EXISTS DETTAGLIO_ORDINE, ORDINE, PRENOTARE, PERNOTTAMENTO,
                     RITORNO, ANDATA, HOTEL, VOLO, TELEFONO_UTENTE, VIAGGIO, UTENTE;

-- 3. Creazione tabelle
CREATE TABLE UTENTE (
    Email VARCHAR(128) PRIMARY KEY,
    Nome VARCHAR(32) NOT NULL,
    Cognome VARCHAR(32) NOT NULL,
    Password CHAR(128) NOT NULL, -- hash SHA-512 in esadecimale (128 caratteri)
    Ruolo ENUM('utente', 'admin') DEFAULT 'utente',
    Data_Nascita DATE,
    Indirizzo VARCHAR(128)
);

CREATE TABLE TELEFONO_UTENTE (
    Email_Utente VARCHAR(128) NOT NULL,
    Numero_Telefono VARCHAR(15) NOT NULL,
    PRIMARY KEY(Email_Utente, Numero_Telefono),
    FOREIGN KEY(Email_Utente) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VIAGGIO (
    Codice_Viaggio INT PRIMARY KEY AUTO_INCREMENT,
    Destinazione VARCHAR(32) NOT NULL,
    Descrizione TEXT,
    Immagine_URL VARCHAR(500),
    Costo_Totale DECIMAL(10,2) DEFAULT 0.00 CHECK(Costo_Totale >= 0),
    n_posti SMALLINT DEFAULT 0 CHECK(n_posti >= 0),
    Email_Admin VARCHAR(128) NOT NULL,
    -- RESTRICT: cancellare un admin non deve spazzare via il catalogo
    FOREIGN KEY(Email_Admin) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE VOLO (
    Codice_Volo VARCHAR(10) PRIMARY KEY,
    Compagnia VARCHAR(32),
    Posti_Totali SMALLINT CHECK(Posti_Totali >= 0),
    Data_Partenza DATETIME,
    Data_Arrivo DATETIME,
    Prezzo DECIMAL(10,2) CHECK(Prezzo >= 0)
);

CREATE TABLE HOTEL (
    Codice_Hotel INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(32) NOT NULL,
    Indirizzo VARCHAR(64),
    Costo_Notte DECIMAL(10,2) CHECK(Costo_Notte >= 0)
);

CREATE TABLE ANDATA (
    Codice_Volo VARCHAR(10) NOT NULL,
    Codice_Viaggio INT NOT NULL,
    PRIMARY KEY(Codice_Volo, Codice_Viaggio),
    FOREIGN KEY(Codice_Volo) REFERENCES VOLO(Codice_Volo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RITORNO (
    Codice_Volo VARCHAR(10) NOT NULL,
    Codice_Viaggio INT NOT NULL,
    PRIMARY KEY(Codice_Volo, Codice_Viaggio),
    FOREIGN KEY(Codice_Volo) REFERENCES VOLO(Codice_Volo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PERNOTTAMENTO (
    Codice_Viaggio INT NOT NULL,
    Codice_Hotel INT NOT NULL,
    Data_Arrivo DATE,
    Durata_Permanenza SMALLINT CHECK(Durata_Permanenza >= 0),
    PRIMARY KEY(Codice_Viaggio, Codice_Hotel),
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Hotel) REFERENCES HOTEL(Codice_Hotel) ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- NUOVO: gestione ordini (sostituisce PRENOTARE)
-- ============================================================

CREATE TABLE ORDINE (
    Codice_Ordine INT PRIMARY KEY AUTO_INCREMENT,
    Email_Utente VARCHAR(128) NOT NULL,
    Data_Ordine DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Totale_Ordine DECIMAL(10,2) NOT NULL CHECK(Totale_Ordine >= 0),
    -- Dati di spedizione/fatturazione richiesti al checkout
    Indirizzo_Spedizione VARCHAR(128) NOT NULL,
    -- Pagamento: MAI la carta completa! Solo metodo e ultime 4 cifre
    Metodo_Pagamento VARCHAR(32) NOT NULL,
    Ultime4Cifre CHAR(4),
    Stato VARCHAR(32) NOT NULL DEFAULT 'Confermato',
    -- RESTRICT: un utente con ordini non può essere cancellato (lo storico resta)
    FOREIGN KEY(Email_Utente) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE DETTAGLIO_ORDINE (
    ID_Dettaglio INT PRIMARY KEY AUTO_INCREMENT,
    Codice_Ordine INT NOT NULL,
    -- FK "debole": se l'admin cancella il viaggio, qui diventa NULL
    -- ma la riga d'ordine resta con i dati copiati sotto
    Codice_Viaggio INT NULL,
    -- SNAPSHOT al momento dell'acquisto:
    Destinazione VARCHAR(32) NOT NULL,
    Prezzo_Acquisto DECIMAL(10,2) NOT NULL CHECK(Prezzo_Acquisto >= 0),
    Data_Partenza DATE NOT NULL,
    Num_Posti SMALLINT NOT NULL CHECK(Num_Posti > 0),
    FOREIGN KEY(Codice_Ordine) REFERENCES ORDINE(Codice_Ordine) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE SET NULL
);