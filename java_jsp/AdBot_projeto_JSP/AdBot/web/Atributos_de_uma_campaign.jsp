<%-- 
    Página : Atributos_de_uma_campaign.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [12/11/2016] Diego - Versão somente para teste de recebimento de parâmetros
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!--importando biblioteca SQL do Java-->
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>

<!-- Importa classes do projeto (Servlets) -->
<%@ page import="utils.Logout" %>

<html>
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teste de recebimento de parâmetros</title>
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >
        
        <img id="top" src="top.png" alt="">
            
        <div id="form_container">

            <%
                if ( request.getParameter("Campo_controle") != null ) { 

                    // PRECISA do procedimento abaixo após obter o Usuario_ID (as outras páginas vão utilizar esse número):
                    String Usuario_ID = request.getParameter("Usuario_ID");
                    session.setAttribute("Usuario_ID", Usuario_ID);     
                    // Aqui precisa verificar o tipo de usuário
                    pageContext.forward("Listagem_campaigns.jsp");

                }

                // Obtém o Campaign_ID passado pela página que chamou esta página (Listagem_campaigns.jsp)
                String Campaign_ID_st = request.getParameter("Campaign_ID");
                session.setAttribute("Campaign_ID", Campaign_ID_st);    
                int Campaign_ID = Integer.parseInt(Campaign_ID_st);

            %>

            <br>

            <h2><font size="5"><i><center>AdBot</center></i></font></h2>
            <br>
            <h3><font size="5"><center>Página para teste de recebimento de parâmetros!<br> O Campaign_ID é <%=Campaign_ID%></center></font></h3>
            <br><br>
                 
            <img id="bottom" src="bottom.png" alt="">

            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
                
        </div> 
        
    </body>
</html>
