<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="Model.Utente_Bean" %>
<% 
Utente_Bean connesso = (Utente_Bean) session.getAttribute("user");
if(connesso == null){
	response.sendRedirect("WebContent/index.html");
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TravelBooking - Area Personale</title>
<link rel="stylesheet" href="WebContent/style.css">
</head>
<body style="background-color : #f4f6f9;">
	<!-- NAVBAR -->
    <nav class="navbar">
        <a href="index.html" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
            <a href="#">Recensioni</a>
            <a href="#" class="cart-link"> I miei viaggi <span class="cart-badge">0</span>
            </a>
            <a href="index.html" class="logout" style="margin-left: 20px;">Scollegati</a>
        </div>
    </nav>
    <!-- DASHBOARD -->
    <div class="container_dashboard">
    	<div class="header-dash">
    		<h1>Bentornato, <%= connesso.getNome() %>!</h1>
            <p>Pannello di controllo Utente Registrato</p>
    	</div>
    	
    	<div class="grid-features">
    		<div class="card-feature">
    			<h3>I miei Viaggi</h3>
    			<p>Hai attualmente 0 biglietti pronti per il pagamento elettronico.
    			<a href="index.html" class="btn-action">Trova Biglietti</a>
    		</div>
    		
    		<div class="grid-features">
    			<h3>Recensioni</h3>
    			<p>Lascia una recensione sui luoghi dove sei andato.
    		</div>
    		
    		<div class="card-feature">
                <h3>👤 Dati Anagrafici del Profilo</h3>
                <p><strong>Email:</strong> <%= connesso.getEmail() %></p>
                <p><strong>Account verificato per le opzioni assicurative dirette.</strong></p>
            </div>
    	</div>
    </div>
</body>
</html>