<%-- 
    Página : Remover_Media.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [23/11/2016] Felipe - versão inicial
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
        pageContext.forward("Homepage.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");

    int Usuario_ID = Integer.parseInt(Usuario_ID_st);

%>    

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot: Remover Media</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <script type="text/javascript" src="view.js"></script>
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
        </head>

    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>     
                <input id="Botao_Log_out" type="button" class="button_log_out" value="Log out"> <!------ Implementar rotina de Log Out ... ------>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Publisher</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfi_publisher" href="Perfil_de_publisher.jsp" class="button_options2">Perfil de <i>Publisher</i></a>

<%
            UsuarioController uc = new UsuarioController();
            UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID);
%>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspPublisher</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Remoção de <i>Media</i></font></center></h3>
 <%    
     String Media_ID_str = request.getParameter("Media_ID");
     int Media_ID = Integer.parseInt(Media_ID_str);                
                
     if ( request.getParameter("Confirmar") != null ) { 
       System.out.println("RM_confirmou");
       MediaController tn = new MediaController();
       tn.removerMedia(Media_ID);
       pageContext.forward("Listagem_medias.jsp");
}
%>
            <br><hr><br>
            <form method="post" action=Remover_media.jsp>
                <input id="Botao_confirmar" type="submit" class="button_options2"/>
                <input type="hidden" name="Confirmar" />
                <input type="hidden" name="Media_ID" value="<%= Media_ID_str %>" />
            </form>
            <a id="Botao_cancelar" href="Listagem_medias.jsp" class="button_options2">Cancelar</a>

            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>