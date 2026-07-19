package Control;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;

import DAO.UtenteDAO;
import Model.Utente_Bean;
/**
 * Servlet implementation class RegistrazioneServlet
 */
@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UtenteDAO dao;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
		dao = new UtenteDAO(ds);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 2. Recuperiamo tutti i dati testuali (inclusi i nuovi due!)
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String indirizzo = request.getParameter("indirizzo");
		String dataNascita = request.getParameter("dataNascita");
		
		String[] telefoni = request.getParameterValues("telefono");

		// --- DEBUG IN CONSOLE (Aggiornato per vedere se arrivano) ---
		System.out.println("--- NUOVA RICHIESTA DI REGISTRAZIONE ---");
		System.out.println("Nome: " + nome + " | Cognome: " + cognome);
		System.out.println("Email: " + email + " | Indirizzo: " + indirizzo + " | Data Nascita: " + dataNascita);
		// -----------------------------------------------------------

		Utente_Bean utenteTemp = new Utente_Bean();
		utenteTemp.setNome(nome);
		utenteTemp.setCognome(cognome);
		utenteTemp.setEmail(email);
		utenteTemp.setPassword(password); // FONDAMENTALE passarla al DAO!
		utenteTemp.setIndirizzo(indirizzo);
		utenteTemp.setDataNascita(dataNascita);
		utenteTemp.setTelefoni(telefoni);

		// 5. CHIAMATA AL DAO (istanza creata in init() col DataSource iniettato)
		boolean successo = dao.salvaUtente(utenteTemp);
		
		// 6. GESTIONE DEL RISULTATO
		if (successo) {
			request.setAttribute("registeredUser", utenteTemp);
			request.getRequestDispatcher("/WEB-INF/view/registrazione_completata.jsp").forward(request, response);
		} else {
			request.setAttribute("messaggioErrore", "Errore durante la registrazione. L'email potrebbe essere già registrata.");
			request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
		}
	}

	}


