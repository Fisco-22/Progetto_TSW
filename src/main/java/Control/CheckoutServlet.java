package Control;

import DAO.OrdineDAO;
import Model.Carrello_Bean;
import Model.DettaglioOrdine_Bean;
import Model.ElementoCarrello_Bean;
import Model.Ordine_Bean;
import Model.Utente_Bean;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private OrdineDAO dao;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
		dao = new OrdineDAO(ds);
	}

	// GET: mostra il form di checkout (solo utenti loggati con carrello non vuoto)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("utente") == null) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}
		Carrello_Bean carrello = (Carrello_Bean) session.getAttribute("carrello");
		if (carrello == null || carrello.getNumeroElementi() == 0) {
			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;
		}
		request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
	}

	// POST: conferma l'ordine
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("utente") == null) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}
		Utente_Bean utente = (Utente_Bean) session.getAttribute("utente");
		Carrello_Bean carrello = (Carrello_Bean) session.getAttribute("carrello");
		if (carrello == null || carrello.getNumeroElementi() == 0) {
			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;
		}

		String indirizzo = request.getParameter("indirizzoSpedizione");
		String metodoPagamento = request.getParameter("metodoPagamento");
		String numeroCarta = request.getParameter("numeroCarta");

		// Nel DB non va MAI il numero completo: solo le ultime 4 cifre
		String ultime4 = null;
		if (numeroCarta != null) {
			String soloCifre = numeroCarta.replaceAll("\\D", "");
			if (soloCifre.length() >= 4) ultime4 = soloCifre.substring(soloCifre.length() - 4);
		}

		// Costruzione dell'ordine: SNAPSHOT del carrello (prezzi attuali diventano storici)
		Ordine_Bean ordine = new Ordine_Bean();
		ordine.setEmailUtente(utente.getEmail());
		ordine.setIndirizzoSpedizione(indirizzo);
		ordine.setMetodoPagamento(metodoPagamento);
		ordine.setUltime4Cifre(ultime4);

		double totale = 0;
		for (ElementoCarrello_Bean e : carrello.getElementi()) {
			DettaglioOrdine_Bean d = new DettaglioOrdine_Bean();
			d.setCodiceViaggio(e.getViaggio().getCodiceViaggio());
			d.setDestinazione(e.getViaggio().getDestinazione());
			d.setPrezzoAcquisto(e.getViaggio().getCostoTotale()); // prezzo congelato qui
			d.setDataPartenza(e.getDataPartenza());
			d.setNumPosti(e.getNumPosti());
			ordine.aggiungiDettaglio(d);
			totale += d.getSubtotale();
		}
		ordine.setTotaleOrdine(totale);

		int codiceOrdine = dao.salvaOrdine(ordine);

		if (codiceOrdine > 0) {
			// Requisito: a ordine confermato il carrello va svuotato
			session.removeAttribute("carrello");
			response.sendRedirect(request.getContextPath() + "/AreaPersonaleServlet");
		} else {
			request.setAttribute("messaggioErrore", "Errore durante il salvataggio dell'ordine. Riprova.");
			request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
		}
	}
}