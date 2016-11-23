<%-- 
    Página : Homepage.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>

<html>

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot</title>
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="shortcut icon" href="imagens/icone_homepage.ico" type="image/x-icon" />
    </head>

    <body id="main_body" >

        <img id="top" src="top.png" alt="">
            
        <div id="form_container">
            <br>

            <h2><font size="5"><i><center>AdBot</center></i></font></h2>
            <br>
            <h3><font size="5"><center>TESTE DE <i>LOG IN</i> SOMENTE PARA <i>ADVERTISER</i> <br> Usar o Usuario_ID = 6 para testes</center></font></h3>
            <br><br>
<%
            if ( request.getParameter("Campo_controle") != null ) { 
                
                // PRECISA do procedimento abaixo após obter o Usuario_ID (as outras páginas vão utilizar esse número):
                String Usuario_ID = request.getParameter("Usuario_ID");
                session.setAttribute("Usuario_ID", Usuario_ID);     
                // Aqui precisa verificar o tipo de usuário
                pageContext.forward("Listagem_campaigns.jsp");
                
            }
%>

            <center>
                <form method="post" action=Listagem_campaigns.jsp>
                    Usuario_ID <input type="text" name="Usuario_ID" /> <!-- No lugar disto, teria que estar UserName e Senha -->
                    <input id="Botao_Log_in" type="submit" name="Botao_Log_in" value="Log in" />
                    <input type="hidden" name="Campo_controle" />
                </form>
            </center>
            <br><br>

            <img id="bottom" src="bottom.png" alt="">

            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>

        </div>    

    </body>

</html>