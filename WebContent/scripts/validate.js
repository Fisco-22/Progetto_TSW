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