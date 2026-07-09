<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettaglio ${viaggio.destinazione} - TravelBooking</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/styleViaggio.css">
</head>
<body>

<div class="container">

    <div class="gallery-grid">
        <img src="${viaggio.immagineUrl}" alt="${viaggio.destinazione}" class="gallery-item item-main">
        
        <img src="https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Piscina Resort" class="gallery-item">
        <img src="https://images.unsplash.com/photo-1582719478250-c89afe4dc84b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Camera da letto" class="gallery-item">
    </div>

    <div class="content-wrapper">
        
        <div class="left-info">
            <div class="title-section">
                <h1>${viaggio.destinazione}</h1>
                <div class="rating">5.0 / 5 Eccellente</div>
                </div>

            <hr style="border: 0; border-top: 1px solid #e0e0e0; margin: 30px 0;">

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

                <form action="${pageContext.request.contextPath}/GestioneOrdiniServlet" method="POST">
                    
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

                    <button type="submit" name="azione" value="prenota" class="btn btn-primary">
                        Prenota ora
                    </button>
                    
                    <button type="submit" name="azione" value="carrello" class="btn btn-secondary">
                        Aggiungi al carrello
                    </button>
                    
                </form>
            </div>
        </div>

    </div>

</div>

</body>
</html>