<%-- 
    Página : Descadastro_advertiser.jsp
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
<%@ page import="java.lang.Integer.*" %>

<!-- Importa classes do projeto (Servlets) -->
<%@ page import="utils.Logout" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<%         
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Homepage.jsp");
    } // fim: verificação
    int id_to_use = Integer.parseInt((String)request.getParameter("id_to_use"));
    if ( request.getParameter("Confirmar") != null ) { 
       System.out.println("confirmou");
       UsuarioController uctr = new UsuarioController();
       uctr.removerCadastro(id_to_use);
       pageContext.forward("Remocao_realizado.jsp");
}
%>

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
            <h3><font size="5"><center>Deseja se descadastrar?</center></font></h3>
            <br><br>


            <center>
                <table class="A">
                    <tr class ="C">
                        <td>
                            <form method="post" action="Descadastro_advertiser.jsp?id_to_use=<%=id_to_use%>">
                                <input id="Botao_confirmar" type="submit" class="button_options2" value="confirmar"/>
                                <input type="hidden" name="Confirmar" />
                            </form>
                        </td>
                        <td>
                            <center>
                                <a id=<%= String.format("Botao_cancelar")%>, href="Perfil_de_advertiser.jsp" class="button_blocked">&nbsp Cancelar &nbsp</a>
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <br><br>

            <img id="bottom" src="bottom.png" alt="">

            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>

        </div>    

    </body>

</html>
