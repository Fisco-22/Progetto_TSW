// ==========================================================================
// AJAX: aggiunta al carrello senza ricaricare la pagina.
// Il pulsante "Aggiungi al carrello" invia i dati in background al
// GestioneOrdiniServlet, che risponde con { "numeroElementi": N }.
// Aggiorniamo poi il badge del carrello modificando il DOM.
// ==========================================================================
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formViaggio");
    const btnCarrello = document.getElementById("btnCarrello");
    const badge = document.getElementById("cartBadge");
    const msg = document.getElementById("ajaxMsg");

    // Se manca qualcosa (es. JS su un'altra pagina) non facciamo nulla:
    // il form resta funzionante col submit tradizionale (fallback no-JS).
    if (!form || !btnCarrello) return;

    btnCarrello.addEventListener("click", function (event) {
        // I dati partono solo se il form e' valido (la data di partenza e' required).
        // reportValidity() mostra anche i messaggi nativi del browser.
        if (!form.reportValidity()) {
            event.preventDefault();
            return;
        }

        // Blocchiamo il submit tradizionale: gestiamo tutto via fetch.
        event.preventDefault();

        const dati = new URLSearchParams();
        dati.append("azione", "carrello");
        dati.append("codiceViaggio", form.codiceViaggio.value);
        dati.append("dataPartenza", form.dataPartenza.value);
        dati.append("numPosti", form.numPosti.value);

        fetch(form.action, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: dati.toString()
        })
            .then(function (risposta) {
                if (!risposta.ok) throw new Error("Risposta non valida");
                return risposta.json();
            })
            .then(function (dati) {
                // Aggiorna il badge del carrello (modifica del DOM, niente reload)
                if (badge) badge.textContent = dati.numeroElementi;
                if (msg) {
                    msg.textContent = "Viaggio aggiunto al carrello!";
                    msg.style.color = "SeaGreen";
                    msg.style.display = "block";
                }
            })
            .catch(function () {
                if (msg) {
                    msg.textContent = "Si e' verificato un errore, riprova.";
                    msg.style.color = "Tomato";
                    msg.style.display = "block";
                }
            });
    });
});
