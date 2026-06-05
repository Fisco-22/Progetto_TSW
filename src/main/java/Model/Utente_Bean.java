package Model;

import java.io.Serializable;

public class Utente_Bean implements Serializable{
	private static final long serialVersionUID = 1L;

    private String nome;
    private String cognome;
    private String email;
    private String password;
    private String indirizzo;
    private String dataNascita;
    private boolean newsletter;
}
