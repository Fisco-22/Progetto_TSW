package Control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import DAO.OrdineDAO;
import Model.Ordine_Bean;
import Model.Utente_Bean;

@WebServlet("/AreaPersonaleServlet")
public class AreaPersonaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("utente") == null) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}

		// Carica lo storico ordini dell'utente per la JSP
		Utente_Bean utente = (Utente_Bean) session.getAttribute("utente");
		OrdineDAO ordineDAO = new OrdineDAO();
		List<Ordine_Bean> ordini = ordineDAO.getOrdiniByUtente(utente.getEmail());
		request.setAttribute("ordini", ordini);

		request.getRequestDispatcher("/WEB-INF/view/Area_Personale.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
