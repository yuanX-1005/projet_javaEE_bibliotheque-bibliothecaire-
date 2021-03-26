package mediatek2021;

public class SuppressException extends Exception {

	public SuppressException(String message) {
		super(message);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String toString() {
		return super.getMessage();
	}
	
	

}
