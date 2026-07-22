package control;

import dao.OrdineDAO;
import dao.ViaggioDAO;
import model.Ordine_Bean;
import model.Utente_Bean;
import model.Viaggio_Bean;

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

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ViaggioDAO viaggioDAO;
	private OrdineDAO ordineDAO;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		if (ds == null) throw new ServletException("DataSource non disponibile nel ServletContext");
		viaggioDAO = new ViaggioDAO(ds);
		ordineDAO = new OrdineDAO(ds);
	}

	private boolean isAdmin(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("token") == null) return false;
		Utente_Bean u = (Utente_Bean) session.getAttribute("utente");
		return u != null && "admin".equals(u.getRuolo());
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request)) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}

		String azione = request.getParameter("azione");
		try {
			if ("ordiniPeriodo".equals(azione)) {
				String dataInizio = request.getParameter("dataInizio");
				String dataFine = request.getParameter("dataFine");
				if (dataInizio != null && !dataInizio.isEmpty() && dataFine != null && !dataFine.isEmpty()) {
					List<Ordine_Bean> ordini = ordineDAO.getOrdiniByPeriodo(dataInizio, dataFine);
					request.setAttribute("ordiniRicerca", ordini);
					request.setAttribute("criterioRicerca", "dal " + dataInizio + " al " + dataFine);
				}
			} else if ("ordiniCliente".equals(azione)) {
				String emailCliente = request.getParameter("emailCliente");
				if (emailCliente != null && !emailCliente.isEmpty()) {
					List<Ordine_Bean> ordini = ordineDAO.getOrdiniByUtente(emailCliente);
					request.setAttribute("ordiniRicerca", ordini);
					request.setAttribute("criterioRicerca", "cliente " + emailCliente);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("catalogo", viaggioDAO.getAllViaggi());
		request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request)) {
			response.sendRedirect(request.getContextPath() + "/RegistrazioneServlet");
			return;
		}
		request.setCharacterEncoding("UTF-8");
		String azione = request.getParameter("azione");

		try {
			if ("inserisci".equals(azione)) {
				Viaggio_Bean v = leggiViaggio(request);
				Utente_Bean admin = (Utente_Bean) request.getSession(false).getAttribute("utente");
				v.setEmailAdmin(admin.getEmail());
				viaggioDAO.salvaViaggio(v);

			} else if ("modifica".equals(azione)) {
				Viaggio_Bean v = leggiViaggio(request);
				v.setCodiceViaggio(Integer.parseInt(request.getParameter("codiceViaggio")));
				viaggioDAO.aggiornaViaggio(v);

			} else if ("cancella".equals(azione)) {
				int codice = Integer.parseInt(request.getParameter("codiceViaggio"));
				viaggioDAO.cancellaViaggio(codice);
			}
		} catch (NumberFormatException e) {
			
		}

		// Post-Redirect-Get
		response.sendRedirect(request.getContextPath() + "/AdminServlet");
	}

	private Viaggio_Bean leggiViaggio(HttpServletRequest request) {
		Viaggio_Bean v = new Viaggio_Bean();
		v.setDestinazione(request.getParameter("destinazione"));
		v.setDescrizione(request.getParameter("descrizione"));
		v.setImmagineUrl(request.getParameter("immagineUrl"));
		v.setCostoTotale(Float.parseFloat(request.getParameter("costoTotale")));
		v.setnPosti(Integer.parseInt(request.getParameter("nPosti")));
		return v;
	}
}
