package Model;

import java.util.ArrayList;
import java.util.List;

public class Carrello_Bean {

	private List<ElementoCarrello_Bean> elementi;
	
	public Carrello_Bean() {
		this.elementi= new ArrayList<>();
		
	}
	
	public List<ElementoCarrello_Bean> getElementi(){
		return elementi;
	}
	
	public void aggiungiElemento(ElementoCarrello_Bean newElemento) {
		elementi.add(newElemento);
	}
	
	public void rimuoviElemento(int codiceViaggio) {
		elementi.removeIf(e-> e.getViaggio().getCodiceViaggio() == codiceViaggio);
	}
	
	public double getCostoTotale() {
		double tot=0;
		for(ElementoCarrello_Bean e : elementi) {
			tot+= e.getPrezzoTotale();
		}
		return tot;
	}
	
	public int getNumeroElementi() {
        return elementi.size();
    }
}
