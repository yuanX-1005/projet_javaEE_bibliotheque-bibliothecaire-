<%@page language="java" contentType="text/html" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="mediatek2021.*" %>
<!DOCTYPE html>
<%String path = request.getContextPath(); %>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="<%=path %>/static/css/style.css">
		<link rel="shortcut icon" href="#" />
		<title>Connection</title>
	</head>
	<body>
		<div class="background-image-container bg-connexion"></div>
        <div class="container">
            <h1>Connexion</h1>
            <form action="<%=path %>/index.jsp" method="POST">
                <label>Login</label>
                <input type="text" id="log" name="login" placeholder="prenomnom">
                <label >Mot de passe</label>
                <input type="password" id="mdp" name="password" placeholder="mot de passe">
                <input type="submit" value="Connexion">
            </form>
           <% 
            if(request.getParameter("login")!=null && request.getParameter("password")!=null){
            	
            	// entrer le login et password
            	String login = request.getParameter("login");
        		String password = request.getParameter("password");
        		
        		Mediatek med = Mediatek.getInstance();
        		Utilisateur user = med.getUser(login, password); //verifier l'existance de l'utilisateur dans le BD 
        		
        		if(user!=null){
        			HttpSession sessionUser = request.getSession();
       				session.setAttribute("user",user); //création de la session
        			session.setMaxInactiveInterval(1200); //le duree de session est definit en 20min
       				response.sendRedirect(path + "/bibliotheque.jsp"); //saute à la page bibliotheque.jsp
        		}
       			else{
       				out.println("erreur de login or password !"); //afficher erreur si l'utilisateur n'existe pas
        		}
            } 
            %>
          </div>
    </body>
   
</html>