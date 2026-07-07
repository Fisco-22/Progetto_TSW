package Model;

import java.io.Serializable;

public class Utente_Bean implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private int id; 
	private String nome;
	private String cognome;
	private String email;
	private String password;
	private String indirizzo;
	private String dataNascita;
	private String[] telefoni; 
	private boolean admin; 
    
	public Utente_Bean() {}

	// --- GETTER E SETTER ---

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String[] getTelefoni() {
		return telefoni;
	}

	public void setTelefoni(String[] telefoni) {
		this.telefoni = telefoni;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
}