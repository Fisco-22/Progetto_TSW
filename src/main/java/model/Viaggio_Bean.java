package model;

public class Viaggio_Bean {
		private int codiceViaggio;
		private String destinazione;
		private String descrizione;
		private float costoTotale;
		private String immagineUrl;
		private int nPosti;
		private String emailAdmin;
		
		public Viaggio_Bean() {}

		public int getCodiceViaggio() {
			return codiceViaggio;
		}

		public void setCodiceViaggio(int codiceViaggio) {
			this.codiceViaggio = codiceViaggio;
		}

		public String getDestinazione() {
			return destinazione;
		}

		public void setDestinazione(String destinazione) {
			this.destinazione = destinazione;
		}

		public String getDescrizione() {
			return descrizione;
		}

		public void setDescrizione(String descrizione) {
			this.descrizione = descrizione;
		}

		public float getCostoTotale() {
			return costoTotale;
		}

		public void setCostoTotale(float costoTotale) {
			this.costoTotale = costoTotale;
		}

		public String getImmagineUrl() {
			return immagineUrl;
		}

		public void setImmagineUrl(String immagineUrl) {
			this.immagineUrl = immagineUrl;
		}

		public int getnPosti() {
			return nPosti;
		}

		public void setnPosti(int nPosti) {
			this.nPosti = nPosti;
		}

		public String getEmailAdmin() {
			return emailAdmin;
		}

		public void setEmailAdmin(String emailAdmin) {
			this.emailAdmin = emailAdmin;
		}
		
		
}
