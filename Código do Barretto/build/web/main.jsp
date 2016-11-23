<%-- 
    Document   : main.jsp
    Created on : 01/10/2009, 18:45:32
    Author     : MB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HttpSessionDemo - Pagina Principal</title>
    </head>
    <body>
<%
    // VERIFICACAO MANUAL DO LOGIN
    if ( session.getAttribute("user_name") == null) {
       pageContext.forward("index.jsp");
    }
    
    String nome = (String)session.getAttribute("user_name");
%>
    Bom dia <%= nome %> !!

  <li><a href="./insert.jsp">Inserir Contato</a>
  <li><a href="./update.jsp">Editar Contato</a>
  <li><a href="./remove.jsp">Remover Contato</a>
  <li><a href="./search.jsp">Pesquisar Contato</a>
    </body>
</html>
