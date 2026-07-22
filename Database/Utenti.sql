USE travelbooking_db;
SELECT * FROM UTENTE;

SELECT Numero_Telefono FROM TELEFONO_UTENTE WHERE Email_Utente = 'francescopagliuchi47@gmail.com';

SELECT * FROM UTENTE
WHERE Email = 'p.rossi@gmail.com' AND Password = SHA2('Paolo321', 512);
