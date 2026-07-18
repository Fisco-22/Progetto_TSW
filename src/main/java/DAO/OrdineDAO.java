package DAO;
import Model.Ordine_Bean;
import Model.DettaglioOrdine_Bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrdineDAO {
private Connection getConnection() throws SQLException{

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/travelbooking");
		return ds.getConnection();
	} catch (NamingException e){
		throw new SQLException("Errore nel recupero del DataSource", e);
	}
}

public int salvaOrdine(Ordine_Bean ordine) {
	String insertOrdine = "INSERT INTO ORDINE (Email_Utente, Totale_Ordine, Indirizzo_Spedizione, Metodo_Pagamento, Ultime4Cifre) VALUES (?, ?, ?, ?, ?)";
	String insertDettaglio = "INSERT INTO DETTAGLIO_ORDINE (Codice_Ordine, Codice_Viaggio, Destinazione, Prezzo_Acquisto, Data_Partenza, Num_Posti) VALUES (?, ?, ?, ?, ?, ?)";
	
	Connection con = null;
	try {
		con = getConnection();
		con.setAutoCommit(false);
		
		int codiceOrdine;
		try(PreparedStatement ps = con.prepareStatement(insertOrdine, Statement.RETURN_GENERATED_KEYS)){
			ps.setString(1, ordine.getEmailUtente());
			ps.setDouble(2, ordine.getTotaleOrdine());
			ps.setString(3, ordine.getIndirizzoSpedizione());
			ps.setString(4, ordine.getMetodoPagamento());
			ps.setString(5, ordine.getUltime4Cifre());
			ps.executeUpdate();
			
		}
	}
}
}
