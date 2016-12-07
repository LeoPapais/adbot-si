﻿<%-- 
    Página : Perfil_de_advertiser.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [23/11/2016] Diego - Versão inicial
            [27/11/2016] Diego - Os estilos dos botões foram passados para o arquivo index.css
            [28/11/2016] Victor Teodoro - Implementação do logout
            [01/12/2016] Diego - Verificação de tipo de usuário (se não for "Advertiser", não pode entrar nesta página) 
                               - Ajustes de comentários
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>                 <!-- Importando biblioteca SQL do Java -->
<%@ page import="java.util.Vector" %>           <!-- Importando variável Vector de Java -->
<%@ page import="transacoes_Controller.*" %>    <!-- Importando Controllers -->
<%@ page import="data_Model.*" %>               <!-- Importando Models -->
<%@ page import="DTO_Objects.*" %>              <!-- Importando DTOs -->
<%@ page import="java.lang.Integer.*" %>        <!-- Importando Integer de Java (para poder utilizar Integer.parseInt) -->
<%@ page import="java.text.SimpleDateFormat" %> <!-- Importando SimpleDateFormat de Java (para formatação da exibição de data+horário) -->
                                 
<!-- Importa classes do projeto (Servlets) -->
<%@ page import="utils.Logout" %> <!-- [Victor Teodoro: 28/11/2016] -->

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Log_in_de_usuario.jsp");
    }
    
    //Pega o usuario
    System.out.println("Cheguei aqui!");
    int Usuario_ID = Integer.parseInt((String)session.getAttribute("Usuario_ID"));

    // Instanciar UsuarioController
    UsuarioController uc = new UsuarioController();
    
    // Verificação do tipo do usuário
    UsuarioTipoDTO ut = uc.getTipoUsuario(Usuario_ID);
    if (!ut.getTipo().toLowerCase().equals("advertiser")) { // Se o usuário não for Advertiser, não deixá-lo ir para esta página
        pageContext.forward("Homepage.jsp");
    }
    
    // Nome + Sobrenome do usuário
    UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID); 
%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Perfil de Advertiser</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>
                <form action="Logout"> <!-- [Victor Teodoro: 28/11/2016] -->
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Log out">
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>

<%
            // Obter dados para visualização do perfil de Advertiser
            VisualizacaoAdvertiserPublisherDTO vap = uc.visualizarPerfilAdvertiserPublisher(Usuario_ID);

            // Instanciar AdvertiserController
            AdvertiserController ac = new AdvertiserController();
            
            // Obter o Crédito disponível do Advertiser  
            AdvertiserCredito_disponivelDTO cd = ac.getCredito_disponivel(Usuario_ID);      
            
            // Criação de formato de data a exibir
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>

            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdvertiser</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Perfil de <i>Advertiser</i></font></center></h3>

            <br><hr><br>
            <center><IMG src="imagens/perfil_advertiser.jpg" width="60" height="80" align="center" border="0"></center>
            <br> <font size="4" color = "A71010"><center><i>Username</i>: <%= String.format("%s", vap.getUserName()) %></center></font>
            <br> <font size="4" color = "A71010"><center>Senha: <%= String.format("%s", vap.getSenha()) %></center></font>
            <br> <font size="4"><center>Nome: <%= String.format("%s", vap.getNome()) %></center></font>
            <br> <font size="4"><center>Sobrenome: <%= String.format("%s", vap.getSobrenome()) %></center></font>
            <br> <font size="4"><center>E-mail: <%= String.format("%s", vap.getE_mail()) %></center></font>
            <br> <font size="4"><center>Conta de banco: <%= String.format("%s", vap.getConta_de_banco()) %></center></font>
            <br> <font size="4"><center>Crédito disponivel: R$ <%= String.format("%1.2f", cd.getCredito_disponivel()) %></center></font>
            <br> <font size="4"><center>Data de cadastro: <%= String.format("%s", dateFormat.format(vap.getData_de_cadastro())) %></center></font>
<%
            if(vap.getBloqueio() == 1){ // Se o usuário estiver bloqueado
%>
                <br>
                <font size="4" color = "gray"><center><b>BLOQUEADO<br> pelo Adm do <i>SI AdBot</i></b></center></font>
                <br><br>  
                <center>
                    <a id="Botao_Editar_perfil" class="button_blocked"> Editar perfil </a> 
                    <a id="Botao_Inserir_credito" class="button_blocked">Inserir crédito</a> 
                    <a id="Botao_Listagem_de_Campaigns" class="button_blocked">Listagem de <i> Campaigns </i></a> 
                </center>               
                <center>
                    <a id="Botao_Historico_de_movimentacao" href="Historico_de_movimentacao_advertiser.jsp" class="button_blocked">Histórico de movimentação</a> 
                    <a id="Botao_Balance_do_usuario" href="Balance_do_advertiser.jsp" class="button_blocked"><i>Balance</i> do usuário</a> 
                </center> 
<%
            } else{ // Se o usuário não estiver bloqueado
%>  
                <br><br>  
                <center>
                    <a id="Botao_Editar_perfil" href="Edicao_de_perfil_de_advertiser.jsp" class="button_options"> Editar perfil </a> 
                    <a id="Botao_Inserir_credito" href="Insercao_de_credito.jsp" class="button_options">Inserir crédito</a> 
                    <a id="Botao_Listagem_de_Campaigns" href="Listagem_campaigns.jsp" class="button_options">Listagem de <i> Campaigns </i></a> 
                </center>
                <center>
                    <a id="Botao_Historico_de_movimentacao" href="Historico_de_movimentacao_advertiser.jsp" class="button_balance">Histórico de movimentação</a> 
                    <a id="Botao_Balance_do_usuario" href="Balance_do_advertiser.jsp" class="button_balance"><i>Balance</i> do usuário</a> 
                </center>
<%
            }
%>
            <br><br><hr><br>
                        
            <!-- Créditos -->
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
            
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>