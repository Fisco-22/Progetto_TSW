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
			
			try(ResultSet rs = ps.getGeneratedKeys()){
				if(!rs.next()) {
					con.rollback();
					return -1;
				}
				codiceOrdine = rs.getInt(1);
			}
		}
		
		try(PreparedStatement ps = con.prepareStatement(insertDettaglio)){
			for(DettaglioOrdine_Bean d:ordine.getDettagli()) {
				ps.setInt(1, codiceOrdine);
				if(d.getCodiceViaggio() != null) {
					ps.setInt(2, d.getCodiceViaggio());
				} else {
					ps.setNull(2, java.sql.Types.INTEGER);
				}
				ps.setString(3, d.getDestinazione());
				ps.setDouble(4, d.getPrezzoAcquisto());
				ps.setString(5, d.getDataPartenza());
				ps.setInt(6, d.getNumPosti());
				ps.executeUpdate();
			}
		}
		
		con.commit();
		return codiceOrdine;
	} catch (SQLException e) {
		e.printStackTrace();
		if(con!= null) {
			try {
				con.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			
		}
		return -1;
	} finally {
		if(con != null) {
			try {
				con.setAutoCommit(true);
				con.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}

public List<Ordine_Bean> getOrdiniByUtente(String email){
	List<Ordine_Bean> ordini = new ArrayList<>();
	String query = "SELECT * FROM ORDINE WHERE Email_Utente = ? ORDER BY Data_Ordine DESC";
	
	try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
		ps.setString(1, email);
		try (ResultSet rs = ps.executeQuery()){
			while(rs.next()) {
				Ordine_Bean o = mappaOrdine(rs);
				caricaDettaglio(con, o);
				ordini.add(o);
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return ordini;
}

public List<Ordine_Bean> getOrdiniByPeriodo(String dataInizio, String dataFine){
	List<Ordine_Bean> ordini = new ArrayList<>();
	String query ="SELECT * FROM ORDINE WHERE DATE(Data_Ordine) BETWEEN ? AND ? ORDER BY Data_Ordine DESC";
	
	try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)){
		ps.setString(1, dataInizio);
		ps.setString(2, dataFine);
		try (ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Ordine_Bean o = mappaOrdine(rs);
				caricaDettaglio(con, o);
				ordini.add(o);
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return ordini;
	}

private Ordine_Bean mappaOrdine(ResultSet rs) throws SQLException {
	Ordine_Bean o = new Ordine_Bean();
	o.setCodiceOrdine(rs.getInt("Codice_Ordine"));
	o.setEmailUtente(rs.getString("Email_Utente"));
	o.setDataOrdine(rs.getString("Data_Ordine"));
	o.setTotaleOrdine(rs.getDouble("Totale_Ordine"));
	o.setIndirizzoSpedizione(rs.getString("Indirizzo_Spedizione"));
	o.setMetodoPagamento(rs.getString("Metodo_Pagamento"));
	o.setUltime4Cifre(rs.getString("Ultime4Cifre"));
	o.setStato(rs.getString("Stato"));
	return o;
}

private void caricaDettaglio(Connection con, Ordine_Bean ordine) throws SQLException{
	String query = "SELECT * FROM DETTAGLIO_ORDINE WHERE Codice_Ordine = ?";
	try (PreparedStatement ps = con.prepareStatement(query)) {
		ps.setInt(1, ordine.getCodiceOrdine());
		try (ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				DettaglioOrdine_Bean d = new DettaglioOrdine_Bean();
				d.setIdDettaglio(rs.getInt("ID_Dettaglio"));
				d.setCodiceOrdine(rs.getInt("Codice_Ordine"));
				int cv = rs.getInt("Codice_Viaggio");
				d.setCodiceViaggio(rs.wasNull() ? null : cv);
				d.setDestinazione(rs.getString("Destinazione"));
				d.setPrezzoAcquisto(rs.getDouble("Prezzo_Acquisto"));
				d.setDataPartenza(rs.getString("Data_Partenza"));
				d.setNumPosti(rs.getInt("Num_Posti"));
				ordine.aggiungiDettaglio(d);
			}
		}
	}
}
}
