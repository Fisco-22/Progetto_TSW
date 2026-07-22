<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>TravelBooking - Piattaforma di Prenotazione Viaggi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
            
            <a href="${pageContext.request.contextPath}/CarrelloServlet" class="cart-link"> I miei viaggi
                <span class="cart-badge">${sessionScope.carrello != null ? sessionScope.carrello.numeroElementi : 0}</span>
            </a>
            

            <%-- Controllo Accesso --%>
            <% if (session.getAttribute("utente") != null) { %>
                <a href="${pageContext.request.contextPath}/AreaPersonaleServlet" style="display: flex; align-items: center;">
                    <img src="${pageContext.request.contextPath}/images/iconaUtente.png" alt="Area Personale" style="width: 35px; height: 35px; border-radius: 50%; object-fit: cover; cursor: pointer;">
                </a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/RegistrazioneServlet" class="btn-accedi">Accedi</a>
            <% } %>
        </div>
    </nav>

    <header class="hero">
        <h1>Personalizza il tuo viaggio perfetto</h1>
        <p>Trova le migliori combinazioni esclusive per Voli, Hotel e Alloggi</p>
    </header>

    <main class="main-content">
        <section class="catalog-section">
            <div class="section-header">
                <h2>Esplora i Nostri Pacchetti</h2>
                <p>Tutte le nostre migliori offerte disponibili</p>
            </div>
            
            <div class="cards-grid">
                
                <%-- INIZIO CICLO DINAMICO: Crea una card per ogni viaggio nel database --%>
                <c:forEach items="${listaViaggi}" var="viaggio">
                
                    <a href="${pageContext.request.contextPath}/DettaglioServlet?id=${viaggio.codiceViaggio}" style="text-decoration: none; color: inherit;"> 
                        <div class="travel-card">
                            <div class="card-image-wrap">
                                <!-- L'immagine (percorso relativo, es. images/viaggio1.jpg) viene presa dal DB -->
                                <img src="${pageContext.request.contextPath}/${viaggio.immagineUrl}" alt="${viaggio.destinazione}">
                                <span class="badge-combo">Volo + Hotel</span>
                            </div>
                            <div class="card-body">
                                <span class="card-location"><img src="${pageContext.request.contextPath}/images/punto_rosso.png" alt="" style="height:1.1em; width:auto; vertical-align:-0.15em;"> ${viaggio.destinazione}</span>
                                <h3>Offerta Esclusiva</h3>
                                <p class="card-tagline">${viaggio.descrizione}</p>
                                
                                <div class="card-footer-price">
                                    <span class="price-label">da</span>
                                    <span class="price-amount">${viaggio.costoTotale} €</span>
                                    <span class="price-unit">/ persona</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    
                </c:forEach>
                <%-- FINE CICLO --%>
                
                <c:if test="${empty listaViaggi}">
                    <p style="text-align: center; grid-column: 1 / -1;">Nessun viaggio disponibile al momento.</p>
                </c:if>

            </div>
        </section>
    </main>

</body>
</html>