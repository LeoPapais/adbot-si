<%-- 
    Document   : Edicao_de_perfil_de_publisher
    Created on : 19/11/2016, 18:20:04
    Author     : breno
--%>

  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!-- importando biblioteca SQL do Java -->
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="utils.Logout" %>


<!-- Importa classes do projeto (Servlets) -->


<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Atributos_de_uma_media.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");
    
    int Usuario_ID = Integer.parseInt(Usuario_ID_st);
    
    //Obtém o Media_ID passado pela página que chamou esta página (Atributos_de_uma_media.jsp)
    String Media_ID_st = request.getParameter("Media_ID");
    session.setAttribute("Media_ID", Media_ID_st);    
    int Media_ID = Integer.parseInt(Media_ID_st);
    
    boolean result = false;
    boolean movimentacao = false;

    UsuarioController userCTL = new UsuarioController();
    UsuarioNomeDTO userNameDTO = userCTL.getNomeUsuario(Usuario_ID);
    SaqueMediaDTO ps = new SaqueMediaDTO();
    MediaController mc = new MediaController();
    MovimentacaoDTO m = new MovimentacaoDTO();
    
    if ( request.getParameter("Dinheiro_Media_Edit") != null ) {       
        float Dinheiro_sacado = Float.parseFloat(request.getParameter("editDinheiroArrecadado"));        
        ps.setValor(Dinheiro_sacado);
        result = mc.saqueMedia(Media_ID, ps);       
        
        m.setValor(Dinheiro_sacado);
        m.setDescricao("saque");
        m.setData_movimentacao(new Date(System.currentTimeMillis()));
        movimentacao = userCTL.setMovimentacao(Usuario_ID, m);
        
        if (result && movimentacao){
            
            pageContext.forward("Atributos_de_uma_media.jsp");
        
        }else{
%>
        <font size="4" color = "gray"><center><b>ERRO AO ATUALIZAR DADOS NO SISTEMA</b></center></font>
          <center>
          <a id="Botao_Voltar" href="Atributos_de_uma_media.jsp" class="button_options"> Voltar </a>
          </center>
        
        
<%
    }

}
%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Publisher: Perfil de Publisher</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <link rel="shortcut icon" href="imagens/icone_publisher.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!-- Logout -->
            <h2>
                <form action="Logout">
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                    <i><left><font color="green">&nbsp&nbsp&nbspAdBot: Publisher</font></left></i>  
                </form> 
            </h2>
            
            <!-- Botao para retornar ao perfil -->
            <a id="Botao_Perfil_advertiser" href="Perfil_de_publisher.jsp" class="button_options">Perfil de <i>Publisher</i></a>
            <font size="3" color="green"><i>&nbsp&nbsp&nbspPublisher</i>: <%= String.format("%s %s", userNameDTO.getNome(), userNameDTO.getSobrenome()) %> </font>

            <!--Titulo da pagina-->
            <h3><center><font size="5" color="green">Saque de dinheiro</font></center></h3>

            <!--Campos para Edição do perfil-->
            <form method="post" action=Saque_de_dinheiro.jsp><center>
                <table>
                    <tr>
                        <th>Atributos</th>
                        <th>Valores</th>
                    </tr>
                    <tr>
                        <td>Valor retirado: R$</td>
                        <td><input type="text" name="editDinheiroArrecadado" /></td>
                    </tr>                    
                </table>
                <input id="botao_submit_changes" type="submit" name="Botao_Log_in" value="Finalizar Saque" />                
                <input type="hidden" name="Dinheiro_Media_Edit" />
                
                                
            </center></form>
            <br> <br>
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>