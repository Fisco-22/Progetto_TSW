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
		// Se lo stesso viaggio con la stessa data è già nel carrello, somma i posti
		for (ElementoCarrello_Bean e : elementi) {
			if (stessoElemento(e, newElemento.getViaggio().getCodiceViaggio(), newElemento.getDataPartenza())) {
				e.setNumPosti(e.getNumPosti() + newElemento.getNumPosti());
				return;
			}
		}
		elementi.add(newElemento);
	}

	public void rimuoviElemento(int codiceViaggio, String dataPartenza) {
		elementi.removeIf(e -> stessoElemento(e, codiceViaggio, dataPartenza));
	}

	public void aggiornaQuantita(int codiceViaggio, String dataPartenza, int numPosti) {
		if (numPosti <= 0) {
			rimuoviElemento(codiceViaggio, dataPartenza);
			return;
		}
		for (ElementoCarrello_Bean e : elementi) {
			if (stessoElemento(e, codiceViaggio, dataPartenza)) {
				e.setNumPosti(numPosti);
				return;
			}
		}
	}

	public void svuota() {
		elementi.clear();
	}

	// Un elemento è identificato da viaggio + data di partenza
	private boolean stessoElemento(ElementoCarrello_Bean e, int codiceViaggio, String dataPartenza) {
		return e.getViaggio().getCodiceViaggio() == codiceViaggio
				&& e.getDataPartenza() != null && e.getDataPartenza().equals(dataPartenza);
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
