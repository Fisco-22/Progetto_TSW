package dao;

import model.Viaggio_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

public class ViaggioDAO {

	private DataSource ds;

	// Il DataSource viene iniettato dalla servlet (recuperato dal ServletContext)
	public ViaggioDAO(DataSource ds) {
		this.ds = ds;
	}

	private Connection getConnection() throws SQLException {
		return ds.getConnection();
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
	
	// ===== CRUD per l'area amministratore =====

	public boolean salvaViaggio(Viaggio_Bean v) {
		String query = "INSERT INTO VIAGGIO (Destinazione, Descrizione, Immagine_URL, Costo_Totale, n_posti, Email_Admin) VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
			ps.setString(1, v.getDestinazione());
			ps.setString(2, v.getDescrizione());
			ps.setString(3, v.getImmagineUrl());
			ps.setFloat(4, v.getCostoTotale());
			ps.setInt(5, v.getnPosti());
			ps.setString(6, v.getEmailAdmin());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean aggiornaViaggio(Viaggio_Bean v) {
		String query = "UPDATE VIAGGIO SET Destinazione = ?, Descrizione = ?, Immagine_URL = ?, Costo_Totale = ?, n_posti = ? WHERE Codice_Viaggio = ?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
			ps.setString(1, v.getDestinazione());
			ps.setString(2, v.getDescrizione());
			ps.setString(3, v.getImmagineUrl());
			ps.setFloat(4, v.getCostoTotale());
			ps.setInt(5, v.getnPosti());
			ps.setInt(6, v.getCodiceViaggio());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean cancellaViaggio(int codiceViaggio) {
		// Grazie a ON DELETE SET NULL su DETTAGLIO_ORDINE, gli ordini passati NON vengono toccati
		String query = "DELETE FROM VIAGGIO WHERE Codice_Viaggio = ?";
		try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
			ps.setInt(1, codiceViaggio);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Viaggio_Bean> getAllViaggi(){
		List<Viaggio_Bean> viaggi= new ArrayList<>();
		String query= "SELECT * FROM VIAGGIO";
		
		try(Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				
				Viaggio_Bean viaggio = new Viaggio_Bean();
				viaggio.setCodiceViaggio(rs.getInt("Codice_Viaggio"));
                viaggio.setDestinazione(rs.getString("Destinazione"));
                viaggio.setDescrizione(rs.getString("Descrizione"));
                viaggio.setImmagineUrl(rs.getString("Immagine_URL"));
                viaggio.setCostoTotale(rs.getFloat("Costo_Totale"));
                viaggio.setnPosti(rs.getInt("n_posti"));
                viaggio.setEmailAdmin(rs.getString("Email_Admin"));
                
                viaggi.add(viaggio);
			}
		} catch (SQLException e) {
		e.printStackTrace();
	}
		return viaggi;
}	
}
