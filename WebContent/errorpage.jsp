<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page isErrorPage = "true" %>
<%@ include file="header.jsp"%>

<html>
   <head>
      <title>Show Error Page</title>
   </head>
   <body>
      <h1>Opps...</h1>
      <p>Sorry, an error occurred.</p>
      <p>Here is the exception stack trace: </p>
      <pre><% exception.printStackTrace(response.getWriter()); %></pre>
   </body>
</html>

