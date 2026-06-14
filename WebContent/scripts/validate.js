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
    
    // A. RECUPERO ELEMENTI PER APERTURA/CHIUSURA MODALE
    const openModalBtn = document.getElementById("openModalBtn");
    const authModal = document.getElementById("authModal");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const formLogin = document.getElementById("formLoginPopUp");

    // Click su "Accedi" nella Navbar -> Mostra Modale
    if (openModalBtn && authModal) {
        openModalBtn.addEventListener("click", (e) => {
            e.preventDefault(); // Impedisce il comportamento di default del link #
            authModal.style.display = "flex";
        });
    }

    // Click sulla (X) -> Chiudi Modale
    if (closeModalBtn && authModal) {
        closeModalBtn.addEventListener("click", () => {
            authModal.style.display = "none";
        });
    }

    // Click fuori dal rettangolo bianco -> Chiudi Modale
    if (authModal) {
        authModal.addEventListener("click", (e) => {
            if (e.target === authModal) {
                authModal.style.display = "none";
            }
        });
    }

    // B. GESTIONE DEI TAB (Accedi / Iscriviti)
    const tabLogin = document.getElementById("tabLogin");
    const tabSignup = document.getElementById("tabSignup");
    const modalTitle = document.getElementById("modalTitle");

    if (tabLogin && tabSignup) {
        tabLogin.addEventListener("click", () => {
            tabLogin.classList.add("active");
            tabSignup.classList.remove("active");
            if (modalTitle) modalTitle.textContent = "Accedi al tuo account TravelBooking";
            if (formLogin) formLogin.style.display = "block";
        });

        tabSignup.addEventListener("click", () => {
            tabSignup.classList.add("active");
            tabLogin.classList.remove("active");
            if (modalTitle) modalTitle.textContent = "Crea il tuo account TravelBooking";
            if (formLogin) formLogin.style.display = "none"; // Nasconde il login in attesa del form signup
        });
    }

    // C. AGGANCIO VALIDAZIONE LATO CLIENT AL SUBMIT DEL FORM
    if (formLogin) {
        formLogin.addEventListener("submit", (e) => {
            if (!validateLogin()) {
                e.preventDefault(); // Blocca l'invio alla Servlet se i dati non sono validi
            }
        });
    }

    // D. INTERCETTAZIONE ERRORE BACKEND (Dalla Servlet)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('auth_error')) {
        if (authModal) {
            authModal.style.display = 'flex';
        }
        
        if (formLogin) {
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
            errorMsg.innerHTML = '❌ Email o password errate. Riprova.';
            
            formLogin.prepend(errorMsg);
        }
        
        window.history.replaceState({}, document.title, window.location.pathname);
    }
});