<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Utente_Bean" %>
<% 
    Utente_Bean connesso = (Utente_Bean) session.getAttribute("user");
    if(connesso == null){
        // CORRETTO: Reindirizzamento pulito alla radice dell'applicazione
        response.sendRedirect(request.getContextPath() + "/index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>TravelBooking - Area Personale</title>
    <link rel="stylesheet" href="style.css">
</head>
<body style="background-color: #f4f6f9; margin: 0; font-family: sans-serif;">
    <nav class="navbar">
        <a href="index.html" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
            <a href="#">Recensioni</a>
            <a href="#" class="cart-link"> I miei viaggi <span class="cart-badge">0</span></a>
            <a href="index.html" class="logout" style="margin-left: 20px;">Scollegati</a>
        </div>
    </nav>
    
    <div class="container_dashboard" style="max-width: 1200px; margin: 40px auto; padding: 0 20px;">
        <div class="header-dash" style="margin-bottom: 30px;">
            <h1>Bentornato, <%= connesso.getNome() %>!</h1>
            <p style="color: #64748b;">Pannello di controllo Utente Registrato</p>
        </div>
        
        <div class="grid-features">
            <div class="card-feature">
                <h3>I miei Viaggi</h3>
                <p>Hai attualmente 0 biglietti pronti per il pagamento elettronico.</p>
                <a href="index.html" class="btn-action">Trova Biglietti</a>
            </div>
            
            <div class="card-feature">
                <h3>Recensioni</h3>
                <p>Lascia una recensione sui luoghi dove sei andato.</p>
            </div>
            
            <div class="card-feature">
                <h3>👤 Dati Anagrafici del Profilo</h3>
                <p><strong>Email:</strong> <%= connesso.getEmail() %></p>
                <p style="color: #00aa6c; font-size: 13px; font-weight: bold; margin-top: 15px;">Account verificato per le opzioni assicurative dirette.</p>
            </div>
        </div>
    </div>
</body>
</html>