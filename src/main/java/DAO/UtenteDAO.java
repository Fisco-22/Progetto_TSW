package DAO;

import Model.Utente_Bean;

public class UtenteDAO {
	public Utente_Bean checkLogin(String email, String password) {
        
        // Simulazione per i test:
        if ("utente@travel.it".equals(email) && "password123".equals(password)) {
            Utente_Bean user = new Utente_Bean();
            user.setNome("Mario");
            user.setCognome("Rossi");
            user.setEmail(email);
            return user;
        }
        return null; // Credenziali errate
    }

    /**
     * Registra un nuovo utente nel database
     */
    public boolean salvaUtente(Utente_Bean user) {
        // In produzione: PreparedStatement ps = con.prepareStatement("INSERT INTO...");
        // Simulazione di salvataggio riuscito:
        return user != null && user.getEmail() != null && !user.getEmail().isEmpty();
    }
}

