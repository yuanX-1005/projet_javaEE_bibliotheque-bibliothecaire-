<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<%String path = request.getContextPath(); %>
<html>
<head>
<meta charset="utf-8">
<title>remove session</title>
</head>
<body>
<%
 // deconnecter et supprime le session
  session.removeAttribute("user");
  response.sendRedirect(path + "/index.jsp");
%>

</body>
</html>