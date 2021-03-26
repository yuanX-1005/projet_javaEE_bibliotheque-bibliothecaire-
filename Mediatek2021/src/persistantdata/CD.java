package persistantdata;

import mediatek2021.Document;

public class CD implements Document {
	
	private Object[] data;

	public CD(Object[] data) {
		this.data = data;
	}

	@Override
	public Object[] data() {
		return data;
	}

}
