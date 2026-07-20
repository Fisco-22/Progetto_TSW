// ==========================================================================
// 1. VARIABILI GLOBALI, REGEX E MESSAGGI DI ERRORE
// ==========================================================================
let phoneCount = 1;

// Regex riutilizzabili (requisito: usare le espressioni regolari)
const nomeRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s']+$/;          // lettere, anche accentate, spazi, apostrofo
const cartaRegex = /^\d{4}\s?\d{4}\s?\d{4}\s?\d{4}$/;  // 16 cifre, spazi opzionali ogni 4

const nameOrLastnameErrorMessage = "Questo campo deve contenere solo lettere.";
const emailErrorMessage = "Inserisci un'email valida (es. utente@dominio.it).";
const phoneErrorMessage = "Il formato deve essere ###-#######.";
const emptyFieldErrorMessage = "Questo campo non può essere vuoto.";
const passwordErrorMessage = "La password deve avere almeno 8 caratteri, con lettere e numeri.";
const cartaErrorMessage = "Inserisci un numero di carta valido (16 cifre).";
const dataFuturaErrorMessage = "La data di nascita non può essere nel futuro.";

// ==========================================================================
// 2. FUNZIONE DI VALIDAZIONE VISIVA (modifica il DOM, niente alert)
// ==========================================================================
function validateFormElem(formElem, span, errorMessage) {
    if (!formElem || !span) return true;

    if (formElem.checkValidity()) {
        formElem.style.borderColor = "LightGray";
        span.innerHTML = "";
        return true;
    }

    formElem.style.borderColor = "Tomato";
    span.style.color = "Tomato";
    span.style.fontSize = "13px";
    span.style.fontWeight = "500";
    span.style.display = "block";
    span.style.marginTop = "4px";

    if (formElem.validity.valueMissing) {
        span.innerHTML = emptyFieldErrorMessage;
    } else {
        span.innerHTML = errorMessage;
    }
    return false;
}

// Variante per controlli custom (es. data nel futuro) non coperti da checkValidity
function mostraErrore(formElem, span, messaggio) {
    formElem.style.borderColor = "Tomato";
    span.style.color = "Tomato";
    span.style.fontSize = "13px";
    span.style.display = "block";
    span.style.marginTop = "4px";
    span.innerHTML = messaggio;
}

// Collega la validazione di un campo sia all'evento change che a input
function attachValidation(inputId, spanId, errorMessage) {
    const input = document.getElementById(inputId);
    const span = document.getElementById(spanId);
    if (!input || !span) return;
    // Requisito della traccia: errore quando l'utente termina l'inserimento (change)
    input.addEventListener("change", () => validateFormElem(input, span, errorMessage));
    // In più: feedback anche mentre scrive
    input.addEventListener("input", () => validateFormElem(input, span, errorMessage));
}

// ==========================================================================
// 3. COLLEGAMENTO EVENTI AL CARICAMENTO DELLA PAGINA
// ==========================================================================
document.addEventListener("DOMContentLoaded", () => {

    // ---------- LOGIN ----------
    const formLogin = document.getElementById("formLogin");
    const loginGeneralError = document.getElementById("loginGeneralError");
    const inputEmail = document.getElementById("login-email");
    const inputPassword = document.getElementById("login-password");
    const spanEmail = document.getElementById("errorEmailLogin");
    const spanPassword = document.getElementById("errorPasswordLogin");

    if (formLogin && inputEmail && inputPassword) {
        attachValidation("login-email", "errorEmailLogin", emailErrorMessage);
        attachValidation("login-password", "errorPasswordLogin", emptyFieldErrorMessage);

        formLogin.addEventListener("submit", function(event) {
            const okEmail = validateFormElem(inputEmail, spanEmail, emailErrorMessage);
            const okPassword = validateFormElem(inputPassword, spanPassword, emptyFieldErrorMessage);
            if (!okEmail || !okPassword) {
                event.preventDefault(); // i dati partono solo se la validazione è positiva
                if (loginGeneralError) loginGeneralError.style.display = "block";
            }
        });
    }

    // ---------- REGISTRAZIONE: validazione su change per ogni campo ----------
    attachValidation("nome", "errorNome", nameOrLastnameErrorMessage);
    attachValidation("cognome", "errorCognome", nameOrLastnameErrorMessage);
    attachValidation("indirizzo", "errorIndirizzo", emptyFieldErrorMessage);
    attachValidation("signup-email", "errorEmailSignup", emailErrorMessage);
    attachValidation("signup-password", "errorPasswordSignup", passwordErrorMessage);

    // Data di nascita: campo richiesto + non nel futuro
    const inputData = document.getElementById("dataNascita");
    const spanData = document.getElementById("errorDataNascita");
    if (inputData && spanData) {
        inputData.addEventListener("change", () => validaDataNascita(inputData, spanData));
    }

    // ---------- CHECKOUT ----------
    const formCheckout = document.getElementById("formCheckout");
    if (formCheckout) {
        attachValidation("indirizzoSpedizione", "errorIndirizzoSpedizione", emptyFieldErrorMessage);

        const inputCarta = document.getElementById("numeroCarta");
        const spanCarta = document.getElementById("errorNumeroCarta");
        if (inputCarta && spanCarta) {
            // Formattazione automatica: solo cifre, spazio ogni 4
            inputCarta.addEventListener("input", function(e) {
                let raw = e.target.value.replace(/\D/g, "").substring(0, 16);
                e.target.value = raw.replace(/(\d{4})(?=\d)/g, "$1 ");
                validateFormElem(inputCarta, spanCarta, cartaErrorMessage);
            });
            inputCarta.addEventListener("change", () => validateFormElem(inputCarta, spanCarta, cartaErrorMessage));
        }

        formCheckout.addEventListener("submit", function(event) {
            let valid = true;
            const inputInd = document.getElementById("indirizzoSpedizione");
            const spanInd = document.getElementById("errorIndirizzoSpedizione");
            if (!validateFormElem(inputInd, spanInd, emptyFieldErrorMessage)) valid = false;
            if (inputCarta && !validateFormElem(inputCarta, spanCarta, cartaErrorMessage)) valid = false;
            if (!valid) event.preventDefault();
        });
    }
});

// Controllo custom della data di nascita (usato su change e al submit)
function validaDataNascita(input, span) {
    if (!validateFormElem(input, span, emptyFieldErrorMessage)) return false;
    const oggi = new Date().toISOString().split("T")[0]; // yyyy-mm-dd
    if (input.value > oggi) {
        mostraErrore(input, span, dataFuturaErrorMessage);
        return false;
    }
    return true;
}

// ==========================================================================
// 4. CAMBIO SCHEDA
// ==========================================================================
function cambiaScheda(scheda) {
    const formLogin = document.getElementById('formLogin');
    const formSignup = document.getElementById('formSignup');
    const tabLogin = document.getElementById('tabLogin');
    const tabSignup = document.getElementById('tabSignup');

    if (!formLogin || !formSignup) return;

    if (scheda === 'login') {
        formLogin.style.display = 'block';
        formSignup.style.display = 'none';
        tabLogin.classList.add('active');
        tabSignup.classList.remove('active');
    } else {
        formLogin.style.display = 'none';
        formSignup.style.display = 'block';
        tabSignup.classList.add('active');
        tabLogin.classList.remove('active');

        const phonesContainer = document.getElementById("phonesContainer");
        if (phonesContainer && phonesContainer.children.length === 0) {
            addPhone();
        }
    }
}

// ==========================================================================
// 5. TELEFONI DINAMICI
// ==========================================================================
function addPhone() {
    let container = document.getElementById("phonesContainer");
    if (!container) return;

    let wrapper = document.createElement("div");
    wrapper.style.marginBottom = "15px";
    wrapper.id = "phoneWrapper" + phoneCount;

    let div = document.createElement("div");
    div.className = "phone-row";
    div.style.display = "flex";
    div.style.gap = "10px";

    let input = document.createElement("input");
    input.type = "text";
    input.name = "telefono";
    input.id = "phone" + phoneCount;
    input.pattern = "^([0-9]{3}-[0-9]{7})$";
    input.required = true;
    input.placeholder = "es. 333-1234567";
    input.style.flex = "1";
    input.maxLength = 11;

    let btnRemove = document.createElement("button");
    btnRemove.type = "button";
    btnRemove.textContent = "✖";
    btnRemove.style.padding = "0 15px";
    btnRemove.style.background = "Tomato";
    btnRemove.style.color = "white";
    btnRemove.style.border = "none";
    btnRemove.style.borderRadius = "6px";
    btnRemove.style.cursor = "pointer";
    btnRemove.onclick = function() { wrapper.remove(); };

    let span = document.createElement("span");
    span.id = "errorPhone" + phoneCount;

    input.addEventListener("input", function(e) {
        let rawValue = e.target.value.replace(/\D/g, '');
        if (rawValue.length > 3) {
            e.target.value = rawValue.substring(0, 3) + '-' + rawValue.substring(3, 10);
        } else {
            e.target.value = rawValue;
        }
        validateFormElem(input, span, phoneErrorMessage);
    });
    input.addEventListener("change", function() {
        validateFormElem(input, span, phoneErrorMessage);
    });

    div.appendChild(input);
    div.appendChild(btnRemove);
    wrapper.appendChild(div);
    wrapper.appendChild(span);
    container.appendChild(wrapper);

    phoneCount++;
}

// ==========================================================================
// 6. VALIDAZIONE REGISTRAZIONE AL SUBMIT
// ==========================================================================
function validateRegistrazione() {
    let valid = true;

    if (!validateFormElem(document.getElementById("nome"), document.getElementById("errorNome"), nameOrLastnameErrorMessage)) valid = false;
    if (!validateFormElem(document.getElementById("cognome"), document.getElementById("errorCognome"), nameOrLastnameErrorMessage)) valid = false;
    if (!validateFormElem(document.getElementById("signup-email"), document.getElementById("errorEmailSignup"), emailErrorMessage)) valid = false;
    if (!validateFormElem(document.getElementById("signup-password"), document.getElementById("errorPasswordSignup"), passwordErrorMessage)) valid = false;
    if (!validateFormElem(document.getElementById("indirizzo"), document.getElementById("errorIndirizzo"), emptyFieldErrorMessage)) valid = false;

    const inputData = document.getElementById("dataNascita");
    const spanData = document.getElementById("errorDataNascita");
    if (inputData && spanData && !validaDataNascita(inputData, spanData)) valid = false;

    for (let i = 1; i <= phoneCount; i++) {
        let spanPhone = document.getElementById("errorPhone" + i);
        let phoneInput = document.getElementById("phone" + i);
        if (spanPhone && phoneInput) {
            if (!validateFormElem(phoneInput, spanPhone, phoneErrorMessage)) valid = false;
        }
    }

    return valid;
}
