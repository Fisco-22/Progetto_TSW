-- 1. Crea ed entra nel database
CREATE DATABASE IF NOT EXISTS travelbooking_db;
USE travelbooking_db;

-- 2. Ripulitura (Prima i figli, poi i padri)
DROP TABLE IF EXISTS RECENSIONE, PRENOTARE, PERNOTTAMENTO, RITORNO, ANDATA, HOTEL, VOLO, VIAGGIO, UTENTE;

-- 3. Creazione Tabelle
CREATE TABLE UTENTE (
    Email VARCHAR(128) PRIMARY KEY,
    Nome VARCHAR(32) NOT NULL,
    Cognome VARCHAR(32) NOT NULL,
    Password CHAR(64) NOT NULL,
    Ruolo ENUM('utente', 'admin') DEFAULT 'utente',
    Data_Nascita DATE,
    Indirizzo VARCHAR(128)
);

CREATE TABLE VIAGGIO (
    Codice_Viaggio INT PRIMARY KEY AUTO_INCREMENT,
    Destinazione VARCHAR(32) NOT NULL,
    Descrizione TEXT,
    Immagine_URL VARCHAR(500),
    Costo_Totale FLOAT DEFAULT 0.0 CHECK(Costo_Totale >= 0),
    n_posti SMALLINT DEFAULT 0 CHECK(n_posti >= 0),
    Email_Admin VARCHAR(128) NOT NULL,
    FOREIGN KEY(Email_Admin) REFERENCES UTENTE(Email) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE VOLO (
    Codice_Volo VARCHAR(10) PRIMARY KEY,
    Compagnia VARCHAR(32),
    Posti_Totali SMALLINT CHECK(Posti_Totali >= 0),
    Data_Partenza DATETIME,
    Data_Arrivo DATETIME,
    Prezzo FLOAT CHECK(Prezzo >= 0)
);

CREATE TABLE HOTEL (
    Codice_Hotel INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(32) NOT NULL,
    Indirizzo VARCHAR(64),
    Costo_Notte FLOAT CHECK(Costo_Notte >= 0)
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

CREATE TABLE PRENOTARE (
    Email_Utente VARCHAR(128) NOT NULL,
    Codice_Viaggio INT NOT NULL,
    Stato_Pagamento VARCHAR(32) DEFAULT 'In sospeso',
    Data_Prenotazione DATE,
    PRIMARY KEY(Email_Utente, Codice_Viaggio),
    FOREIGN KEY(Email_Utente) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RECENSIONE (
    Codice_Recensione INT PRIMARY KEY AUTO_INCREMENT,
    Voto SMALLINT NOT NULL CHECK(Voto >= 1 AND Voto <= 5),
    Commento TEXT,
    Data_Recensione DATE,
    Email_Utente VARCHAR(128) NOT NULL,
    Codice_Viaggio INT NOT NULL,
    FOREIGN KEY(Email_Utente) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Codice_Viaggio) REFERENCES VIAGGIO(Codice_Viaggio) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TELEFONO_UTENTE (
    Email_Utente VARCHAR(128) NOT NULL,
    Numero_Telefono VARCHAR(15) NOT NULL,
    PRIMARY KEY(Email_Utente, Numero_Telefono),
    FOREIGN KEY(Email_Utente) REFERENCES UTENTE(Email) ON UPDATE CASCADE ON DELETE CASCADE
);