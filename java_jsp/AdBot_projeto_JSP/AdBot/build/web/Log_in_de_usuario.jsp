<%-- 
    Página : Log_in_de_usuario.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - [TESTE] Versão inicial
            [04/11/2016] Diego - [TESTE] Edições adicionais na formatação
            [23/11/2016] Diego - [TESTE] Redirecionar para Perfil_de_advertiser.jsp
            [27/11/2016, 07:11:11] Victor - passei o estilo .css prum arquivo separado nas páginas jsp
            [27/11/2016] Diego - Usando ".button_options_homepage" de index.css
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!--importando biblioteca SQL do Java-->
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot - Log in de usuário</title>
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <script type="text/javascript" src="view.js"></script>
        <link rel="shortcut icon" href="imagens/icone_homepage.ico" type="image/x-icon" />
    </head>

    <body id="main_body" >

        <img id="top" src="top.png" alt="">
            
        <div id="form_container">
            <br>

            <h2><font size="6" color="48968E"><i><center>AdBot</center></i></font></h2>
            <h3><font size="4"><center><i>Adnetwork para anunciantes e desenvolvedores de ChatBots</i> </center></font></h3>
            
            <hr>
            
            <br>
            
                <font size="4">
                    <center>
                        <p>Entre com seu Usuário e Senha cadastrados no sistema.</p>
                    </center>
                </font>
            <br><br>
                    
            <hr>
            
<%
            if ( request.getParameter("Campo_controle") != null ) { 
                // Instanciar UsuarioController
                UsuarioController uc = new UsuarioController();
                
                // Verifica a senha
                String usuario = request.getParameter("usuario");
                String senha = request.getParameter("senha");
                int id = uc.verificaSenha(usuario, senha);
                
                // Se estiver OK, continua. Se não, imprime mensagem
                if (id != -1) {
                    String Usuario_ID = "" + id;
                    session.setAttribute("Usuario_ID", Usuario_ID);
                    // Verificação do tipo do usuário
                    UsuarioTipoDTO ut = uc.getTipoUsuario(id);
                    if (ut.getTipo().toLowerCase().equals("publisher")){
                        System.out.println("É publisher!");
                        pageContext.forward("Perfil_de_publisher.jsp");
                    }
                    else if (ut.getTipo().toLowerCase().equals("advertiser")) {
                        System.out.println("É advertiser!");
                        System.out.println("Usuario_ID = " + session.getAttribute("Usuario_ID"));
                        pageContext.forward("Perfil_de_advertiser.jsp");
                    }
                }
                else if (id == -1) { 
%>
                
                <center>
                    <font size="3" color="#E04C64">
                        <p>Usuário ou senha estão errados!</p><br>
                    </font>
                </center>
                
<%
                }                
            }
%>

            <br>

            <center>
                <form method="post" action="Log_in_de_usuario.jsp">
                    Usuário: <input type="text" name="usuario" /> <br><!-- No lugar disto, teria que estar UserName e Senha -->
                    Senha: &nbsp;&nbsp;<input type="password" name="senha" /> <br>
                    <input id="Botao_Log_in" type="submit" name="Botao_Log_in" value="Log in" />
                    <input type="hidden" name="Campo_controle" />
                </form>
            </center>
            <br><br>
                    
            <center>
                <a id="Botao_Voltar" href="Homepage.jsp" class="button_options_homepage"><i>Voltar</i></a>
            </center>
            <br><br>
 
            <hr>
                    
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>

        </div>    
                
        <img id="bottom" src="./bottom.png" alt="">

    </body>

</html>
