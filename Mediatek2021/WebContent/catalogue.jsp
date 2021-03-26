<%@ page language="java" contentType="text/html" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="mediatek2021.*" %>
<!DOCTYPE html>
<%String path = request.getContextPath(); %>
<html>
<head>
	<meta charset="utf-8">
    <title>Catalogue</title>
    <link rel = "stylesheet" href = "<%=path %>/static/css/style.css">
    <link rel="shortcut icon" href="#" />
</head>
<body>
   <button class="retour" style="float:right; margin-right:30px" value="button" onclick="javascript:window.location.href='<%=path %>/bibliotheque.jsp'">Retour</button>
<% 
	//verifier l'existance de session
	if(session.getAttribute("user")==null){
    	out.println("<script>alert('Il faut connecte !');window.location.href='index.jsp'</script>");
    	return;
	} 
%>
   <button class="retour" style="float:right" value="button" onclick="javascript:window.location.href='<%=path %>/loginOut.jsp'">Deconnecion</button>
<%
	try{
		Integer type = Integer.parseInt(request.getParameter("typeDocument"));
		Mediatek med = Mediatek.getInstance();
		List<Document> cata = med.catalogue(type); //obtenir le liste de document avec le type choisit
		
		if(null == cata || cata.size() == 0 ){
			out.println("liste est null");
		}
		Object[] data;	
%>
<h2> Le catalogue</h2>
   <div class="container">
	  <div class="bloc-mise-en-page">
	      <table>
	        <tr>
	          <th>N° Document</th>
	          <th>Titre</th>
	          <th>Auteur</th>
	          <%if(type == 3) out.print("<th>Adulte</th>");%>
	        </tr>
	<% 
	// afficher le catalogue	
	for(Document d : cata){
		data = d.data();
		//data[0]=id | data[1] = titre | data[2] = auteur |data[3] = type |data[4]= adulte(DVD)
	%>
		  <tr>
	        <td><%=data[0] %></td>
	        <td><%=data[1] %></td>
	        <td><%=data[2] %></td>
	        <%if(type == 3){ %>
	        <td><%if(data[4].equals(1)){ out.print("true"); }else{ out.print("false");} %></td>
	        <%} %>
	      </tr>

<% 	}
}catch(NumberFormatException e){}
	%>
		</table> 
	</div>
</div>
</body>
</html>