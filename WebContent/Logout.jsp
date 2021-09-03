<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
if (session.getAttribute("role") != null && session.getAttribute("role").equals("user")) 
{
	session.invalidate();
	response.sendRedirect("Login.jsp");
}
else if (session.getAttribute("role") != null && session.getAttribute("role").equals("admin") )
{
	session.invalidate();
	response.sendRedirect("LoginAdmin.jsp");
}
%>
</body>
</html>