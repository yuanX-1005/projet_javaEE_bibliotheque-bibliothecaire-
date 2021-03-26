<%@ page language="java" contentType="text/html" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="mediatek2021.*" %>
<!DOCTYPE html>
<%String path = request.getContextPath(); %>
<html>
<head>
	<meta charset="utf-8">
    <title>Bibliotheque (html)</title>
    <link rel = "stylesheet" href = "<%=path %>/static/css/style.css">
    <link rel="shortcut icon" href="#" />
</head>
<body>

<%  //verifier l'existance de session
	if(session.getAttribute("user")==null){
    	out.println("<script>alert('Il faut connecte !');window.location.href='index.jsp'</script>");
    	return;
	}
	Utilisateur user = (Utilisateur)session.getAttribute("user");
	out.println("<h2>Welcome " + user.login()+ "</h2>"); 
%>
 <button class="retour" style="float:right" value="button" onclick="javascript:window.location.href='<%=path %>/loginOut.jsp'">Deconnecion</button>
        <div class="container">
           <h2>Selectionnez une des actions : </h2>

           <input type="button" name="light" class="btn_option" id="op1" value="Rechercher des documents" onclick="options1()">
           <input type="button" name="light" class="btn_option"id="op2" value="Supprimer des documents avec son numero" onclick="options2()">
           <input type="button" name="light" class="btn_option" id="op3"value="Rechercher le document avec son numero" onclick="options3()">
   		   <button class="btn_option" value="button" onclick="javascript:window.location.href='<%=path %>/AjoutDocument.jsp'">Ajout le document</button>


           <div id="search_catalogue">
                <form action="<%=path %>/catalogue.jsp" method="POST" id="form_option1">
                    <h1 style=" font-size: 15px ;  margin-top : 20px">Choisi le type de document que vous voulez chercher</h1>
                   
                    <label style ="font-weight: bold;" >Type du document : </label>
                    <input type="radio" id="livre" name="typeDocument" value="2"  checked>
                    <label>Livre</label>
                    <input type="radio" id="dvds" name="typeDocument" value="3">
                    <label>DVDs</label>
                    <input type="radio" id="cds" name="typeDocument" value="1">
                    <label>CDs</label>
                    <br>
                    <input type="submit" value="Chercher"> 
                    <br><br>
  
                </form>
            </div>
            
        
            <div id="delete">
                <form  action="<%=path %>/bibliotheque.jsp" method="POST"  id="form_option2">
                    <h1 style=" font-size: 15px ;  margin-top : 20px">Entrez le numero du document que vous souhaiter supprimer</h1>
                    <input type="text" id="log" name="suppDoc" placeholder="N° document">
                    <input type="submit" value="Supprimer" >
                </form>
                
                <%if(request.getParameter("suppDoc")!=null){
                	
                	//obtenir le numero de document qu'on voudrais supprimer
                	String reponse;                
                	try{
	                	int numDoc = Integer.parseInt(request.getParameter("suppDoc"));
	            		Mediatek med = Mediatek.getInstance();
            			med.suppressDoc(numDoc); //supprimer le doc dans le BD
            			reponse="Le document n°"+ numDoc + " est bien supprimé !";
            		}catch(SuppressException e){
            			reponse = e.toString();
            		}catch(NumberFormatException e){
            			reponse = "veuillez entre les numeros !";
            		}
            		out.println(reponse); //afficher le resultat de l'action
                }%>
                
                
            </div>

            <div id="search">
                <form action="<%=path %>/bibliotheque.jsp" method="POST" id="form_option3">
                    <h1 style=" font-size: 15px ;  margin-top : 20px">Entrez le numero du document que vous souhaiter chercher</h1>
                    <input type="text" id="log" name="chercherDoc" placeholder="N° document">
                    <input type="submit" value="Chercher" >
                </form>
            	
            	<%if(request.getParameter("chercherDoc")!=null){
                	
            		//obtenir le numero de document qu'on voudrais chercher
            		int numDoc = Integer.parseInt(request.getParameter("chercherDoc"));
                	
            		Mediatek med = Mediatek.getInstance();
            		Document doc = med.getDocument(numDoc); //chercher le doc dans le BD
            		
            		// afficher les resulatat sur le page web
            		if(doc!=null){
	            		Object[] data = doc.data();
	            		int type = (Integer)data[3];
	          		%>
	          		<table>
		          		<tr>
		          			<th>N°</th>
		          			<th>Titre</th>
		          			<th>Auteur</th>
		          			<%if(data[3].equals(3)) out.print("<th>Adulte</th>");%>
		          		</tr>
		          		<tr>
		          			<td><%=data[0] %></td>
		          			<td><%=data[1] %></td>
		          			<td><%=data[2] %></td>
		          			<%if(type == 3){ 
		          				int adulte = (Integer)data[4];
		          			%>
					        <td><%if(adulte==1){ out.print("true"); }else{ out.print("false");} %></td>
					        <%} %>
		          		</tr>
	          		</table>
	          		<% 
            		}
            		else{
            			out.println("Le N° document n'existe pas!");
            		}
            	}%>
            
            </div>


        </div>
        <script src = "<%=path %>/static/js/app.js"></script>
    </body>
</html>