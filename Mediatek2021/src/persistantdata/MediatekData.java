package persistantdata;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mediatek2021.*;

// classe mono-instance : l'unique instance est connue de la bibliotheque
// via une injection de d�pendance dans son bloc static

public class MediatekData implements PersistentMediatek {
// Jean-Fran�ois Brette 01/01/2018
	static {
		// injection dynamique de la d�pendance dans le package stable mediatek2021
		Mediatek.getInstance().setData(new MediatekData());
	}

	private MediatekData() {
	}

	// renvoie la liste de tous les documents de la biblioth�que
	@Override
	public List<Document> catalogue(int type){
		
		List<Document>cata = new ArrayList<Document>();
		Connection cn = null;
		PreparedStatement pst = null;
		
		try {
			cn = Connexion.getConnection(); //Connecte
			pst = cn.prepareStatement("Select * from Document where type=? order by IdDocument");
			pst.setInt(1,type);
			ResultSet res = pst.executeQuery(); //Execute le requete
			Document doc = null;
			while(res.next()) { //si le resultat de requete est non null
				switch(type) { //Obtenir les données du Document selon le type
				case 1 : 
					Object[] data1 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"),res.getInt("type")};
					doc = new CD(data1); break;
				case 2 : 
					Object[] data2 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"), res.getInt("type")};
					doc = new Livre(data2); break;
				case 3 : 
					Object[] data3 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"),res.getInt("type"), res.getInt("adulte")};
					doc = new DVD(data3); break;
				default : System.out.println("Type non existe");
				
				}
				cata.add(doc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				Connexion.close(pst, cn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		
		return cata;
	}
	

	// va r�cup�rer le User dans la BD et le renvoie
	// si pas trouv�, renvoie null
	@Override
	public Utilisateur getUser(String login, String password) {
		
		Bibliothecaire u = null;
		Connection cn = null;
		PreparedStatement pst = null;
		
		 try {
			 cn = Connexion.getConnection(); //Connecter
			 String sql = "SELECT * FROM Bibliothecaire where loginb = ? and passwordb = ?";
			 pst = cn.prepareStatement(sql);
			 pst.setString(1,login);
			 pst.setString(2,password);
			 ResultSet res = pst.executeQuery();
			 while(res.next()) { 
				 u = new Bibliothecaire(); // obtenir les donn�es de bibliothecaire
				 u.setlogin(res.getString("loginb"));
				 u.setpassword(res.getString("passwordb"));
				 Object[] data = {res.getInt("IdBiblio")};
				 u.setData(data);
			 }
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				Connexion.close(pst, cn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		
		return u;
	}

	// va r�cup�rer le document de num�ro numDocument dans la BD
	// et le renvoie
	// si pas trouv�, renvoie null
	@Override
	public Document getDocument(int numDocument) {
		Document doc = null;
		Connection conn = null;
		PreparedStatement pst = null;
		
		try {
			conn = Connexion.getConnection();
			String sql = "select * from Document where idDocument = ?";
			pst = (PreparedStatement)conn.prepareStatement(sql);
			pst.setInt(1,numDocument);
			ResultSet res = pst.executeQuery();
			if(res.next()) {
				int type = res.getInt("type");
				switch(type) { //obtenir les donn�es de document selon le type de document
					case 1 : 
						Object[] data1 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"),res.getInt("type")};
						doc = new CD(data1); break;
					case 2 : 
						Object[] data2 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"), res.getInt("type")};
						doc = new Livre(data2); break;
					case 3 : 
						Object[] data3 = {res.getInt("IdDocument"),res.getString("title"),res.getString("auteur"),res.getInt("type"), res.getInt("adulte")};
						doc = new DVD(data3); break;
					default : System.out.println("Type non existe");
				}
				return doc;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		finally {
			try {
				Connexion.close(pst, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
			
		return doc;
	}

	// ajoute un nouveau document - exception � d�finir
	@Override
	public synchronized void newDocument(int type, Object... args) throws NewDocException {
		Connection conn = null;
		PreparedStatement pst = null;
		try {
			conn = Connexion.getConnection(); 
			
			//Verifier les cas d'exceptions
			if(type != 3) {
				if (args[0] == "" || args[1] == "" || args[2] == "") {
					throw new NewDocException("Veillez remplir tous les cases");
				}
			} else {
				if (args[0] == "" || args[1] == "" || args[2] == "" || args[3] == "") {
					throw new NewDocException("Veillez remplir tous les cases");
				}
			}
			
			String sql = "insert into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne) values (IncremBibliothecaire.nextval,?,?,?,?,?,?,null)";
			pst = (PreparedStatement) conn.prepareStatement(sql);
			pst.setObject(1, args[0]); // args[0] -> le titre
			pst.setObject(2, args[1]); // args [1] --> l'auteur
			pst.setObject(3, type); //type 
			if (type == 3) {
				pst.setObject(4, args[3]); //args[3] -> adulte
			} else {
				pst.setObject(4, null);
			}
			pst.setObject(5, 1); //le nouveau doument est disponible
			pst.setObject(6, args[2]);//Id de Bibliothecaire qui a cr�er des documents
			int res = pst.executeUpdate();
			if (res <= 0) {
				throw new NewDocException("L'�chec de mis � jour : Erreure inconnu!");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				Connexion.close(pst, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	// supprime un document - exception � d�finir
	@Override
	public synchronized void suppressDoc(int numDoc) throws SuppressException {
		Connection conn = null;
		PreparedStatement pstVerif = null;
		PreparedStatement pst = null;
		
		try {
			conn = Connexion.getConnection();			
			
			//verifier l'existance de document
			String sqlVerif = "select * from Document where idDocument = ?";
			pstVerif = conn.prepareStatement(sqlVerif);
			pstVerif.setInt(1, numDoc);
			ResultSet res = pstVerif.executeQuery();
			if (res.next()) {
				if (res.getInt("disponible") == 0) { //Verifier la disponibilit� de document
					throw new SuppressException("Le document est emprunt par l'abonne !");
				} else {
					//supprimer le document
					String sql = "delete from Document where IdDocument = ?";
					pst = conn.prepareStatement(sql);
					pst.setInt(1, numDoc);
					pst.executeUpdate();
				}
			} else {
				throw new SuppressException("Les numero de document n'existe pas !");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				Connexion.close(pst, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}
