package Model;

public class ElementoCarrello_Bean {
	private Viaggio_Bean viaggio;
    private String dataPartenza;
    private int numPosti;
    
    public ElementoCarrello_Bean(Viaggio_Bean viaggio, String dataPartenza, int numPosti) {
    	this.viaggio= viaggio;
    	this.dataPartenza= dataPartenza;
    	this.numPosti= numPosti;
    }

	public Viaggio_Bean getViaggio() {
		return viaggio;
	}

	public void setViaggio(Viaggio_Bean viaggio) {
		this.viaggio = viaggio;
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
    
    
}
