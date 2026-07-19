package Control;

import DAO.*;
import Model.*;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;

/**
 * Servlet implementation class GestioneOrdiniServlet
 */
@WebServlet("/GestioneOrdiniServlet")
public class GestioneOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ViaggioDAO dao;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
		dao = new ViaggioDAO(ds);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String azione = request.getParameter("azione");

		HttpSession session = request.getSession();
		Carrello_Bean carrello = (Carrello_Bean) session.getAttribute("carrello");
		if (carrello == null) {
			carrello = new Carrello_Bean();
			session.setAttribute("carrello", carrello);
		}

		try {
			if ("carrello".equals(azione)) {
				// Aggiunta di un viaggio al carrello
				int codiceViaggio = Integer.parseInt(request.getParameter("codiceViaggio"));
				int numPosti = Integer.parseInt(request.getParameter("numPosti"));
				String dataPartenza = request.getParameter("dataPartenza");

				Viaggio_Bean viaggio = dao.getViaggioById(codiceViaggio);
				if (viaggio != null && dataPartenza != null && !dataPartenza.isEmpty() && numPosti > 0) {
					carrello.aggiungiElemento(new ElementoCarrello_Bean(viaggio, dataPartenza, numPosti));
				}

			} else if ("aggiorna".equals(azione)) {
				// Variazione della quantità (numero posti) di un elemento
				int codiceViaggio = Integer.parseInt(request.getParameter("codiceViaggio"));
				int numPosti = Integer.parseInt(request.getParameter("numPosti"));
				String dataPartenza = request.getParameter("dataPartenza");
				carrello.aggiornaQuantita(codiceViaggio, dataPartenza, numPosti);

			} else if ("rimuovi".equals(azione)) {
				// Rimozione di un singolo elemento
				int codiceViaggio = Integer.parseInt(request.getParameter("codiceViaggio"));
				String dataPartenza = request.getParameter("dataPartenza");
				carrello.rimuoviElemento(codiceViaggio, dataPartenza);

			} else if ("svuota".equals(azione)) {
				// Svuotamento completo del carrello
				carrello.svuota();
			}
		} catch (NumberFormatException e) {
			// Parametri malformati: nessuna modifica al carrello, si torna alla pagina
		}

		response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
	}
}
