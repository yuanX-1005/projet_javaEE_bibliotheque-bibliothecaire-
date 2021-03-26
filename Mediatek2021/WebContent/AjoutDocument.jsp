<%@page language="java" contentType="text/html" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="mediatek2021.*" %>
<!DOCTYPE html>
<%String path = request.getContextPath(); %>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="<%=path %>/static/css/style.css">
		<title>Ajout de document</title>
		<link rel="shortcut icon" href="#" />
		<style>
		  #dvd-parents{
		      display: none;
		  }
		</style>
	</head>
<body>
<% 
	if(session.getAttribute("user")==null){
    	out.println("<script>alert('Il faut connecte !');window.location.href='index.jsp'</script>");
    	return;
	}
%>
<button class="retour" style="float:right; margin-right:30px" value="button" onclick="javascript:window.location.href='<%=path %>/bibliotheque.jsp'">Retour</button>
<button class="retour" style="float:right" value="button" onclick="javascript:window.location.href='<%=path %>/loginOut.jsp'">Deconnecion</button>
<div class="container">
           <h2>Ajout de document </h2>
            <div id="add">
           
                <form action="<%=path %>/AjoutDocument.jsp" method="POST" id="">
                    <h1 style=" font-size: 15px ;  margin-top : 20px">Entrez les informations du document que vous souhaiter ajouter</h1>
                    
                    <label style ="font-weight: bold;" >Type : </label>
                    <input type="radio" id="livre" name="typeDocument" value="2"   onchange="addLivreCD()">
                    <label>Livre</label>
                    <input type="radio" id="dvds" name="typeDocument" value="3"  onchange="addDVD()" >
                    <label>DVDs</label>
                    <input type="radio" id="cds" name="typeDocument" value="1"  onchange="addLivreCD()" >
                    <label>CDs</label><br>
                    <div id="dvd-parents">
                        <p>Le DVD est-il pour adulte ?</p>
                        <input type="radio" id="dvds_oui" name="DVD_adulte" value="1" ><label>oui</label>
                        <input type="radio" id="dvds_non" name="DVD_adulte" value="0"><label>non</label>
                    </div>
                    <br>
                    <label style ="font-weight: bold;" >Titre  :</label>
                    <input type="text" id="num" name="titre" placeholder="Titre" value=>
                    <label style ="font-weight: bold;" >Auteur :</label>
                    <input type="text" id="num" name="auteur" placeholder="Nom d'auteur">
                    <input type="submit" value="Ajouter" >
                    
                </form>
                
            </div>
		
</div>
			<% 	
				if(request.getParameter("titre")!=null && request.getParameter("auteur")!=null && request.getParameter("typeDocument")!=null){
					//entrer le titre, l'auteur et le type de document
					String titre = request.getParameter("titre").trim();
					String auteur = request.getParameter("auteur").trim();
					int type = Integer.parseInt(request.getParameter("typeDocument"));

					
					Utilisateur sessionUser = (Utilisateur)session.getAttribute("user");
					int userId = (Integer)(sessionUser.data()[0]); //obtient les idBibiothecaire
					String reponse;
					Mediatek med = Mediatek.getInstance();
					//si le type egale à DVD
					if(type == 3){
						try{
							int adulte = Integer.parseInt(request.getParameter("DVD_adulte"));
							Object[] args = {titre,auteur,userId,adulte};
						
							med.newDocument(type,args);
							reponse="L'enregistrement reussi !";
						}catch(NewDocException e){
							reponse = e.toString();
						}catch(NumberFormatException e){
							reponse = "Veuillez remplir les cases !";
						}
					}//sinon
					else{
						Object[] args = {titre,auteur,userId};
						try{
							med.newDocument(type,args);
							reponse="L'enregistrement reussi !";
						}catch(NewDocException e){
							reponse = e.toString();
						}
					}
					out.println(reponse); //afficher le message
				
				}
				
			%>

        <script>
            function addDVD(){
                document.getElementById("dvd-parents").style.display ="block";
            }
            function addLivreCD(){
                document.getElementById("dvd-parents").style.display ="none";
            }
           
        </script>
</body>
</html>