package Model;

public class DettaglioOrdine_Bean {
private int idDettaglio;
private int codiceOrdine;
private Integer codiceViaggio;
private String destinazione;
private double prezzoAcquisto;
private String dataPartenza;
private int numPosti;

public DettaglioOrdine_Bean() {
	
}

public int getIdDettaglio() {
	return idDettaglio;
}

public void setIdDettaglio(int idDettaglio) {
	this.idDettaglio = idDettaglio;
}

public int getCodiceOrdine() {
	return codiceOrdine;
}

public void setCodiceOrdine(int codiceOrdine) {
	this.codiceOrdine = codiceOrdine;
}

public Integer getCodiceViaggio() {
	return codiceViaggio;
}

public void setCodiceViaggio(Integer codiceViaggio) {
	this.codiceViaggio = codiceViaggio;
}

public String getDestinazione() {
	return destinazione;
}

public void setDestinazione(String destinazione) {
	this.destinazione = destinazione;
}

public double getPrezzoAcquisto() {
	return prezzoAcquisto;
}

public void setPrezzoAcquisto(double prezzoAcquisto) {
	this.prezzoAcquisto = prezzoAcquisto;
}

public String getDataPartenza() {
	return dataPartenza;
}

public void setDataPartenza(String dataPartenza) {
	this.dataPartenza = dataPartenza;
}

public int getNumPosti() {
	return numPosti;
}

public void setNumPosti(int numPosti) {
	this.numPosti = numPosti;
}

public double getSubtotale() {
	return prezzoAcquisto*numPosti;
}


}
