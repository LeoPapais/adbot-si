<%-- 
    Document   : index
    Created on : 01/10/2009, 18:29:29
    Author     : MB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HttpSessionDemo-Pagina de Login</title>
    </head>
    <body>
<%
    if ( request.getParameter("campo_controle") != null ) {
        // processa login
        String user = request.getParameter("usuario");
        String passwd = request.getParameter("senha");
        // metodo valida deve ser implementado
        //boolean v = valida(user, passwd);
        // simulacao: deve ser 123
        boolean v = "123".equals(passwd);
        if (v) {
           session.setAttribute("user_name", user);
           pageContext.forward("main.jsp");
        } else {
   %>
           Usuario ou Senha invalidos!
   <%
        }
    }
    // show login form
%>
    <form method="post" action=index.jsp>
       Usuário <input type="text" name="usuario" />
       Senha <input type="password" name="senha" />
       <input type="submit" name="enviar" value="Enviar" />
       <input type="hidden" name="campo_controle" />
    </form>
    </body>
</html>
