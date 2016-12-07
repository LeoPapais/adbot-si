<%-- 
    Página : Cadastro_de_usuario.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
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
            <br><br>

<%
            if ( request.getParameter("Campo_controle") != null ) { 
                
              
                CriacaoUpdateAdvertiserPublisherDTO u = new CriacaoUpdateAdvertiserPublisherDTO();
                u.setUserName( request.getParameter("UserName"));
                u.setSenha( request.getParameter("Senha"));
                u.setNome( request.getParameter("Nome"));
                u.setSobrenome( request.getParameter("Sobrenome"));
                u.setConta_de_banco( request.getParameter("Conta_banco"));
                u.setE_mail( request.getParameter("Email"));
                u.setTipo_Usuario( request.getParameter("Tipo_usuario"));
  
                // Cadastra dados 
                UsuarioController uc = new UsuarioController();
                boolean ud = uc.cadastroUsuario(u);
                if (ud==true){
                
                pageContext.forward("Cadastro_realizado.jsp");
                   
                }
                
                else {
                
                    %>
        <font size="4" color = "gray"><center><b>Erro de preenchimento</b></center></font>
          
                 <%
                }
                
            }
%>

            <center>
                <form method="post" action=Cadastro_de_usuario.jsp>
                    Nome de usuário <input type="text" name="UserName" required/>
                    <br><br>
                    Nome <input type="text" name="Nome"required />
                    <br><br>
                    Sobrenome <input type="text" name="Sobrenome" required/>
                    <br><br>
                    Senha <input type="password" name="Senha" required/>
                    <br><br>
                    Email <input type="email" name="Email" required/>
                    <br><br>
                    Tipo de usuario <td><input type="radio" name="Tipo_usuario" value="Publisher"/> Publisher
                                    <td><input type="radio" name="Tipo_usuario" value="Advertiser"/> Advertiser
                    
                    <br><br>
                    Conta de banco <input type="text" name="Conta_banco"required />
                    <br><br>
                    
                    <input type="submit" name="Botao_Cadastrar" value="Cadastrar" />
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
