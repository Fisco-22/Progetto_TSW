package dao;

import model.Utente_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class UtenteDAO {

	private DataSource ds;

	public UtenteDAO(DataSource ds) {
		this.ds = ds;
	}

	private String hashPassword(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-512");
            byte[] hash = digest.digest(base.getBytes(StandardCharsets.UTF_8));
            
            StringBuilder hexString = new StringBuilder(2 * hash.length);
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Errore critico nel calcolo dell'hash", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    public Utente_Bean checkLogin(String email, String passwordInChiaro) {
        Utente_Bean user = null;
        
        String passwordCriptata = hashPassword(passwordInChiaro);
        String queryUtente = "SELECT * FROM UTENTE WHERE Email = ? AND Password = ?";
        String queryTelefoni = "SELECT Numero_Telefono FROM TELEFONO_UTENTE WHERE Email_Utente = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(queryUtente)) {
            
            ps.setString(1, email);
            ps.setString(2, passwordCriptata);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Utente_Bean();
                    user.setEmail(rs.getString("Email"));
                    user.setNome(rs.getString("Nome"));
                    user.setCognome(rs.getString("Cognome"));
                    user.setIndirizzo(rs.getString("Indirizzo"));
                    user.setDataNascita(rs.getString("Data_Nascita"));
                    user.setRuolo(rs.getString("Ruolo"));
                    
                    try (PreparedStatement psTel = con.prepareStatement(queryTelefoni)) {
                        psTel.setString(1, email);
                        try (ResultSet rsTel = psTel.executeQuery()) {
                            List<String> listatelefoni = new ArrayList<>();
                            while (rsTel.next()) {
                                listatelefoni.add(rsTel.getString("Numero_Telefono"));
                            }
                            user.setTelefoni(listatelefoni.toArray(new String[0]));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user; 
    }

    public boolean salvaUtente(Utente_Bean user) {
        String insertUtente = "INSERT INTO UTENTE (Email, Nome, Cognome, Password, Ruolo, Data_Nascita, Indirizzo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertTelefono = "INSERT INTO TELEFONO_UTENTE (Email_Utente, Numero_Telefono) VALUES (?, ?)";
        
        Connection con = null;
        
        try {
            con = getConnection();
            con.setAutoCommit(false); 

            try (PreparedStatement psUtente = con.prepareStatement(insertUtente)) {
                psUtente.setString(1, user.getEmail());
                psUtente.setString(2, user.getNome());
                psUtente.setString(3, user.getCognome());
                String passwordCriptata = hashPassword(user.getPassword());
                psUtente.setString(4, passwordCriptata);
                psUtente.setString(5, "utente");
                psUtente.setString(6, user.getDataNascita());
                psUtente.setString(7, user.getIndirizzo());
                
                int righeColpite = psUtente.executeUpdate();
                if (righeColpite == 0) {
                    con.rollback();
                    return false;
                }
            }
            
            // FASE 2: Inserimento dei telefoni multipli (se presenti)
            if (user.getTelefoni() != null && user.getTelefoni().length > 0) {
                try (PreparedStatement psTelefoni = con.prepareStatement(insertTelefono)) {
                    for (String tel : user.getTelefoni()) {
                        if (tel != null && !tel.trim().isEmpty()) { 
                            psTelefoni.setString(1, user.getEmail());
                            psTelefoni.setString(2, tel);
                            psTelefoni.executeUpdate();
                        }
                    }
                }
            }
            
            con.commit();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            if (con != null) {
                try { 
                    con.setAutoCommit(true); 
                    con.close(); 
                } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}