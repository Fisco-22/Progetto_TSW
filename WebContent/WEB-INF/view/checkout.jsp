<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong class="phone-placeholder">+39 089 1234567</strong></span>
        </div>
    </nav>

    <main class="main-content" style="max-width: 700px; margin: 40px auto; padding: 0 20px;">
        <h1>Conferma ordine</h1>

        <c:if test="${not empty messaggioErrore}">
            <p style="color: Tomato; font-weight: bold;"><c:out value="${messaggioErrore}"/></p>
        </c:if>

        <%-- Riepilogo carrello --%>
        <table style="width: 100%; border-collapse: collapse; margin: 20px 0;">
            <thead>
                <tr style="text-align: left; border-bottom: 2px solid Gainsboro;">
                    <th style="padding: 8px;">Destinazione</th>
                    <th style="padding: 8px;">Partenza</th>
                    <th style="padding: 8px;">Posti</th>
                    <th style="padding: 8px;">Subtotale</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${sessionScope.carrello.elementi}" var="elemento">
                    <tr style="border-bottom: 1px solid WhiteSmoke;">
                        <td style="padding: 8px;"><c:out value="${elemento.viaggio.destinazione}"/></td>
                        <td style="padding: 8px;"><c:out value="${elemento.dataPartenza}"/></td>
                        <td style="padding: 8px;">${elemento.numPosti}</td>
                        <td style="padding: 8px;">&euro; ${elemento.prezzoTotale}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <p style="text-align: right; font-size: 18px;"><strong>Totale: &euro; ${sessionScope.carrello.costoTotale}</strong></p>

        <%-- Dati spedizione e pagamento --%>
        <form id="formCheckout" action="${pageContext.request.contextPath}/CheckoutServlet" method="POST">

            <div class="form-group">
                <label for="indirizzoSpedizione">Indirizzo di spedizione/fatturazione</label>
                <input type="text" id="indirizzoSpedizione" name="indirizzoSpedizione"
                       value="<c:out value='${sessionScope.utente.indirizzo}'/>" required>
                <span id="errorIndirizzoSpedizione"></span>
            </div>

            <div class="form-group">
                <label for="metodoPagamento">Metodo di pagamento</label>
                <select id="metodoPagamento" name="metodoPagamento">
                    <option value="Carta di credito" selected>Carta di credito</option>
                    <option value="Carta prepagata">Carta prepagata</option>
                </select>
            </div>

            <div class="form-group">
                <label for="numeroCarta">Numero carta</label>
                <input type="text" id="numeroCarta" name="numeroCarta" maxlength="19"
                       placeholder="1234 5678 9012 3456" required>
                <span id="errorNumeroCarta"></span>
            </div>

            <button type="submit" class="btn btn-primary" style="margin-top: 15px;">Conferma ordine</button>
        </form>
    </main>

</body>
</html>
