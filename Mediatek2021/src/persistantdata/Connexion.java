package persistantdata;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Connexion {
	
	private static String url ="jdbc:oracle:thin:@localhost:1521:XE";
	private static String user="system";
	private static String password="2F3F63447F";
	private static Connection connection = null;	
	private static int k=0;
	
	//connecter au base de données
	public static Connection getConnection(){
		
			try {
				k++;
				Class.forName("oracle.jdbc.OracleDriver");
				connection = DriverManager.getConnection(url, user, password);
				System.out.println("connect reussi --> " + k );
			} catch (ClassNotFoundException e) {
				System.out.println("Exception de classe introuvable");
				e.printStackTrace();
			} catch (SQLException e) {
				System.out.println("Exception SQL");
				e.printStackTrace();
			}
	
		return connection;

    }
    
	//deconnecter au base de données
    public static void close(Statement st, Connection cn) throws SQLException {
    	if(st!=null) {
    		try {
    			st.close();
    		}catch(SQLException e){
    			e.printStackTrace();
    		}
    		st=null;
    	}
    	if(cn!=null) {
    		try {
    	    	cn.close();
    	    	
    		}catch(SQLException e){
    			e.printStackTrace();
    		}
    		cn=null;
    	}
    }

}
