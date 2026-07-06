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
        // La prassi migliore è gestire l'invio dei form (dati sensibili) nel doPost
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Utente_Bean uAutentificato = dao.checkLogin(email, password);
        
        if (uAutentificato != null) {
            // Login OK: Creiamo la sessione e andiamo alla dashboard
            HttpSession session = request.getSession();
            session.setAttribute("user", uAutentificato);
            session.setAttribute("userEmail", uAutentificato.getEmail());
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/utenteDashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            // Login Fallito: Inviamo un messaggio d'errore alla nostra pagina unificata
            request.setAttribute("messaggioErrore", "Email o password errate. Riprova.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Se qualcuno prova ad accedere alla servlet tramite URL (GET), lo rimandiamo al POST
        doPost(request, response);
    }
}