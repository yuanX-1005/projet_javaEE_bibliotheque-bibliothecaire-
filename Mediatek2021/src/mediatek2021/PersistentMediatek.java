package mediatek2021;

import java.util.List;

public interface PersistentMediatek {
// Jean-François Brette 01/01/2018
	
	List<Document> catalogue(int type);
	Document getDocument(int numDocument);
	Utilisateur getUser(String login, String password);
	void newDocument(int type, Object... args ) throws NewDocException;
	void suppressDoc(int numDoc) throws SuppressException;

}
