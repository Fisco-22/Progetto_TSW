package DAO;

import Model.Viaggio_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ViaggioDAO {
	
	private Connection getConnection() throws SQLException {
		try {
			Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/travelbooking");
            return ds.getConnection();
		} catch(Exception e) {
			throw new SQLException("Errore DataSource", e);
		}
	}
	public Viaggio_Bean getViaggioById (int codiceViaggio) {
		Viaggio_Bean viaggio = null;
		String query = "SELECT * FROM VIAGGIO WHERE Codice_Viaggio = ?";
		
		try (Connection con = getConnection(); PreparedStatement ps= con.prepareStatement(query)) {
			ps.setInt(1, codiceViaggio);
			
			try(ResultSet rs=ps.executeQuery()) {
				if(rs.next()) {
					viaggio	= new Viaggio_Bean();
					viaggio.setCodiceViaggio(rs.getInt("Codice_Viaggio"));
                    viaggio.setDestinazione(rs.getString("Destinazione"));
                    viaggio.setDescrizione(rs.getString("Descrizione"));
                    viaggio.setImmagineUrl(rs.getString("Immagine_URL"));
                    viaggio.setCostoTotale(rs.getFloat("Costo_Totale"));
                    viaggio.setnPosti(rs.getInt("n_posti"));
                    viaggio.setEmailAdmin(rs.getString("Email_Admin"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return viaggio; 
	}
}
