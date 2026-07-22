document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formViaggio");
    const btnCarrello = document.getElementById("btnCarrello");
    const badge = document.getElementById("cartBadge");
    const msg = document.getElementById("ajaxMsg");

    if (!form || !btnCarrello) return;

    btnCarrello.addEventListener("click", function (event) {
        if (!form.reportValidity()) {
            event.preventDefault();
            return;
        }

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
