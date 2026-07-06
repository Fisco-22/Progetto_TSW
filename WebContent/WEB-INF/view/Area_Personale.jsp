<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Personale - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    
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