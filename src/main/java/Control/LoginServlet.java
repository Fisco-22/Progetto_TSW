package Control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import javax.sql.DataSource;
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
    
    private UtenteDAO dao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
        dao = new UtenteDAO(ds);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Utente_Bean uAutentificato = dao.checkLogin(email, password);
        
        if (uAutentificato != null) {
            // Login OK: creiamo la sessione ("utente" è il nome usato da tutte le JSP)
            HttpSession session = request.getSession();
            session.setAttribute("utente", uAutentificato);
            session.setAttribute("userEmail", uAutentificato.getEmail());

            // Redirect (Post-Redirect-Get): evita il reinvio del form al refresh
            response.sendRedirect(request.getContextPath() + "/AreaPersonaleServlet");
        } else {
            // Login Fallito: Inviamo il messaggio d'errore alla pagina di autenticazione
            request.setAttribute("messaggioErrore", "Email o password errate. Riprova.");
            
            // CORRETTO: Percorso assoluto completo per evitare il 404 di Tomcat
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Il login via GET (credenziali nell'URL) non è ammesso: si torna alla pagina di autenticazione
        response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
    }
}