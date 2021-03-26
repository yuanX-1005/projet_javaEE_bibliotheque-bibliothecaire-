 package init;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mediatek2021.Mediatek;

/**
 * Servlet implementation class InjectionServlet
 */
@WebServlet(value="/initializeResources", loadOnStartup=1)
public class InjectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Mediatek med= Mediatek.getInstance();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InjectionServlet() {
        super();
    }
    
    @Override
    public void init() throws ServletException{
    	//relier aux package persistantdata
		try {
			Class.forName("persistantdata.MediatekData");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//sauter à la page index.jsp
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
