package control;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * All'avvio dell'applicazione recupera il DataSource dal JNDI di Tomcat
 * (una sola volta) e lo mette nel ServletContext con chiave "DataSource".
 * Le servlet lo leggono nel loro init() e lo iniettano nei DAO.
 */
@WebListener
public class DataSourceListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("jdbc/travelbooking");
			sce.getServletContext().setAttribute("DataSource", ds);
		} catch (NamingException e) {
			throw new RuntimeException("Impossibile recuperare il DataSource dal JNDI", e);
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		sce.getServletContext().removeAttribute("DataSource");
	}
}
