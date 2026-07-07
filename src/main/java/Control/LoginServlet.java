package Control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.*;
import DAO.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UtenteDAO dao = new UtenteDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Utente_Bean uAutentificato = dao.checkLogin(email, password);
        
        if (uAutentificato != null) {
            // Login OK: Creiamo la sessione e andiamo alla dashboard reale dell'utente
            HttpSession session = request.getSession();
            session.setAttribute("user", uAutentificato);
            session.setAttribute("userEmail", uAutentificato.getEmail());
            
            // CORRETTO: Percorso assoluto e allineato al nome reale del file (Area_Personale.jsp)
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/Area_Personale.jsp");
            dispatcher.forward(request, response);
        } else {
            // Login Fallito: Inviamo il messaggio d'errore alla pagina di autenticazione
            request.setAttribute("messaggioErrore", "Email o password errate. Riprova.");
            
            // CORRETTO: Percorso assoluto completo per evitare il 404 di Tomcat
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Se qualcuno prova ad accedere alla servlet tramite URL (GET), lo rimandiamo al POST
        doPost(request, response);
    }
}