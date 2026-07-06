<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Personale - TravelBooking</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .profile-container {
            max-width: 900px;
            margin: 50px auto;
            display: flex;
            gap: 30px;
        }
        .profile-card {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            height: fit-content;
        }
        .orders-section {
            flex: 2;
        }
        .order-card {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            border-left: 5px solid #0b5cff;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.html" class="logo">TravelBooking</a>
        <div class="nav-links">
            <a href="LogoutServlet" style="color: red; font-weight: bold;">Esci (Logout)</a>
        </div>
    </nav>

    <div class="profile-container">
        
        <div class="profile-card">
            <h3>I tuoi dati</h3>
            <hr style="border: 0; border-top: 1px solid #eee; margin: 15px 0;">
            <p><strong>Nome:</strong> ${utente.nome}</p>
            <p><strong>Cognome:</strong> ${utente.cognome}</p>
            <p><strong>Email:</strong> ${utente.email}</p>
        </div>

        <div class="orders-section">
            <h2>Bentornato, ${utente.nome}! 👋</h2>
            <p>Ecco il riepilogo delle tue prenotazioni e dei viaggi nel carrello.</p>

            <div class="order-card">
                <h4>Prenotazione #10024</h4>
                <p><strong>Destinazione:</strong> Parigi, Francia</p>
                <p><strong>Data Partenza:</strong> 15 Ottobre 2026</p>
                <p><strong>Status:</strong> <span style="color: green; font-weight: bold;">Confermato</span></p>
            </div>
            
        </div>
    </div>

</body>
</html>