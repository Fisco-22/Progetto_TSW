package control;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;

import model.Viaggio_Bean;
import dao.ViaggioDAO;
/**
 * Servlet implementation class DettaglioServlet
 */
@WebServlet("/DettaglioServlet")
public class DettaglioServlet extends HttpServlet {
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
		
		String idParam = request.getParameter("id");
		
		if(idParam != null && !idParam.isEmpty()) {
			try {
				int codiceViaggio = Integer.parseInt(idParam);

				Viaggio_Bean viaggio = dao.getViaggioById(codiceViaggio);
				
				if(viaggio != null) {
					request.setAttribute("viaggio", viaggio);
					request.getRequestDispatcher("/WEB-INF/view/dettaglio_Viaggio.jsp").forward(request, response);
                    return;
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect(request.getContextPath() + "/HomeServlet");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
