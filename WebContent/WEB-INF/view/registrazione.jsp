<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Autenticazione - TravelBooking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <script src="${pageContext.request.contextPath}/validate.js" defer></script>
</head>
<body class="auth-body">

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/index.html" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong>+39 089 1234567</strong></span>
        </div>
    </nav>

    <div class="auth-container">
        <div class="auth-card">
            
            <div class="modal-tabs">
                <div class="tab active" id="tabLogin" onclick="cambiaScheda('login')">Accedi</div>
                <div class="tab" id="tabSignup" onclick="cambiaScheda('signup')">Registrati</div>
            </div>
            
            <span class="error-span" style="text-align: center; display: block; margin-bottom: 15px; color: red;">${messaggioErrore}</span>

            <form id="formLogin" action="LoginServlet" method="POST" novalidate>
    
    		<div id="loginGeneralError" style="display: none; background-color: #ef4444; color: white; padding: 10px; border-radius: 6px; margin-bottom: 15px; text-align: center; font-weight: bold; font-size: 14px;">
       			 Hai inserito dati non validi.
			</div>

    		<div class="form-group">
        		<label for="login-email">Email</label>
        		<input type="email" id="login-email" name="email" required>
        		<span id="errorEmailLogin"></span>
    		</div>

    		<div class="form-group">
        		<label for="login-password">Password</label>
        		<input type="password" id="login-password" name="password" required>
        		<span id="errorPasswordLogin"></span>
    		</div>

    			<button type="submit" class="btn-submit-login">Accedi</button>
			</form>

            <form id="formSignup" action="RegistrazioneServlet" method="POST" style="display: none;" novalidate onsubmit="return validateRegistrazione();">
                <div class="form-group">
                    <label for="nome">Nome</label>
                    <input type="text" id="nome" name="nome" pattern="^[a-zA-Z\s]+$" required>
                    <span id="errorNome"></span>
                </div>
                
                <div class="form-group">
                    <label for="cognome">Cognome</label>
                    <input type="text" id="cognome" name="cognome" pattern="^[a-zA-Z\s]+$" required>
                    <span id="errorCognome"></span>
                </div>

                <div class="form-group">
                    <label for="signup-email">Email</label>
                    <input type="email" id="signup-email" name="email" required>
                    <span id="errorEmailSignup"></span>
                </div>

                <div class="form-group">
                    <label for="signup-password">Password</label>
                    <input type="password" id="signup-password" name="password" required>
                    <span id="errorPasswordSignup"></span>
                </div>

                <div class="form-group">
                    <label>Numeri di Telefono</label>
                    <div id="phonesContainer"></div>
                    <button type="button" class="btn-add-phone" onclick="addPhone()">+ Aggiungi un altro numero</button>
                </div>

                <button type="submit" class="btn-submit-signup" style="margin-top: 15px;">Crea Account</button>
            </form>

        </div>
    </div>

</body>
</html>