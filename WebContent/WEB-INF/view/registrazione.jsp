<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione - TravelBooking</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Stili aggiuntivi per il form (da mettere in style.css se preferisci) */
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; }
        .error-message { color: #d9534f; font-weight: bold; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.html" class="logo">TravelBooking</a>
        <div class="nav-links">
            <span class="nav-info">Assistenza clienti: <strong>+39 089 1234567</strong></span>
            <a href="registrazione.jsp" class="btn-accedi">Accedi / Registrati</a>
        </div>
    </nav>

    <div class="form-container">
        <h2>Crea il tuo account</h2>
        
        <div class="error-message">${messaggioErrore}</div>

        <form action="RegistrazioneServlet" method="POST">
            <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="btn-cerca" style="width: 100%; margin-top: 10px;">Registrati</button>
        </form>
    </div>

</body>
</html>