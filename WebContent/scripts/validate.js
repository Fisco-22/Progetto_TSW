// 1. VARIABILI GLOBALI
let phoneCount = 1;

// Aggiunta dinamica dei telefoni (Mantieni questa!)
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
    input.placeholder = "es. 333-1234567";

    let btnRemove = document.createElement("button");
    btnRemove.type = "button";
    btnRemove.className = "btn-remove-phone";
    btnRemove.textContent = "-";
    btnRemove.onclick = function() { div.remove(); };

    div.appendChild(input);
    div.appendChild(btnRemove);
    container.appendChild(div);
    
    phoneCount++;
}

// ================= GESTIONE EVENTI DOMContentLoaded =================
document.addEventListener('DOMContentLoaded', () => {
    
    // -- ELEMENTI LATO INDEX (Se hai deciso di mantenere il pop-up su index.html) --
    const openModalBtn = document.getElementById("openModalBtn");
    const authModal = document.getElementById("authModal");
    const closeModalBtn = document.getElementById("closeModalBtn");
    const formLogin = document.getElementById("formLoginPopUp");

    // 1. Apertura e chiusura Modale (se usi la modale)
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

    // 2. Intercettazione Errore Backend (Login)
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('auth_error')) {
        // Cerca il form sia nel pop-up che nella pagina di login dedicata
        const targetForm = formLogin || document.getElementById("formLoginPage"); 
        
        if (targetForm) {
            if (authModal) authModal.style.display = 'flex';
            
            const vecchioErrore = targetForm.querySelector('.backend-error');
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
            
            targetForm.prepend(errorMsg);
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    }
	
	// === GESTIONE SCAMBIO LOGIN / REGISTRAZIONE NELLA PAGINA DEDICATA ===
    const linkMostraIscrizione = document.getElementById("linkMostraIscrizione");
    const linkMostraLogin = document.getElementById("linkMostraLogin");
    const sezioneLogin = document.getElementById("sezioneLogin");
    const sezioneRegistrazione = document.getElementById("sezioneRegistrazione");

    if (linkMostraIscrizione && linkMostraLogin) {
        // Quando clicco "clicca su iscriviti"
        linkMostraIscrizione.addEventListener("click", (e) => {
            e.preventDefault(); 
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

    // Aggiungo il primo campo telefono di default quando si apre la pagina di registrazione
    const formSignup = document.getElementById("formSignupPage");
    if (formSignup) {
        const phonesContainer = document.getElementById("phonesContainer");
        if (phonesContainer && phonesContainer.children.length === 0) {
            addPhone();
        }
    }
});