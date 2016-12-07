<%-- 
    Página : Perfil_de_publisher.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            Breno - Versão inicial
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="utils.Logout" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Log_in_de_usuario.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");
    
    int Usuario_ID = Integer.parseInt(Usuario_ID_st);

%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Publisher: Perfil de Publisher</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >

<%
    ///////////////////////////////////////////////////////////////////////////
    //                                                                       //
    // USE CASE P01 - VISUALIZACAO DE PERFIL DE PUBLISHER [26/11/2016 BRENO] //
    //                                                                       //
    ///////////////////////////////////////////////////////////////////////////
%>
    
        
        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>     
                <input id="Botao_Log_out" type="button" class="button_log_out" value="Log out">    
                <!------ Implementar rotina de Log Out -> On click function ------>
                <i><left><font color="green">&nbsp&nbsp&nbspAdBot: Publisher</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_publisher" href="Perfil_de_publisher.jsp" class="button_options">Perfil de <i>Publisher</i></a>

<%

            UsuarioController uc = new UsuarioController();      // Instanciar UsuarioController
            UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID);   // Obter o Nome + Sobrenome do usuário
            VisualizacaoAdvertiserPublisherDTO vap = uc.visualizarPerfilAdvertiserPublisher(Usuario_ID); // Obter dados para visualização do perfil de Publisher
            
          
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); // Formato de data para exibir na tela
%>

            <font size="3" color="green"><i>&nbsp&nbsp&nbspPublisher</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="green">Perfil de <i>Publisher</i></font></center></h3>

            <br><hr><br>
            <center><IMG src="imagens/perfil_publisher.jpg" width="60" height="80" align="center" border="0"></center>
            <br> 
            <font size="4" color = "green"><center><i>Username</i>: <%= String.format("%s", vap.getUserName()) %></center></font>
            <br>
            <font size="4" color = "green"><center>Senha: <%= String.format("%s", vap.getSenha()) %></center></font>
            <br>
            <font size="4"><center>Nome: <%= String.format("%s", vap.getNome()) %></center></font>
            <br>
            <font size="4"><center>Sobrenome: <%= String.format("%s", vap.getSobrenome()) %></center></font>
            <br>
            <font size="4"><center>E-mail: <%= String.format("%s", vap.getE_mail()) %></center></font>
            <br>
            <font size="4"><center>Conta de banco: <%= String.format("%s", vap.getConta_de_banco()) %></center></font>
            <br>
            <font size="4"><center>Data de cadastro: <%= String.format("%s", dateFormat.format(vap.getData_de_cadastro())) %></center></font>
<%
            if(vap.getBloqueio() == 1){ // Se o usuário estiver bloqueado
%>
                <br>
                <font size="4" color = "gray"><center><b>BLOQUEADO<br> pelo Adm do <i>SI AdBot</i></b></center></font>
                <br><br>  
                <center>
                    <a id="Botao_Voltar" class="button_blocked"> Editar perfil </a>                    
                    <a id="Botao_Voltar" class="button_blocked">Listagem de <i> Medias </i></a>
                    <a id="Botao_Voltar" class="button_blocked"> Histórico de movimentação </a>
                    <a id="Botao_Voltar" class="button_blocked"> Balance </a>
                </center>                
<%
            } else{
%>  
                <br><br>  
                <center>
                    <a id="Botao_Voltar" href="Edicao_de_perfil_de_publisher.jsp" class="button_options"> Editar perfil </a>                      
                    <a id="Botao_Voltar" href="Saque_de_dinheiro.jsp" class="button_options">Listagem de <i> Medias </i></a>
                    <a id="Botao_Voltar" href="Historico_de_movimentacao.jsp" class="button_options">Histórico de movimentação </i></a>
                    <a id="Botao_Voltar" href="Balance_do_usuario.jsp" class="button_options">Balance</i></a>
                </center>
<%
            }

    /////////////////////////////////////////////////////////////////////
    //                                                                 //
    //    FIM DO USE CASE P01 - VISUALIZACAO DE PERFIL DE PUBLISHER    //
    //                                                                 //
    /////////////////////////////////////////////////////////////////////

%>
            <br><br><hr><br>
                        
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>
