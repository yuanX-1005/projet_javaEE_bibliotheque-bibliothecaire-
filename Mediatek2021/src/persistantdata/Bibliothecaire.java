package persistantdata;

import mediatek2021.Utilisateur;

public class Bibliothecaire implements Utilisateur {
	
	private String login, password;
	private Object[] data;

	public Bibliothecaire(){
	}

	@Override
	public String login() {
		return login;
	}

	@Override
	public String password() {
		return password;
	}
	
	public void setlogin(String login) {
		this.login = login; 
	}
	
	public void setpassword(String password) {
		this.password = password;
	}

	@Override
	public Object[] data() {
		return data;
	}

	public void setData(Object[] data) {
		this.data = data;
	}

}
