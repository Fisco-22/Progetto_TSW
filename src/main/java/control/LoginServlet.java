package control;

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
import java.util.UUID;

import model.*;
import dao.*;

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
            HttpSession session = request.getSession();
            session.setAttribute("utente", uAutentificato);
            session.setAttribute("userEmail", uAutentificato.getEmail());
            session.setAttribute("token", UUID.randomUUID().toString());

            response.sendRedirect(request.getContextPath() + "/AreaPersonaleServlet");
        } else {
            request.setAttribute("messaggioErrore", "Email o password errate. Riprova.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
    }
}