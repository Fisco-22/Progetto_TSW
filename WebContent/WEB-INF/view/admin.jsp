<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Section - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/HomeServlet" class="logo">TravelBooking - Admin</a>
        <div class="nav-links">
            <span class="nav-info">Amministratore: <strong><c:out value="${utente.email}"/></strong></span>
            <a href="${pageContext.request.contextPath}/LogoutServlet" style="color: red; font-weight: bold;">Esci (Logout)</a>
        </div>
    </nav>

    <main class="main-content" style="max-width: 1100px; margin: 30px auto; padding: 0 20px;">

        <h1>Gestione catalogo</h1>

        <%-- INSERIMENTO NUOVO VIAGGIO --%>
        <h3>Nuovo viaggio</h3>
        <form action="${pageContext.request.contextPath}/AdminServlet" method="POST" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; margin-bottom: 30px;">
            <input type="text" name="destinazione" placeholder="Destinazione" maxlength="32" required>
            <input type="url" name="immagineUrl" placeholder="URL immagine" maxlength="500" required>
            <textarea name="descrizione" placeholder="Descrizione" rows="2" style="grid-column: 1 / -1;" required></textarea>
            <input type="number" name="costoTotale" placeholder="Costo (€)" step="0.01" min="0" required>
            <input type="number" name="nPosti" placeholder="Posti disponibili" min="0" required>
            
            <button type="submit" name="azione" value="inserisci" class="btn btn-primary" style="grid-column: 1 / -1;">Inserisci nel catalogo</button>
        </form>

        <%-- CATALOGO: MODIFICA / CANCELLAZIONE --%>
        <h3>Catalogo attuale</h3>
        <c:forEach items="${catalogo}" var="v">
            <form action="${pageContext.request.contextPath}/AdminServlet" method="POST"
                  style="display: grid; grid-template-columns: 50px 1fr 1fr 90px 80px auto auto; gap: 8px; align-items: center; border-bottom: 1px solid Gainsboro; padding: 8px 0;">
                <span>#${v.codiceViaggio}</span>
                <input type="hidden" name="codiceViaggio" value="${v.codiceViaggio}">
                <input type="text" name="destinazione" value="<c:out value='${v.destinazione}'/>" maxlength="32" required>
                <input type="url" name="immagineUrl" value="<c:out value='${v.immagineUrl}'/>" maxlength="500" required>
                <input type="number" name="costoTotale" value="${v.costoTotale}" step="0.01" min="0" required>
                <input type="number" name="nPosti" value="${v.nPosti}" min="0" required>
                <textarea name="descrizione" rows="1" style="grid-column: 1 / 6;" required><c:out value="${v.descrizione}"/></textarea>
                
                <button type="submit" name="azione" value="modifica" class="btn btn-secondary">Salva</button>
                <button type="submit" name="azione" value="cancella" class="btn" style="background: Tomato; color: White;"
                        onclick="return confirm('Cancellare il viaggio #${v.codiceViaggio}? Gli ordini passati non verranno toccati.');">Cancella</button>
            </form>
        </c:forEach>
        <c:if test="${empty catalogo}"><p>Nessun viaggio nel catalogo.</p></c:if>

        <hr style="margin: 40px 0; border: 0; border-top: 1px solid Gainsboro;">

        <%-- RICERCA ORDINI --%>
        <h1>Ordini</h1>
        <div style="display: flex; gap: 40px; flex-wrap: wrap; margin-bottom: 20px;">
            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET" style="display: flex; gap: 8px; align-items: center;">
                <input type="hidden" name="azione" value="ordiniPeriodo">
                <label>Dal <input type="date" name="dataInizio" required></label>
                <label>al <input type="date" name="dataFine" required></label>
                
                <button type="submit" class="btn btn-secondary">Cerca per periodo</button>
            </form>
            <form action="${pageContext.request.contextPath}/AdminServlet" method="GET" style="display: flex; gap: 8px; align-items: center;">
                <input type="hidden" name="azione" value="ordiniCliente">
                <input type="email" name="emailCliente" placeholder="email cliente" required>
                
                <button type="submit" class="btn btn-secondary">Cerca per cliente</button>
            </form>
        </div>

        <c:if test="${not empty criterioRicerca}">
            <h3>Risultati (${criterioRicerca})</h3>
            <c:if test="${empty ordiniRicerca}"><p>Nessun ordine trovato.</p></c:if>
            <c:forEach items="${ordiniRicerca}" var="ordine">
                <div class="order-card" style="border: 1px solid Gainsboro; border-radius: 8px; padding: 12px; margin-bottom: 12px;">
                    <h4>Ordine #${ordine.codiceOrdine} &mdash; ${ordine.dataOrdine} &mdash; <c:out value="${ordine.emailUtente}"/></h4>
                    <c:forEach items="${ordine.dettagli}" var="d">
                        <p><c:out value="${d.destinazione}"/> &mdash; partenza <c:out value="${d.dataPartenza}"/>,
                           ${d.numPosti} posti &times; &euro; ${d.prezzoAcquisto}</p>
                    </c:forEach>
                    <p><strong>Totale: &euro; ${ordine.totaleOrdine}</strong> &mdash; <c:out value="${ordine.stato}"/></p>
                </div>
            </c:forEach>
        </c:if>

    </main>

</body>
</html>
