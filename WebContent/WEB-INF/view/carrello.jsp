<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il tuo carrello - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="${pageContext.request.contextPath}/AreaPersonaleServlet">Area Personale</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/RegistrazioneServlet" class="btn-accedi">Accedi</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <main class="main-content" style="max-width: 900px; margin: 40px auto; padding: 0 20px;">
        <h1>Il tuo carrello</h1>

        <c:choose>
            <c:when test="${empty sessionScope.carrello or sessionScope.carrello.numeroElementi == 0}">
                <p>Il carrello è vuoto.</p>
                <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-primary" style="display: inline-block; margin-top: 15px;">Esplora i pacchetti</a>
            </c:when>
            <c:otherwise>
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid Gainsboro;">
                            <th style="padding: 10px;">Destinazione</th>
                            <th style="padding: 10px;">Data partenza</th>
                            <th style="padding: 10px;">Posti</th>
                            <th style="padding: 10px;">Prezzo unitario</th>
                            <th style="padding: 10px;">Totale</th>
                            <th style="padding: 10px;">Azioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.carrello.elementi}" var="elemento">
                            <tr style="border-bottom: 1px solid WhiteSmoke;">
                                <td style="padding: 10px;"><c:out value="${elemento.viaggio.destinazione}"/></td>
                                <td style="padding: 10px;"><c:out value="${elemento.dataPartenza}"/></td>
                                <td style="padding: 10px;">${elemento.numPosti}</td>
                                <td style="padding: 10px;">&euro; ${elemento.viaggio.costoTotale}</td>
                                <td style="padding: 10px;">&euro; ${elemento.prezzoTotale}</td>
                                <td style="padding: 10px;">
                                    <form action="${pageContext.request.contextPath}/GestioneOrdiniServlet" method="POST" style="display: flex; gap: 6px; align-items: center;">
                                        <input type="hidden" name="codiceViaggio" value="${elemento.viaggio.codiceViaggio}">
                                        <input type="hidden" name="dataPartenza" value="${elemento.dataPartenza}">
                                        <input type="number" name="numPosti" value="${elemento.numPosti}" min="1" max="10" style="width: 60px;">
                                        <button type="submit" name="azione" value="aggiorna" class="btn btn-secondary">Aggiorna</button>
                                        <button type="submit" name="azione" value="rimuovi" class="btn" style="background: Tomato; color: White;">Rimuovi</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <p style="text-align: right; font-size: 20px; margin-top: 20px;">
                    <strong>Totale carrello: &euro; ${sessionScope.carrello.costoTotale}</strong>
                </p>

                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 25px;">
                    <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-secondary">Continua a esplorare</a>
                    <form action="${pageContext.request.contextPath}/GestioneOrdiniServlet" method="POST" style="display: inline;">
                        <button type="submit" name="azione" value="svuota" class="btn" style="background: Tomato; color: White;">Svuota carrello</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/CheckoutServlet" class="btn btn-primary">Procedi al checkout</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>
