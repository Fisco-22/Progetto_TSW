-- Aggiorna i percorsi immagine dei viaggi gia' presenti nel DB
-- (da eseguire solo se il catalogo e' gia' stato popolato con i vecchi URL Unsplash).
-- Le immagini locali si trovano in WebContent/images/
USE travelbooking_db;

UPDATE VIAGGIO SET Immagine_URL = 'images/Barcellona.jpg' WHERE Codice_Viaggio = 1;
UPDATE VIAGGIO SET Immagine_URL = 'images/Parigi.jpg'     WHERE Codice_Viaggio = 2;
UPDATE VIAGGIO SET Immagine_URL = 'images/Amsterdam.jpg'  WHERE Codice_Viaggio = 3;
UPDATE VIAGGIO SET Immagine_URL = 'images/Roma.jpg'       WHERE Codice_Viaggio = 4;
UPDATE VIAGGIO SET Immagine_URL = 'images/Venezia.jpg'    WHERE Codice_Viaggio = 5;
