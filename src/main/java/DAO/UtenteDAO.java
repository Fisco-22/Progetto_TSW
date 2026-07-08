package DAO;

import Model.Utente_Bean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class UtenteDAO {
	
	private String hashPassword(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
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

    // 1. METODO PER OTTENERE LA CONNESSIONE DAL DATASOURCE
    private Connection getConnection() throws SQLException {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            // Deve coincidere con il res-ref-name del tuo web.xml e name del context.xml
            DataSource ds = (DataSource) envCtx.lookup("jdbc/travelbooking");
            return ds.getConnection();
        } catch (NamingException e) {
            throw new SQLException("Errore nel recupero del DataSource", e);
        }
    }

    /**
     * 2. METODO PER IL LOGIN REALE
     * Controlla le credenziali e recupera i dati dell'utente, inclusi i telefoni.
     */
    public Utente_Bean checkLogin(String email, String passwordInChiaro) {
        Utente_Bean user = null;
        
        String passwordCriptata = hashPassword(passwordInChiaro);
        // Query scritte con i nomi esatti delle tue colonne SQL
        String queryUtente = "SELECT * FROM UTENTE WHERE Email = ? AND Password = ?";
        String queryTelefoni = "SELECT Numero_Telefono FROM TELEFONO_UTENTE WHERE Email_Utente = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(queryUtente)) {
            
            ps.setString(1, email);
            ps.setString(2, passwordCriptata);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Se l'utente esiste, creiamo il Bean e lo riempiamo coi dati del DB
                    user = new Utente_Bean();
                    user.setEmail(rs.getString("Email"));
                    user.setNome(rs.getString("Nome"));
                    user.setCognome(rs.getString("Cognome"));
                    user.setIndirizzo(rs.getString("Indirizzo"));
                    user.setDataNascita(rs.getString("Data_Nascita"));
                    user.setRuolo(rs.getString("Ruolo")); // Recupera se è 'utente' o 'admin'
                    
                    // SUB-QUERY: Recuperiamo anche tutti i suoi numeri di telefono
                    try (PreparedStatement psTel = con.prepareStatement(queryTelefoni)) {
                        psTel.setString(1, email);
                        try (ResultSet rsTel = psTel.executeQuery()) {
                            List<String> listatelefoni = new ArrayList<>();
                            while (rsTel.next()) {
                                listatelefoni.add(rsTel.getString("Numero_Telefono"));
                            }
                            // Convertiamo la lista dinamica nell'array richiesto dal Bean
                            user.setTelefoni(listatelefoni.toArray(new String[0]));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user; // Ritorna null se email/password sono errate
    }

    /**
     * 3. METODO PER LA REGISTRAZIONE REALE
     * Salva l'utente e i suoi telefoni usando una Transazione (sicurezza ACID)
     */
    public boolean salvaUtente(Utente_Bean user) {
        String insertUtente = "INSERT INTO UTENTE (Email, Nome, Cognome, Password, Ruolo, Data_Nascita, Indirizzo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertTelefono = "INSERT INTO TELEFONO_UTENTE (Email_Utente, Numero_Telefono) VALUES (?, ?)";
        
        Connection con = null;
        
        try {
            con = getConnection();
            // Disabilitiamo l'autocommit per gestire la transazione manualmente
            con.setAutoCommit(false); 
            
            // FASE 1: Inserimento nella tabella UTENTE
            try (PreparedStatement psUtente = con.prepareStatement(insertUtente)) {
                psUtente.setString(1, user.getEmail());
                psUtente.setString(2, user.getNome());
                psUtente.setString(3, user.getCognome());
                String passwordCriptata = hashPassword(user.getPassword());
                psUtente.setString(4, passwordCriptata);
                psUtente.setString(5, "utente"); // Di default chi si registra dal sito è un utente standard
                psUtente.setString(6, user.getDataNascita());
                psUtente.setString(7, user.getIndirizzo());
                
                int righeColpite = psUtente.executeUpdate();
                if (righeColpite == 0) {
                    con.rollback(); // Qualcosa è andato storto, annulla
                    return false;
                }
            }
            
            // FASE 2: Inserimento dei telefoni multipli (se presenti)
            if (user.getTelefoni() != null && user.getTelefoni().length > 0) {
                try (PreparedStatement psTelefoni = con.prepareStatement(insertTelefono)) {
                    for (String tel : user.getTelefoni()) {
                        // Evitiamo di salvare spazi vuoti se l'utente ha cliccato "aggiungi" senza scrivere nulla
                        if (tel != null && !tel.trim().isEmpty()) { 
                            psTelefoni.setString(1, user.getEmail());
                            psTelefoni.setString(2, tel);
                            psTelefoni.executeUpdate();
                        }
                    }
                }
            }
            
            // Se le due fasi si completano senza errori, salviamo definitivamente sul DB!
            con.commit();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Se c'è un errore (es. email già esistente), eseguiamo il rollback per non lasciare dati orfani
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            // Pulizia e chiusura della connessione (evita memory leak su Tomcat)
            if (con != null) {
                try { 
                    con.setAutoCommit(true); 
                    con.close(); 
                } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}