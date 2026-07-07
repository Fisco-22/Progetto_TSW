// ==========================================================================
// 1. VARIABILI GLOBALI E MESSAGGI DI ERRORE
// ==========================================================================
let phoneCount = 1;

const nameOrLastnameErrorMessage = "Questo campo deve contenere solo lettere.";
const emailErrorMessage = "Inserisci un'email valida (es. utente@dominio.it).";
const phoneErrorMessage = "Il formato deve essere ###-#######.";
const emptyFieldErrorMessage = "Questo campo non può essere vuoto.";
const passwordErrorMessage = "La password è obbligatoria.";

// ==========================================================================
// 2. FUNZIONE DI VALIDAZIONE VISIVA
// ==========================================================================
function validateFormElem(formElem, span, errorMessage) {
    if (!formElem || !span) return true;
    
    if(formElem.checkValidity()){
        formElem.style.borderColor = "#ccc"; 
        span.innerHTML = "";
        return true;
    }
    
    formElem.style.borderColor = "#ef4444"; 
    span.style.color = "#ef4444";
    span.style.fontSize = "13px";
    span.style.fontWeight = "500";
    span.style.display = "block";
    span.style.marginTop = "4px";
    
    if (formElem.validity.valueMissing){
        span.innerHTML = emptyFieldErrorMessage;
    } else {
        span.innerHTML = errorMessage;
    }
    return false;
}

// ==========================================================================
// 3. EVENTI IN TEMPO REALE (LOGIN)
// ==========================================================================
document.addEventListener("DOMContentLoaded", () => {
    const formLogin = document.getElementById("formLogin");
    const loginGeneralError = document.getElementById("loginGeneralError");
    
    // Recupero esattamente i campi tramite il loro ID
    const inputEmail = document.getElementById("login-email");
    const inputPassword = document.getElementById("login-password");
    const spanEmail = document.getElementById("errorEmailLogin");
    const spanPassword = document.getElementById("errorPasswordLogin");
    
    if (formLogin && inputEmail && inputPassword) {
        
        // Controllo mentre scrivi l'email
        inputEmail.addEventListener("input", function() {
            validateFormElem(inputEmail, spanEmail, emailErrorMessage);
            if(loginGeneralError) loginGeneralError.style.display = "none";
        });
        
        // Controllo mentre scrivi la password
        inputPassword.addEventListener("input", function() {
            validateFormElem(inputPassword, spanPassword, passwordErrorMessage);
            if(loginGeneralError) loginGeneralError.style.display = "none";
        });

        // Blocco dell'invio (Evita l'errore 404!)
        formLogin.addEventListener("submit", function(event) {
            let isEmailValid = validateFormElem(inputEmail, spanEmail, emailErrorMessage);
            let isPasswordValid = validateFormElem(inputPassword, spanPassword, passwordErrorMessage);
            
            if (!isEmailValid || !isPasswordValid) {
                event.preventDefault(); // QUESTA RIGA BLOCCA IL 404!
                if(loginGeneralError) loginGeneralError.style.display = "block";
            }
        });
    }
});

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
// 5. TELEFONI DINAMICI E VALIDAZIONE REGISTRAZIONE
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
    
    // NOVITÀ 1: Blocca fisicamente la digitazione oltre gli 11 caratteri (3 numeri + 1 trattino + 7 numeri)
    input.maxLength = 11; 

    let btnRemove = document.createElement("button");
    btnRemove.type = "button";
    btnRemove.textContent = "✖";
    btnRemove.style.padding = "0 15px";
    btnRemove.style.background = "#ef4444"; 
    btnRemove.style.color = "white";
    btnRemove.style.border = "none";
    btnRemove.style.borderRadius = "6px";
    btnRemove.style.cursor = "pointer";
    btnRemove.onclick = function() { wrapper.remove(); };

    let span = document.createElement("span");
    span.id = "errorPhone" + phoneCount;

    // NOVITÀ 2: Intercetta ogni tasto premuto per formattare il testo
    input.addEventListener("input", function(e) { 
        // A. Rimuove istantaneamente qualsiasi lettera o simbolo (lascia solo i numeri)
        let rawValue = e.target.value.replace(/\D/g, '');
        
        // B. Inserisce automaticamente il trattino dopo le prime 3 cifre
        if (rawValue.length > 3) {
            e.target.value = rawValue.substring(0, 3) + '-' + rawValue.substring(3, 10);
        } else {
            e.target.value = rawValue;
        }
        
        // C. Controlla la validazione per far scomparire la scritta rossa se è corretto
        validateFormElem(input, span, phoneErrorMessage);
    });

    div.appendChild(input);
    div.appendChild(btnRemove);
    wrapper.appendChild(div);
    wrapper.appendChild(span);
    container.appendChild(wrapper);
    
    phoneCount++;
}

function validateRegistrazione() {
    let valid = true;	
    
    let inputNome = document.getElementById("nome");
    let spanNome = document.getElementById("errorNome");
    if(!validateFormElem(inputNome, spanNome, nameOrLastnameErrorMessage)) valid = false;
    
    let inputCognome = document.getElementById("cognome\");
    let spanCognome = document.getElementById("errorCognome");
    if (!validateFormElem(inputCognome, spanCognome, nameOrLastnameErrorMessage)) valid = false;
    
    let inputEmailSignup = document.getElementById("signup-email");
    let spanEmailSignup = document.getElementById("errorEmailSignup");
    if (!validateFormElem(inputEmailSignup, spanEmailSignup, emailErrorMessage)) valid = false;

    let inputPasswordSignup = document.getElementById("signup-password");
    let spanPasswordSignup = document.getElementById("errorPasswordSignup");
    if (!validateFormElem(inputPasswordSignup, spanPasswordSignup, passwordErrorMessage)) valid = false;
    
    // NOUVI CONTROLLI AGGIUNTI QUI:
    let inputIndirizzo = document.getElementById("indirizzo");
    let spanIndirizzo = document.getElementById("errorIndirizzo");
    if (!validateFormElem(inputIndirizzo, spanIndirizzo, emptyFieldErrorMessage)) valid = false;

    let inputDataNascita = document.getElementById("dataNascita");
    let spanDataNascita = document.getElementById("errorDataNascita");
    if (!validateFormElem(inputDataNascita, spanDataNascita, emptyFieldErrorMessage)) valid = false;
    
    // Controllo dei telefoni (lascialo com'è sotto)
    for (let i = 1; i <= phoneCount; i++){
        let spanPhone = document.getElementById("errorPhone" + i);
        let phoneInput = document.getElementById("phone" + i);
        if (spanPhone && phoneInput) {
            if (!validateFormElem(phoneInput, spanPhone, phoneErrorMessage)) valid = false;
        }
    }
    
    return valid;
}