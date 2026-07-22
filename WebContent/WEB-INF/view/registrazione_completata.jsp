<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%
    Utente_Bean utente = (Utente_Bean) request.getAttribute("registeredUser");
    if (utente == null) {
        // Usa il ContextPath per sicurezza: rimanda alla radice reale dell'applicazione
        response.sendRedirect(request.getContextPath() + "/HomeServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Benvenuto in TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body style="background-color: White; margin: 0; font-family: sans-serif;">
    <div class="container-successo" style="display: flex; justify-content: center; align-items: center; min-height: 100vh;">
        <div class="card-successo" style="background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); text-align: center; max-width: 500px;">
            <h2 style="color: Salmon; margin-top: 0;"><img src="${pageContext.request.contextPath}/images/coriandoli.png" alt="" style="height:1.1em; width:auto; vertical-align:-0.15em;"> Registrazione Completata!</h2>
            <p class="p-intro">Grazie per esserti registrato, <strong><%= utente.getNome() %> <%= utente.getCognome() %></strong>.</p>
            
            <div class="info-riepilogo" style="background: White; padding: 20px; border-radius: 8px; margin: 25px 0; text-align: left; border: 1px solid White;">
                <p style="margin: 5px 0;"><img src="${pageContext.request.contextPath}/images/messaggio.png" alt="" style="height:1.1em; width:auto; vertical-align:-0.15em;"> La tua email: <strong><%= utente.getEmail() %></strong></p>
                <p style="margin: 5px 0;"><img src="${pageContext.request.contextPath}/images/punto_rosso.png" alt="" style="height:1.1em; width:auto; vertical-align:-0.15em;"> Indirizzo registrato: <strong><%= utente.getIndirizzo() %></strong></p>
                <p style="margin: 15px 0 0 0; font-size: 13px; color: Teal;">Profilo abilitato per la gestione dello storico viaggi ed il rilascio di feedback social.</p>
            </div>
            
            <a href="${pageContext.request.contextPath}/RegistrazioneServlet" class="btn-home" style="display: inline-block; background: DarkGreen; color: white; padding: 12px 30px; text-decoration: none; border-radius: 50px; font-weight: bold;">Torna alla Home ed Effettua il Login</a>
        </div>
    </div>
</body>
</html>