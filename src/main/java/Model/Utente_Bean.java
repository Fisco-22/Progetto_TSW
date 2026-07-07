package Model;

import java.io.Serializable;

public class Utente_Bean implements Serializable {
	private static final long serialVersionUID = 1L;

	// Nessun "id" numerico! La vera chiave primaria per te è l'Email
	private String email;
	private String nome;
	private String cognome;
	private String password;
	private String indirizzo;
	private String dataNascita;
	
	// Il ruolo che nel database è ENUM('utente', 'admin')
	private String ruolo; 
	
	// Array per i numeri dinamici
	private String[] telefoni; 
    
	public Utente_Bean() {}

	// --- GETTER E SETTER ---
	public String getEmail() {
		return email; 
	}
	public void setEmail(String email) {
		this.email = email; 
	}

	public String getNome() {
		return nome; 
	}
	public void setNome(String nome) { 
		this.nome = nome; 
	}

	public String getCognome() { 
		return cognome; 
	}
	public void setCognome(String cognome) { 
		this.cognome = cognome; 
	}

	public String getPassword() { 
		return password; 
	}
	public void setPassword(String password) { 
		this.password = password; 
	}

	public String getIndirizzo() { 
		return indirizzo; 
	}
	public void setIndirizzo(String indirizzo) { 
		this.indirizzo = indirizzo; 
	}

	public String getDataNascita() { 
		return dataNascita; 
	}
	public void setDataNascita(String dataNascita) { 
		this.dataNascita = dataNascita; 
	}

	public String getRuolo() { 
		return ruolo; 
	}
	public void setRuolo(String ruolo) { 
		this.ruolo = ruolo; 
	}

	public String[] getTelefoni() { 
		return telefoni; 
	}
	public void setTelefoni(String[] telefoni) { 
		this.telefoni = telefoni; 
	}
}