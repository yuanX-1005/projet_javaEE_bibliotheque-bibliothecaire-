package mediatek2021;


public class NewDocException extends Exception {

	public NewDocException(String arg0) {
		super(arg0);
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
