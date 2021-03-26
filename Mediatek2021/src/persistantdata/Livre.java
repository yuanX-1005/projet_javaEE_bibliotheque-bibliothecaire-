package persistantdata;

import mediatek2021.Document;

public class Livre implements Document {
	private Object[] data;

	public Livre(Object[] data) {
		this.data = data;
	}

	@Override
	public Object[] data() {
		return data;
	}

}
