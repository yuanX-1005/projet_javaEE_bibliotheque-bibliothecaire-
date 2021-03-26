package mediatek2021;

import java.util.List;

/**
 cette classe repr�sente la mediatheque du point de vue du domaine
 cette classe est un singleton
 elle a un attribut qui fait le lien avec les donn�es persistentes
 
 LES SERVLETS DOIVENT S'ADRESSER A CETTE CLASSE EXCLUSIVEMENT
 POUR INTERROGER LES DONNEES

 beaucoup des m�thodes de Mediatheque sont d�l�gu�es � l'attribut de persistance
 qui devra r�percuter ces op�rations sur les donn�es persistantes

*/
/**
 * @author jfbrette
 *
 */
public class Mediatek {
// Jean-Fran�ois Brette 01/01/2018

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

// lien avec les donn�es persistantes +++++++++++++++
	private PersistentMediatek data;

	public void setData(PersistentMediatek data) {
		if (this.data == null) this.data = data;
	}
// fin - lien avec les donn�es persistantes +++++++++		

// *********************** d�l�gation **********************

	// renvoie la liste de tous les documents de la biblioth�que
	// du type typeDoc

	public List<Document> catalogue(int typeDoc) {
		return data.catalogue(typeDoc);
	}

	// renvoie le user de login et passwd 
	// si pas trouv�, renvoie null
	
	public Utilisateur getUser (String login, String password) {
		return data.getUser(login, password);
	}
	// renvoie le document de num�ro numDocument
	// si pas trouv�, renvoie null
	
	public Document getDocument(int numDocument) {
		return data.getDocument(numDocument);
	}
	
	// ajoute un nouveau document - exception � d�finir

	public void newDocument(int type, Object... args ) throws NewDocException {
		data.newDocument(type, args);
	};
	
	// supprime un document - exception si document non disponible
	public void suppressDoc (int numDoc) throws SuppressException{
		data.suppressDoc(numDoc);
	}

}
