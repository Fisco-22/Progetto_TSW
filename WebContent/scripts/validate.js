let count = 1;
const nameOrLastnameErrorMessage = "This field should contain only letters";
const emailErrorMessage = "The email field should be in the form username@domain.ext";
const phoneErrorMessage = "The number field should be in the form ###-#######";
const emptyFieldErrorMessage = "This field cannot be empty"

function validateFormElem(formElem, spanError, errorMessage) {
    if (!formElem) return true; // Se l'elemento non esiste, consideralo valido

    if (formElem.checkValidity()) {
        formElem.classList.remove("error-field");
        spanError.style.color = "transparent";
        spanError.innerHTML = "";
        return true;
    }
	
	formElem.classList.add("error-field");
	    spanError.style.color = "#ef4444"; // Rosso moderno
	    
	    if (formElem.validity.valueMissing) {
	        spanError.innerHTML = emptyFieldErrorMessage;
	    } else {
	        spanError.innerHTML = errorMessage;
	    }
	    return false;
	}
	
	function validateLogin() {
	    let valid = true;

	    // Recupero elementi dal DOM del pop-up di Login
	    const loginEmail = document.getElementById("loginEmail");
	    const errorLoginEmail = document.getElementById("errorLoginEmail");
	    
	    const loginPassword = document.getElementById("loginPassword");
	    const errorLoginPassword = document.getElementById("errorLoginPassword");

	    // Validazione Email
	    if (!validateFormElem(loginEmail, errorLoginEmail, emailErrorMessage)) {
	        valid = false;
	    }

	    // Validazione Password
	    if (!validateFormElem(loginPassword, errorLoginPassword, passwordErrorMessage)) {
	        valid = false;
	    }

	    return valid;
	}
	
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

	    // Validazione Telefoni Dinamici (se presenti)
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

	    // Listener in tempo reale al cambio di focus
	    input.addEventListener("change", function() {
	        validateFormElem(input, span, phoneErrorMessage);
	    });

	    div.appendChild(input);
	    div.appendChild(btnRemove);
	    div.appendChild(span);
	    container.appendChild(div);
	    
	    phoneCount++;
	}
	
	document.addEventListener('DOMContentLoaded', () => {
	    const urlParams = new URLSearchParams(window.location.search);
	    
	    // Se la servlet ha rifiutato il login, intercetta il parametro
	    if (urlParams.has('auth_error')) {
	        const modalOverlay = document.getElementById('modalOverlay'); // Assicurati di avere questo ID nel tuo overlay
	        const formLogin = document.getElementById('formLoginPopUp');
	        
	        // 1. Apri la modale forzatamente
	        if (modalOverlay) {
	            modalOverlay.classList.add('active');
	        }
	        
	        // 2. Mostra l'errore sopra il form
	        const errorMsg = document.createElement('div');
	        errorMsg.style.color = '#ef4444';
	        errorMsg.style.backgroundColor = '#fef2f2';
	        errorMsg.style.border = '1px solid #f87171';
	        errorMsg.style.padding = '10px';
	        errorMsg.style.borderRadius = '6px';
	        errorMsg.style.marginBottom = '15px';
	        errorMsg.style.textAlign = 'center';
	        errorMsg.style.fontWeight = 'bold';
	        errorMsg.innerHTML = 'Email o password errate. Riprova.';
	        
	        formLogin.prepend(errorMsg);
	        
	        // (Opzionale) Pulisci l'URL per evitare che ricaricando la pagina l'errore rimanga
	        window.history.replaceState({}, document.title, window.location.pathname);
	    }
	});