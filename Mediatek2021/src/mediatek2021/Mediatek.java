package mediatek2021;

import java.util.List;

/**
 cette classe représente la mediatheque du point de vue du domaine
 cette classe est un singleton
 elle a un attribut qui fait le lien avec les données persistentes
 
 LES SERVLETS DOIVENT S'ADRESSER A CETTE CLASSE EXCLUSIVEMENT
 POUR INTERROGER LES DONNEES

 beaucoup des méthodes de Mediatheque sont déléguées à l'attribut de persistance
 qui devra répercuter ces opérations sur les données persistantes

*/
/**
 * @author jfbrette
 *
 */
public class Mediatek {
// Jean-François Brette 01/01/2018

// singleton standard ======================== 
	static {
		instance = new Mediatek();
	}
	
	private static Mediatek instance;
	
	public static Mediatek getInstance() {
		return instance;
	}
	
	private Mediatek () {}
	
// fin - singleton standard ==================

// lien avec les données persistantes +++++++++++++++
	private PersistentMediatek data;

	public void setData(PersistentMediatek data) {
		if (this.data == null) this.data = data;
	}
// fin - lien avec les données persistantes +++++++++		

// *********************** délégation **********************

	// renvoie la liste de tous les documents de la bibliothèque
	// du type typeDoc

	public List<Document> catalogue(int typeDoc) {
		return data.catalogue(typeDoc);
	}

	// renvoie le user de login et passwd 
	// si pas trouvé, renvoie null
	
	public Utilisateur getUser (String login, String password) {
		return data.getUser(login, password);
	}
	// renvoie le document de numéro numDocument
	// si pas trouvé, renvoie null
	
	public Document getDocument(int numDocument) {
		return data.getDocument(numDocument);
	}
	
	// ajoute un nouveau document - exception à définir

	public void newDocument(int type, Object... args ) throws NewDocException {
		data.newDocument(type, args);
	};
	
	// supprime un document - exception si document non disponible
	public void suppressDoc (int numDoc) throws SuppressException{
		data.suppressDoc(numDoc);
	}

}
