// 1. COSTANTI E VARIABILI GLOBALI (Sistemate e completate)
let phoneCount = 1; // Corretto da 'count' a 'phoneCount'
const nameOrLastnameErrorMessage = "This field should contain only letters";
const emailErrorMessage = "The email field should be in the form username@domain.ext";
const phoneErrorMessage = "The number field should be in the form ###-#######";
const passwordErrorMessage = "The password must be between 6 and 20 characters"; // Aggiunta costante mancante
const emptyFieldErrorMessage = "This field cannot be empty";

// Funzione base di validazione dell'elemento
function validateFormElem(formElem, spanError, errorMessage) {
    if (!formElem) return true; 

    if (formElem.checkValidity()) {
        formElem.classList.remove("error-field");
        spanError.style.color = "transparent";
        spanError.innerHTML = "";
        return true;
    }
	
    formElem.classList.add("error-field");
    spanError.style.color = "#ef4444"; 
    
    if (formElem.validity.valueMissing) {
        spanError.innerHTML = emptyFieldErrorMessage;
    } else {
        spanError.innerHTML = errorMessage;
    }
    return false;
}
	
// Validazione Login
function validateLogin() {
    let valid = true;

    const loginEmail = document.getElementById("loginEmail");
    const errorLoginEmail = document.getElementById("errorLoginEmail");
    const loginPassword = document.getElementById("loginPassword");
    const errorLoginPassword = document.getElementById("errorLoginPassword");

    if (!validateFormElem(loginEmail, errorLoginEmail, emailErrorMessage)) valid = false;
    if (!validateFormElem(loginPassword, errorLoginPassword, passwordErrorMessage)) valid = false;

    return valid;
}
	
// Validazione Registrazione
function validateSignup() {
    let valid = true;

    const signupNome = document.getElementById("signupNome");
    const errorNome = document.getElementById("errorNome");
    if (!validateFormElem(signupNome, errorNome, nameOrLastnameErrorMessage)) valid = false;

    const signupCognome = document.getElementById("signupCognome");
    const errorCognome = document.getElementById("errorCognome");
    if (!validateFormElem(signupCognome, errorCognome, nameOrLastnameErrorMessage)) valid = false;

    const signupEmail = document.getElementById("signupEmail");
    const errorEmail = document.getElementById("errorEmail");
    if (!validateFormElem(signupEmail, errorEmail, emailErrorMessage)) valid = false;

    const signupPassword = document.getElementById("signupPassword");
    const errorPassword = document.getElementById("errorPassword");
    if (!validateFormElem(signupPassword, errorPassword, passwordErrorMessage)) valid = false;

    const signupIndirizzo = document.getElementById("signupIndirizzo");
    const errorIndirizzo = document.getElementById("errorIndirizzo");
    if (!validateFormElem(signupIndirizzo, errorIndirizzo, emptyFieldErrorMessage)) valid = false;

    for (let i = 0; i < phoneCount; i++) {
        let spanPhone = document.getElementById("errorPhone" + i);
        let inputPhone = document.getElementById("phone" + i);
        if (spanPhone && inputPhone) {
            if (!validateFormElem(inputPhone, spanPhone, phoneErrorMessage)) {
                valid = false;
            }
        }
    }

    return valid;
}
	
// Aggiunta dinamica dei telefoni
function addPhone() {
    let container = document.getElementById("phonesContainer");
    if (!container) return;

    let div = document.createElement("div");
    div.className = "phone-row";
    div.id = "phoneRow" + phoneCount;

    let input = document.createElement("input");
    input.type = "text";
    input.name = "phone";
    input.id = "phone" + phoneCount;
    input.pattern = "^([0-9]{3}-[0-9]{7})$";
    input.required = true;
    input.placeholder = "###-#######";

    let btnRemove = document.createElement("button");
    btnRemove.type = "button";
    btnRemove.className = "btn-remove-phone";
    btnRemove.textContent = "-";
    btnRemove.onclick = function() { div.remove(); };

    let span = document.createElement("span");
    span.id = "errorPhone" + phoneCount;
    span.className = "error-span";

    input.addEventListener("change", function() {
        validateFormElem(input, span, phoneErrorMessage);
    });

    div.appendChild(input);
    div.appendChild(btnRemove);
    div.appendChild(span);
    container.appendChild(div);
    
    phoneCount++;
}
	
// ================= GESTIONE EVENTI DOMOMLOADED =================
document.addEventListener('DOMContentLoaded', () => {
    
    // -- ELEMENTI LATO INDEX (Login Modale) --
    const openModalBtn = document.getElementById("openModalBtn");
    const authModal = document.getElementById("authModal");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const formLogin = document.getElementById("formLoginPopUp");

    // -- ELEMENTI LATO REGISTRAZIONE (Pagina Separata) --
    const formSignup = document.getElementById("formSignupPage");

    // 1. Apertura e chiusura Modale (solo se siamo su index.html)
    if (openModalBtn && authModal) {
        openModalBtn.addEventListener("click", (e) => {
            e.preventDefault();
            authModal.style.display = "flex";
        });
    }

    if (closeModalBtn && authModal) {
        closeModalBtn.addEventListener("click", () => {
            authModal.style.display = "none";
        });
    }

    if (authModal) {
        authModal.addEventListener("click", (e) => {
            if (e.target === authModal) {
                authModal.style.display = "none";
            }
        });
    }

    // 2. Validazione invio Login (solo su index.html)
    if (formLogin) {
        formLogin.addEventListener("submit", (e) => {
            if (!validateLogin()) e.preventDefault();
        });
    }

    // 3. Validazione invio Registrazione (solo se siamo su registrazione.html)
    if (formSignup) {
        formSignup.addEventListener("submit", (e) => {
            if (!validateSignup()) e.preventDefault();
        });
        
        // Aggiungo il primo campo telefono di default quando si apre la pagina
        addPhone();
    }

    // 4. Intercettazione Errore Backend (Login)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('auth_error') && formLogin) {
        if (authModal) authModal.style.display = 'flex';
        
        const vecchioErrore = formLogin.querySelector('.backend-error');
        if (vecchioErrore) vecchioErrore.remove();

        const errorMsg = document.createElement('div');
        errorMsg.className = 'backend-error'; 
        errorMsg.style.color = '#ef4444';
        errorMsg.style.backgroundColor = '#fef2f2';
        errorMsg.style.border = '1px solid #f87171';
        errorMsg.style.padding = '10px';
        errorMsg.style.borderRadius = '6px';
        errorMsg.style.marginBottom = '15px';
        errorMsg.style.textAlign = 'center';
        errorMsg.style.fontWeight = 'bold';
        errorMsg.style.fontSize = '14px';
        errorMsg.innerHTML = 'Email o password errate. Riprova.';
        
        formLogin.prepend(errorMsg);
        window.history.replaceState({}, document.title, window.location.pathname);
    }
	
	// === GESTIONE SCAMBIO LOGIN / REGISTRAZIONE NELLA PAGINA DEDICATA ===
	    const linkMostraIscrizione = document.getElementById("linkMostraIscrizione");
	    const linkMostraLogin = document.getElementById("linkMostraLogin");
	    const sezioneLogin = document.getElementById("sezioneLogin");
	    const sezioneRegistrazione = document.getElementById("sezioneRegistrazione");

	    if (linkMostraIscrizione && linkMostraLogin) {
	        // Quando clicco "clicca su iscriviti"
	        linkMostraIscrizione.addEventListener("click", (e) => {
	            e.preventDefault(); // Evita che la pagina salti in cima
	            sezioneLogin.style.display = "none";
	            sezioneRegistrazione.style.display = "block";
	            
	            // Assicuriamoci che ci sia almeno un campo telefono quando si apre
	            const phonesContainer = document.getElementById("phonesContainer");
	            if (phonesContainer && phonesContainer.children.length === 0) {
	                if (typeof addPhone === "function") addPhone();
	            }
	        });

	        // Quando clicco "Accedi qui"
	        linkMostraLogin.addEventListener("click", (e) => {
	            e.preventDefault();
	            sezioneRegistrazione.style.display = "none";
	            sezioneLogin.style.display = "block";
	        });
	    }
});
// === FUNZIONE DI VALIDAZIONE DINAMICA ===
    function validaCampiVuoti(formElement) {
        let isValid = true;
        
        // Prende tutti gli input del form tranne i bottoni e i campi nascosti
        const inputs = formElement.querySelectorAll('input:not([type="hidden"]):not([type="button"]):not([type="submit"])');
        
        inputs.forEach(input => {
            // Cerca lo span subito dopo l'input
            const errorSpan = input.nextElementSibling;
            
            // Se il campo è vuoto
            if (input.value.trim() === '') {
                if (errorSpan && errorSpan.classList.contains('error-span')) {
                    errorSpan.textContent = "Campo obbligatorio";
                }
                input.style.border = "2px solid #ef4444"; // Colora il bordo di rosso
                isValid = false;
            } else {
                // Se il campo è compilato, pulisce l'errore
                if (errorSpan && errorSpan.classList.contains('error-span')) {
                    errorSpan.textContent = "";
                }
                input.style.border = "1px solid #ccc"; // Riporta il bordo alla normalità
            }
        });
        
        return isValid;
    }

    // === AGGANCIO AL LOGIN PAGE ===
    const formLoginPage = document.getElementById("formLoginPage");
    if (formLoginPage) {
        formLoginPage.addEventListener("submit", (e) => {
            if (!validaCampiVuoti(formLoginPage)) {
                e.preventDefault(); // Blocca l'invio se c'è un errore
            }
        });
    }

    // === AGGANCIO ALLA REGISTRAZIONE PAGE ===
    const formSignupPage = document.getElementById("formSignupPage");
    if (formSignupPage) {
        formSignupPage.addEventListener("submit", (e) => {
            if (!validaCampiVuoti(formSignupPage)) {
                e.preventDefault(); // Blocca l'invio se c'è un errore
            }
        });
    }

    // (Opzionale) Rimuove l'errore in tempo reale non appena l'utente inizia a scrivere!
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('input', function() {
            if (this.value.trim() !== '') {
                const errorSpan = this.nextElementSibling;
                if (errorSpan && errorSpan.classList.contains('error-span')) {
                    errorSpan.textContent = "";
                }
                this.style.border = "1px solid #ccc";
            }
        });
    });