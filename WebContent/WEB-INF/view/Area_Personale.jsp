<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Utente_Bean" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<% 
    Utente_Bean connesso = (Utente_Bean) session.getAttribute("utente");
    if(connesso == null){
        response.sendRedirect(request.getContextPath() + "/HomeServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Area Personale - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking</a>
        <div class="nav-links">
        <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="color: red; font-weight: bold;">Esci (Logout)</a>
        </div>
    </nav>

    <div class="profile-container">
        
        <div class="profile-card">
    		<h3>I tuoi dati</h3>
    		<hr style="border: 0; border-top: 1px solid White; margin: 15px 0;">
    		<p><strong>Nome:</strong> <c:out value="${utente.nome}" /></p>
    		<p><strong>Cognome:</strong> <c:out value="${utente.cognome}" /></p>
    		<p><strong>Email:</strong> <c:out value="${utente.email}" /></p>
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