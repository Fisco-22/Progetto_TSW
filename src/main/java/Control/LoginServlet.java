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
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	private UtenteDAO dao = new UtenteDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String actionType = request.getParameter("actionType");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		HttpSession session = request.getSession();
		
		if("login".equals(actionType)) {
			Utente_Bean uAutentificato= dao.checkLogin(email, password);
			
			if(uAutentificato != null) {
				session.setAttribute("user", uAutentificato);
				session.setAttribute("userEmail", uAutentificato.getEmail());
				RequestDispatcher dispatcher = request.getRequestDispatcher("view/utenteDashboard.jsp");
				dispatcher.forward(request, response);
			} else {
				response.sendRedirect("index.html?auth_error=true");
			}
		} else if("signup".equals(actionType)) {
			Utente_Bean newUser = new Utente_Bean();
			newUser.setNome(request.getParameter("nome"));
			newUser.setCognome(request.getParameter("cognome"));
			newUser.setEmail(email);
			newUser.setPassword(password);
			newUser.setIndirizzo(request.getParameter("indirizzo"));
			newUser.setDataNascita(request.getParameter("dataNascita"));
			
			boolean signupSuccess = dao.salvaUtente(newUser);
			
			if(signupSuccess) {
				request.setAttribute("registeredUser", newUser);
				RequestDispatcher dispatcher = request.getRequestDispatcher("view/registrazione_completata.jsp");
				dispatcher.forward(request, response);
			} else {
				response.sendRedirect("index.html?signup_error=true");
			}
			}
		}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
