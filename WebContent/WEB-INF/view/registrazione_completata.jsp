<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.*" %>
<%
    Utente_Bean utente = (Utente_Bean) request.getAttribute("registeredUser");
    if (utente == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Creato</title>
</head>
<body>

</body>
</html>