package Control;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

import DAO.OrdineDAO;
import Model.Ordine_Bean;
import Model.Utente_Bean;

@WebServlet("/AreaPersonaleServlet")
public class AreaPersonaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private OrdineDAO ordineDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
		ordineDAO = new OrdineDAO(ds);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("utente") == null) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}

		// Carica lo storico ordini dell'utente per la JSP
		Utente_Bean utente = (Utente_Bean) session.getAttribute("utente");
		List<Ordine_Bean> ordini = ordineDAO.getOrdiniByUtente(utente.getEmail());
		request.setAttribute("ordini", ordini);

		request.getRequestDispatcher("/WEB-INF/view/Area_Personale.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
