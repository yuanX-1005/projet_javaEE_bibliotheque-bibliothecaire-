package persistantdata;

import mediatek2021.Document;

public class DVD implements Document {
	private Object[] data;
	
	public DVD(Object[] data) {
		this.data = data;
	}

	@Override
	public Object[] data() {
		return data;
	}
	
}
