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
    if (!ut.getTipo().toLowerCase().equals("administrador")) { // Se o usuário não for Advertiser, não deixá-lo ir para esta página
        pageContext.forward("Homepage.jsp");
    }
    
    // Nome + Sobrenome do usuário
    UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID); 
%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Administrador: Perfil de Administrador</title> <!-- Título da página -->
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
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Administrador</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_administrador" href="Perfil_de_administrador.jsp" class="button_options">Perfil de <i>Administrador</i></a>

<%
            // Obter dados para visualização do perfil de Advertiser
            VisualizacaoAdministradorDTO va = uc.visualizarPerfilAdministrador(Usuario_ID);

            // Instanciar AdvertiserController
            AdministradorController ac = new AdministradorController();    
            
            // Criação de formato de data a exibir
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>

            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdministrador</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Perfil de <i>Administrador</i></font></center></h3>

            <br><hr><br>
            <center><IMG src="imagens/perfil_administrador.jpg" width="60" height="80" align="center" border="0"></center>
            <br> <font size="4" color = "A71010"><center><i>Username</i>: <%= String.format("%s", va.getUserName()) %></center></font>
            <br> <font size="4" color = "A71010"><center>Senha: <%= String.format("%s", va.getSenha()) %></center></font>
            <br> <font size="4"><center>Nome: <%= String.format("%s", va.getNome()) %></center></font>
            <br> <font size="4"><center>Sobrenome: <%= String.format("%s", va.getSobrenome()) %></center></font>
            <br> <font size="4"><center>E-mail: <%= String.format("%s", va.getE_mail()) %></center></font>
 
 
            <br> <font size="4"><center>Data de cadastro: <%= String.format("%s", dateFormat.format(va.getData_de_cadastro())) %></center></font>

                <br><br>  
                <center>
                    <a id="Botao_Editar_perfil" href="Edicao_de_perfil_de_administrador.jsp" class="button_options"> Editar perfil </a> 

                    <a id="Botao_Listagem_de_Campaigns" href="Listagem_campaigns.jsp" class="button_options">Listagem de <i> Campaigns </i></a> 
                </center>
        
            <br><br><hr><br>
                        
            <!-- Créditos -->
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
            
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>