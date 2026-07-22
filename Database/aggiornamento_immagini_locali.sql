-- Aggiorna i percorsi immagine dei viaggi gia' presenti nel DB
-- (da eseguire solo se il catalogo e' gia' stato popolato con i vecchi URL Unsplash).
-- Le immagini locali si trovano in WebContent/images/
USE travelbooking_db;

UPDATE VIAGGIO SET Immagine_URL = 'images/viaggio1.jpg' WHERE Codice_Viaggio = 1;
UPDATE VIAGGIO SET Immagine_URL = 'images/viaggio2.jpg' WHERE Codice_Viaggio = 2;
UPDATE VIAGGIO SET Immagine_URL = 'images/viaggio3.jpg' WHERE Codice_Viaggio = 3;
UPDATE VIAGGIO SET Immagine_URL = 'images/viaggio4.jpg' WHERE Codice_Viaggio = 4;
UPDATE VIAGGIO SET Immagine_URL = 'images/viaggio5.jpg' WHERE Codice_Viaggio = 5;
