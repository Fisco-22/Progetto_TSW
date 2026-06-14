<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.*" %>
<%
    Utente_Bean utente = (Utente_Bean) request.getAttribute("registeredUser");
    if (utente == null) {
        // Usa il ContextPath per sicurezza: rimanda alla radice reale dell'applicazione
        response.sendRedirect(request.getContextPath() + "/index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Benvenuto in TravelBooking</title>
    <link rel="stylesheet" href="style.css">
</head>
<body style="background-color: #f4f6f9; margin: 0; font-family: sans-serif;">
    <div class="container-successo" style="display: flex; justify-content: center; align-items: center; min-height: 100vh;">
        <div class="card-successo" style="background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); text-align: center; max-width: 500px;">
            <h2 style="color: #00aa6c; margin-top: 0;">🎉 Registrazione Completata!</h2>
            <p class="p-intro">Grazie per esserti registrato, <strong><%= utente.getNome() %> <%= utente.getCognome() %></strong>.</p>
            
            <div class="info-riepilogo" style="background: #f8fafc; padding: 20px; border-radius: 8px; margin: 25px 0; text-align: left; border: 1px solid #e2e8f0;">
                <p style="margin: 5px 0;">📧 La tua email: <strong><%= utente.getEmail() %></strong></p>
                <p style="margin: 5px 0;">📍 Indirizzo registrato: <strong><%= utente.getIndirizzo() %></strong></p>
                <p style="margin: 15px 0 0 0; font-size: 13px; color: #64748b;">Profilo abilitato per la gestione dello storico viaggi ed il rilascio di feedback social.</p>
            </div>
            
            <a href="index.html" class="btn-home" style="display: inline-block; background: #004f32; color: white; padding: 12px 30px; text-decoration: none; border-radius: 50px; font-weight: bold;">Torna alla Home ed Effettua il Login</a>
        </div>
    </div>
</body>
</html>