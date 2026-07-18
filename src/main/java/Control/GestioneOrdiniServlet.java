package Control;

import DAO.*;
import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class GestioneOrdiniServlet
 */
@WebServlet("/GestioneOrdiniServlet")
public class GestioneOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneOrdiniServlet() {
        super();
        // TODO Auto-generated constructor stub
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
		
		if ("carrello".equals(azione)) {
			
		
		int codiceViaggio= Integer.parseInt(request.getParameter("codiceViaggio"));
		int numPosti= Integer.parseInt(request.getParameter("numPosti"));
		String dataPartenza= request.getParameter("dataPartenza");
		
		ViaggioDAO dao = new ViaggioDAO();
		Viaggio_Bean viaggio= dao.getViaggioById(codiceViaggio);
		
		HttpSession session = request.getSession();
		
		Carrello_Bean carrello = (Carrello_Bean) session.getAttribute("carrello");
		
		if(carrello == null) carrello = new Carrello_Bean();
		
		ElementoCarrello_Bean elemento= new ElementoCarrello_Bean(viaggio, dataPartenza, numPosti);
		carrello.aggiungiElemento(elemento);
		
		session.setAttribute("carrello", carrello);
		response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
	} else if("checkout".equals(azione)){
		//futuro codice per il database
		}
	}
}
