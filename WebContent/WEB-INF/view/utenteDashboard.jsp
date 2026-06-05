<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="Model.Utente_Bean" %>
<% 
Utente_Bean connesso = (Utente_Bean) session.getAttribute("user");
if(connesso == null){
	response.sendRedirect("index.html");
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TravelBooking - Area Personale</title>
<link rel="stylesheet" href="style.css">
</head>
<body style="background-color : #f4f6f9;">
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
</body>
</html>