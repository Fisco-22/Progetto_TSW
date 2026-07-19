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
            <p>Ecco l'elenco degli ordini che hai effettuato.</p>

            <c:choose>
                <c:when test="${empty ordini}">
                    <p>Non hai ancora effettuato ordini.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${ordini}" var="ordine">
                        <div class="order-card">
                            <h4>Ordine #${ordine.codiceOrdine} &mdash; ${ordine.dataOrdine}</h4>
                            <c:forEach items="${ordine.dettagli}" var="d">
                                <p><c:out value="${d.destinazione}"/> &mdash; partenza <c:out value="${d.dataPartenza}"/>,
                                   ${d.numPosti} posti &times; &euro; ${d.prezzoAcquisto}</p>
                            </c:forEach>
                            <p><strong>Totale: &euro; ${ordine.totaleOrdine}</strong> &mdash;
                               <c:out value="${ordine.metodoPagamento}"/>
                               <c:if test="${not empty ordine.ultime4Cifre}"> (**** ${ordine.ultime4Cifre})</c:if></p>
                            <p><strong>Stato:</strong> <span style="color: green; font-weight: bold;"><c:out value="${ordine.stato}"/></span></p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</body>
</html>