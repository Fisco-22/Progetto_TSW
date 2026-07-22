<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio ${viaggio.destinazione} - TravelBooking</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styleViaggio.css">
    <script src="${pageContext.request.contextPath}/scripts/ajaxCarrello.js" defer></script>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking</a>
    <div class="nav-links">
        <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
        <a href="${pageContext.request.contextPath}/CarrelloServlet" class="cart-link"> I miei viaggi <span class="cart-badge" id="cartBadge">${sessionScope.carrello != null ? sessionScope.carrello.numeroElementi : 0}</span></a>
        
        <%-- Controllo se l'oggetto 'utente' esiste nella sessione --%>
        <% if (session.getAttribute("utente") != null) { %>
            <a href="${pageContext.request.contextPath}/AreaPersonaleServlet" style="display: flex; align-items: center;">
                <img src="${pageContext.request.contextPath}/images/iconaUtente.png" alt="Area Personale" style="width: 35px; height: 35px; border-radius: 50%; object-fit: cover; cursor: pointer;">
            </a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/RegistrazioneServlet" class="btn-accedi">Accedi</a>
        <% } %>
        
    </div>
</nav>

<div class="container">

    <div class="gallery-grid">
        <img src="${pageContext.request.contextPath}/${viaggio.immagineUrl}" alt="${viaggio.destinazione}" class="gallery-item item-main">

        <img src="${pageContext.request.contextPath}/images/gallery-piscina.jpg" alt="Piscina Resort" class="gallery-item">
        <img src="${pageContext.request.contextPath}/images/gallery-camera.jpg" alt="Camera da letto" class="gallery-item">
    </div>

    <div class="content-wrapper">
        
        <div class="left-info">
            <div class="title-section">
                <h1>${viaggio.destinazione}</h1>
                <div class="rating">5.0 / 5 Eccellente</div>
                </div>

            <hr style="border: 0; border-top: 1px solid Gainsboro; margin: 30px 0;">

            <div class="description-section">
                <h2>Informazioni su questa struttura</h2>
                <p class="description">
                    ${viaggio.descrizione}
                </p>
            </div>
        </div>

        <div class="right-card">
            <div class="booking-box">
                <p class="price-tag">€ ${viaggio.costoTotale}</p>
                <p class="price-subtext">Prezzo totale per il soggiorno</p>

                <form id="formViaggio" action="${pageContext.request.contextPath}/GestioneOrdiniServlet" method="POST">

                    <input type="hidden" name="codiceViaggio" value="${viaggio.codiceViaggio}">

                    <div class="form-group">
                        <label for="dataPartenza">Data di Partenza</label>
                        <input type="date" id="dataPartenza" name="dataPartenza" required>
                    </div>

                    <div class="form-group">
                        <label for="numPosti">Viaggiatori</label>
                        <select id="numPosti" name="numPosti">
                            <option value="1">1 Persona</option>
                            <option value="2" selected>2 Persone</option>
                            <option value="3">3 Persone</option>
                            <option value="4">4 Persone</option>
                        </select>
                    </div>

                    <%-- Aggiunge al carrello via AJAX: il badge si aggiorna senza reload
                         (se JS e' disattivato, il submit normale funziona comunque) --%>
                    <button type="submit" id="btnCarrello" name="azione" value="carrello" class="btn btn-primary">
                        Aggiungi al carrello
                    </button>

                    <span id="ajaxMsg" style="display:none; margin-top:10px; font-weight:600;"></span>

                    <%-- Acquisto diretto: aggiunge al carrello e va subito al checkout --%>
                    <button type="submit" name="azione" value="acquista" class="btn btn-secondary" style="margin-top: 10px;">
                        Acquista ora
                    </button>

                </form>
            </div>
        </div>

    </div>

</div>

</body>
</html>