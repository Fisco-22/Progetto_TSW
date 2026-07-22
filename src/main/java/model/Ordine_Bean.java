package model;

import java.util.ArrayList;
import java.util.List;

public class Ordine_Bean {
private int codiceOrdine;
private String emailUtente;
private String dataOrdine;
private double totaleOrdine;
private String indirizzoSpedizione;
private String metodoPagamento;
private String ultime4Cifre;
private String stato;
private List<DettaglioOrdine_Bean> dettagli = new ArrayList<>();

public Ordine_Bean() {

}

public int getCodiceOrdine() {
	return codiceOrdine;
}

public void setCodiceOrdine(int codiceOrdine) {
	this.codiceOrdine = codiceOrdine;
}

public String getEmailUtente() {
	return emailUtente;
}

public void setEmailUtente(String emailUtente) {
	this.emailUtente = emailUtente;
}

public String getDataOrdine() {
	return dataOrdine;
}

public void setDataOrdine(String dataOrdine) {
	this.dataOrdine = dataOrdine;
}

public double getTotaleOrdine() {
	return totaleOrdine;
}

public void setTotaleOrdine(double totaleOrdine) {
	this.totaleOrdine = totaleOrdine;
}

public String getIndirizzoSpedizione() {
	return indirizzoSpedizione;
}

public void setIndirizzoSpedizione(String indirizzoSpedizione) {
	this.indirizzoSpedizione = indirizzoSpedizione;
}

public String getMetodoPagamento() {
	return metodoPagamento;
}

public void setMetodoPagamento(String metodoPagamento) {
	this.metodoPagamento = metodoPagamento;
}

public String getUltime4Cifre() {
	return ultime4Cifre;
}

public void setUltime4Cifre(String ultime4Cifre) {
	this.ultime4Cifre = ultime4Cifre;
}

public String getStato() {
	return stato;
}

public void setStato(String stato) {
	this.stato = stato;
}

public List<DettaglioOrdine_Bean> getDettagli() {
	return dettagli;
}

public void setDettagli(List<DettaglioOrdine_Bean> dettagli) {
	this.dettagli = dettagli;
}

public void aggiungiDettaglio(DettaglioOrdine_Bean d) {
	dettagli.add(d);
}
}

