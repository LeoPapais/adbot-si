<%-- 
    Página : Perfil_de_advertiser.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [23/11/2016] Diego - Versão inicial
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
        <title>AdBot Advertiser: Perfil de Advertiser</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <style type="text/css">

            .button_menu {
                background-color: #FF91A4;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            .button_options {
                background-color: #E04C64;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: right;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }   
            
            .button_log_out {
                background-color: #64AEA6;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            } 
            
            .button_play {
                background-color: #FF3F3F;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }     
            
            .button_pause {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            .button_blocked {
                background-color: #919191;
                border: none;
                color: black;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            table.A {
                width: 100%; 
            }

            table.B {
                width: 100%; 
                padding: 5px;
                border-spacing: 5px;
                border-collapse: collapse;
                overflow: scroll;
                border-style: solid;
                border-width: 5px;
                border-color: #FF91A4;
            }

            th.B {
                border: 1px solid graytext;
                border-collapse: collapse;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            td.B {
                border: 1px solid graytext;
                border-collapse: collapse;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            tr.B:nth-child(even) {
                background-color: #FFC0CB;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            tr.B:nth-child(odd) {
                background-color:#fff;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            hr {
                border: none;
                height: 5px;
                background-color: #eee;
            }
        </style>
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>     
                <input id="Botao_Log_out" type="button" class="button_log_out" value="Log out">    
                <!------ Implementar rotina de Log Out -> On click function ------>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>

<%

            UsuarioController uc = new UsuarioController();      // Instanciar UsuarioController
            UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID);   // Obter o Nome + Sobrenome do usuário
            VisualizacaoAdvertiserPublisherDTO vap = uc.visualizarPerfilAdvertiserPublisher(Usuario_ID); // Obter dados para visualização do perfil de Advertiser
            
            AdvertiserController ac = new AdvertiserController();                        // Instanciar AdvertiserController
            AdvertiserCredito_disponivelDTO cd = ac.getCredito_disponivel(Usuario_ID);   // Obter o Crédito disponível do Advertiser        
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); // Formato de data para exibir na tela
%>

            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdvertiser</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Perfil de <i>Advertiser</i></font></center></h3>

            <br><hr><br>
            <center><IMG src="imagens/perfil_advertiser.jpg" width="60" height="80" align="center" border="0"></center>
            <br> 
            <font size="4" color = "A71010"><center><i>Username</i>: <%= String.format("%s", vap.getUserName()) %></center></font>
            <br>
            <font size="4" color = "A71010"><center>Senha: <%= String.format("%s", vap.getSenha()) %></center></font>
            <br>
            <font size="4"><center>Nome: <%= String.format("%s", vap.getNome()) %></center></font>
            <br>
            <font size="4"><center>Sobrenome: <%= String.format("%s", vap.getSobrenome()) %></center></font>
            <br>
            <font size="4"><center>E-mail: <%= String.format("%s", vap.getE_mail()) %></center></font>
            <br>
            <font size="4"><center>Conta de banco: <%= String.format("%s", vap.getConta_de_banco()) %></center></font>
            <br>
            <font size="4"><center>Crédito disponivel: R$ <%= String.format("%1.2f", cd.getCredito_disponivel()) %></center></font>
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
                    <a id="Botao_Voltar" class="button_blocked">Inserir crédito</a> 
                    <a id="Botao_Voltar" class="button_blocked">Listagem de <i> Campaigns </i></a> 
                </center>                
<%
            } else{
%>  
                <br><br>  
                <center>
                    <a id="Botao_Voltar" href="Edicao_de_perfil_de_advertiser.jsp" class="button_options"> Editar perfil </a> 
                    <a id="Botao_Voltar" href="Insercao_de_credito.jsp" class="button_options">Inserir crédito</a> 
                    <a id="Botao_Voltar" href="Listagem_campaigns.jsp" class="button_options">Listagem de <i> Campaigns </i></a> 
                </center>
<%
            }
%>
            <br><br><hr><br>
                        
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>