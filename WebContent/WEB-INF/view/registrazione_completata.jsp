<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.*" %>
<%
    Utente_Bean utente = (Utente_Bean) request.getAttribute("registeredUser");
    if (utente == null) {
        response.sendRedirect("WebContent/index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Benvenuto in TravelBooking</title>
<link rel="stylesheet" href="WebContent/style.css">
</head>
<body style="background-color: #f4f6f9; margin: 0;">
	<div class="container-successo">
		<div class="card-successo">
			<h2>Registrazione Completata!</h2>
			<p class="p-intro">Grazie per esserti registrato, <strong><%= utente.getNome() %> <%= utente.getCognome() %></strong>.
			
			<div class="info-riepilogo">
				<p>La tua email: <strong><%= utente.getEmail() %></strong>.</p>
                <p>Indirizzo registrato: <strong><%= utente.getIndirizzo() %></strong></p>
                <p>Profilo abilitato per la gestione dello storico viaggi ed il rilascio di feedback social.</p>
            </div>
            
            <a href="WebContent/index.html" class="btn-home">Torna alla Home ed Effettua il Login</a>
		</div>
	</div>
</body>
</html>