<%-- 
    Página : Perfil_de_advertiser.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [23/11/2016] Diego - Versão inicial
            [27/11/2016] Diego - Os estilos dos botões foram passados para o arquivo index.css
            [28/11/2016] Nelson - Implementação da página
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!-- importando biblioteca SQL do Java -->
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!-- Importa classes do projeto (Servlets) -->
<%@ page import="utils.Logout" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Log_in_de_usuario.jsp");
    }
    int usuario_ID = Integer.parseInt((String)session.getAttribute("Usuario_ID"));


    UsuarioController userCTL = new UsuarioController();
    UsuarioNomeDTO userNameDTO = userCTL.getNomeUsuario(usuario_ID);

    if ( request.getParameter("Profile_Edit") != null ) { 
        CriacaoUpdateAdvertiserPublisherDTO perfilAdvertiserDTO = new CriacaoUpdateAdvertiserPublisherDTO();
        perfilAdvertiserDTO.setUserName((String)request.getParameter("editUserName"));
        perfilAdvertiserDTO.setNome(request.getParameter("editNome"));
        perfilAdvertiserDTO.setSobrenome(request.getParameter("editSobrenome"));
        perfilAdvertiserDTO.setE_mail(request.getParameter("editE_mail"));
        perfilAdvertiserDTO.setConta_de_banco(request.getParameter("editConta_de_banco"));
        perfilAdvertiserDTO.setSenha(request.getParameter("editSenha"));
        perfilAdvertiserDTO.setTipo_Usuario(request.getParameter("editTipo_Usuario"));
        userCTL.editarPerfilAdvertiserPublisher( usuario_ID, perfilAdvertiserDTO );
        pageContext.forward("Perfil_de_advertiser.jsp");
    }


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
                
            <!-- Logout -->
            <h2>
                <form action="Logout">
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
                </form> 
            </h2>
            
            <!-- Botao para retornar ao perfil -->
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdministrador</i>: <%= String.format("%s %s", userNameDTO.getNome(), userNameDTO.getSobrenome()) %> </font>

            <!--Titulo da pagina-->
            <h3><center><font size="5" color="#FF5773">Edição do Perfil de Advertiser</font></center></h3>

            <!--Campos para Edição do perfil-->
            <form method="post" action=Edicao_de_perfil_de_advertiser.jsp><center>
                <table>
                    <tr>
                        <th>Atributos</th>
                        <th>Valores</th>
                    </tr>
                    <tr>
                        <td>UserName</td>
                        <td><input type="text" name="editUserName" /></td>
                    </tr>
                    <tr>
                        <td>Nome</td>
                        <td><input type="text" name="editNome" /></td>
                    </tr>
                    <tr>
                        <td>Sobrenome</td>
                        <td><input type="text" name="editSobrenome" /></td>
                    </tr>
                    <tr>
                        <td>E-mail</td>
                        <td><input type="text" name="editE_mail" /></td>
                    </tr>
                    <tr>
                        <td>Conta de Banco</td>
                        <td><input type="text" name="editConta_de_banco" /></td>
                    </tr>
                     <tr>
                         <td>Senha</td>
                         <td><input type="text" name="editSenha" /></td>
                     </tr>
                     <tr>
                         <td>Tipo de Usuário</td>
                         <td><input type="text" name="editTipo_Usuario" /></td>
                     </tr>
                </table>
                <input id="botao_submit_changes" type="submit" name="Botao_Log_in" value="Finalizar Edição" />
                <input type="hidden" name="Profile_Edit" />

            </center></form>
            <br> <br>
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>
