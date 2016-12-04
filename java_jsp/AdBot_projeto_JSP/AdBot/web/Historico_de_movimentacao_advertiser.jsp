<%-- 
    Document   : Historico_de_movimentacao_publisher
    Created on : 04/12/2016, 19:13:04
    Author     : Victor
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>                 <!-- Importando biblioteca SQL do Java -->
<%@ page import="java.util.Vector" %>           <!-- Importando variável Vector de Java -->
<%@ page import="java.util.List" %>             <!-- Importando Listas -->
<%@ page import="transacoes_Controller.*" %>    <!-- Importando Controllers -->
<%@ page import="data_Model.*" %>               <!-- Importando Models -->
<%@ page import="DTO_Objects.*" %>              <!-- Importando DTOs -->
<%@ page import="java.lang.Integer.*" %>        <!-- Importando Integer de Java (para poder utilizar Integer.parseInt) -->
<%@ page import="java.text.SimpleDateFormat" %> <!-- Importando SimpleDateFormat de Java (para formatação da exibição de data+horário) -->
                                 
<!-- Importa Servlets -->
<%@ page import="utils.Logout" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Movimentação de Advertiser</title> 
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="stylesheet" type="text/css" href="table-advertiser.css">
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >
        <%
            // Verificação manual do Log in
            if ( session.getAttribute("Usuario_ID") == null) {
               pageContext.forward("Log_in_de_usuario.jsp");
            }
            
            //Obtém o ID do usuário
            int usuario_id = Integer.parseInt((String)session.getAttribute("Usuario_ID"));

            // Instanciar UsuarioController
            UsuarioController uc = new UsuarioController();
            
            // Verificação do tipo do usuário
            UsuarioTipoDTO ut = uc.getTipoUsuario(usuario_id);
            if ( ut.getTipo() == "Advertiser") {
                pageContext.forward("Homepage.jsp");
            }

            // Nome + Sobrenome do usuário
            UsuarioNomeDTO ud = uc.getNomeUsuario(usuario_id);
        %>

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>
                <form action="Logout"> <!-- [Victor Teodoro: 28/11/2016] -->
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                    <left><font color="#E04C64">&nbsp&nbsp&nbspAdBot: Advertiser</font></left> 
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de Advertiser</a>

<%           
            // Obter dados para visualização do perfil de Advertiser
            VisualizacaoAdvertiserPublisherDTO vap = uc.visualizarPerfilAdvertiserPublisher(usuario_id);
            
            // Obtém os dados das movimentações do advertiser
            List<MovimentacaoDTO> movimentacoes = uc.getMovimentacao(usuario_id);
            
            // Cria o formato de hora e data a ser exibido
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>

            <font size="3" color="#BF223C">&nbsp&nbsp&nbspAdvertiser: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#E04C64">Movimentações de Advertiser</font></center></h3>

            <br><hr><br>
            <center><IMG src="imagens/perfil_advertiser.jpg" width="60" height="80" align="center" border="0"></center>
            <br>
            <center>
                <table>
                    <tr>
                      <th>ID</th>
                      <th>Valor</th>
                      <th>Descrição</th>
                      <th>Data e Hora</th>
                    </tr>
                    <% for (int i = 0; i < movimentacoes.size(); ++i){
                    %>
                        <tr>
                            <% MovimentacaoDTO movimentacao = movimentacoes.get(i); %>
                            <td> <%= movimentacao.getId() %> </td>
                            <td> <%= String.format("%6.2f", movimentacao.getValor()) %> </td>
                            <td> <%= movimentacao.getDescricao() %> </td>
                            <td> <%= dateFormat.format(movimentacao.getDataHora()) %> </td>
                    <%
                    }
                    %>
                    <br>
                </table>
            </center>
                
<%
            if(vap.getBloqueio() == 1){ // Se o usuário estiver bloqueado
%>
                <br>
                <font size="4" color = "gray"><center><b>BLOQUEADO<br> pelo Adm do SI AdBot</b></center></font>
                <br><br>  
                <center>
                    <a id="Botao_Editar_perfil" class="button_blocked"> Editar perfil </a> 
                    <a id="Botao_Inserir_credito" class="button_blocked">Inserir crédito</a> 
                    <a id="Botao_Listagem_de_Campaigns" class="button_blocked">Listagem de Campaigns</a> 
                    <a id="Botao_Balance_do_usuario" href="Balance_do_usuario.jsp" class="button_blocked"><i>Balance</i> do usuário</a> 
                </center> 
<%
            } else{ // Se o usuário não estiver bloqueado
%>  
                <br><br>  
                <center>
                    <a id="Botao_Editar_perfil" href="Edicao_de_perfil_de_advertiser.jsp" class="button_options"> Editar perfil </a> 
                    <a id="Botao_Inserir_credito" href="Insercao_de_credito.jsp" class="button_options">Inserir crédito</a> 
                    <a id="Botao_Listagem_de_Campaigns" href="Listagem_campaigns.jsp" class="button_options">Listagem de Campaigns</a> 
                    <a id="Botao_Balance_do_usuario" href="Balance_do_usuario.jsp" class="button_balance">Balance do usuário</a> 
                </center>
<%
            }
%>
            <br><br><hr><br>
                        
            <!-- Créditos -->
            <div id="footer">
                <font size="4">AdBot - PMR2490 (turma 4-B)</a></font>
            </div>
            
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>
</html>
