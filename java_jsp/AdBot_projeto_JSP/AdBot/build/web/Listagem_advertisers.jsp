<%-- 
    Página : Listagem_advertisers.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
            [12/11/2016] Diego - Envio de parâmetro (Campaign_ID) para as páginas específicas de cada Campaign
            [19/11/2016] Nelson - Adaptação para Listagem_advertisers.jsp
            [23/11/2016] Nelson - Atualização: segundo requisistos V3 e mudanças no database
            [28/11/2016] Nelson - Rename do arquivo Listagem_advertisers.jsp e alterações necessárias

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!--importando biblioteca SQL do Java-->
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

    int Usuario_ID = Integer.parseInt( (String)session.getAttribute("Usuario_ID") );
    
    //////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                      //
    // USECASE-AM07 IMPLEMENTAÇÃO DO BLOQUEIO E DESBOQUEIO DE USUARIO [Nelson: 20/11/2016]  //
    //                                                                                      //
    //////////////////////////////////////////////////////////////////////////////////////////

    if (request.getParameter("Action") != null){
        System.out.println("Listagem_advertisers.jsp: Action: " + request.getParameter("Action"));
        // Case A - to block advertiser
        if (Integer.parseInt( (String)request.getParameter("Action") ) == 1){
            System.out.println("Listagem_advertisers.jsp: Action: block");
            int id_to_use = Integer.parseInt( (String)request.getParameter("id_to_use") );
            BloqueioAdvertiserPublisherDTO blockDTO = new BloqueioAdvertiserPublisherDTO( 1 );
            AdministradorController adminCtl = new AdministradorController();
            adminCtl.bloquearAdvertiserPublisher(id_to_use, blockDTO);
            System.out.println("Listagem_advertisers.jsp: Action: block: proceed...");
        } // fim: case a
        
        // Case B - to unblock advetiser
        if (Integer.parseInt( (String)request.getParameter("Action") ) == 0){
            System.out.println("Listagem_advertisers.jsp: Action: unblock");
            int id_to_use = Integer.parseInt( (String)request.getParameter("id_to_use") );
            BloqueioAdvertiserPublisherDTO blockDTO = new BloqueioAdvertiserPublisherDTO( 0 );
            AdministradorController adminCtl = new AdministradorController();
            adminCtl.bloquearAdvertiserPublisher(id_to_use, blockDTO);
            System.out.println("Listagem_advertisers.jsp: Action: unblock: proceed...");
        } // fim: case b

    } // fim: bloqueio e desbloqueio de usuario

    //////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                      //
     //                                                                                    // 
      ////////////////////////////////////////////////////////////////////////////////////// 
%>    

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Administrador: Listagem de Advertisers</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <link rel="stylesheet" type="text/css" href="index.css">
        <script type="text/javascript" src="view.js"></script>
        <link rel="shortcut icon" href="imagens/icone_administrador.ico" type="image/x-icon" />
    </head>

    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>


            <!-- BOTÃO: LOGOUT -->
            <h2>     
                <form action="Logout">
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                </form>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Administrador</font></left></i>  
            </h2> 
            <!-- FIM: botão logout -->


            <!-- BOTÃO: RETORNAR AO PERFIL DO ADMINISTRADOR-->
            <a id="Botao_Perfil_Administrador" href="Perfil_de_administrador.jsp" class="button_options">Perfil de Administrador</a> 
            <!-- FIM: retorno ao perfil de administrador -->


            <!-- INDENTIFICAÇAO DO ADMINISTRADOR -->
            <%
            UsuarioController userCtl = new UsuarioController();
            UsuarioNomeDTO userNameDTO = userCtl.getNomeUsuario(Usuario_ID);
            %>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdministrador</i>: <%= String.format("%s %s", userNameDTO.getNome(), userNameDTO.getSobrenome()) %> </font>
            <!-- FIM: indentificaçao do administrador -->


            <!-- TÍTULO DA PÁGINA -->
            <h3><center><font size="5" color="#FF5773">Listagem de Advertisers</font></center></h3>
            <!-- fim: título da página -->

<!--

    //////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                      //
    // USECASE-AM06 LISTAGEM DE ADVERTISERS [Nelson: 20/11/2016]                            //
    //                                                                                      //
    //////////////////////////////////////////////////////////////////////////////////////////

-->
            <!--TABELA PARA LISTAR ADVERTISERS-->
            <br><hr><br>
            <table class="B"> 
                <!-- Headers da Tabela -->
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome do Advertiser<br>(E-mail)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>ID<br>(Data de Cadastro)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Crédito Disponível<br>(Conta do Banco)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Situação</center></th>
                </tr>
                <!--FIM: Headers da Tabela -->
<%
                    // Controller: Pega a listagem Advertisers
                    AdministradorController adminCtl = new AdministradorController();
                    Vector lista = adminCtl.getListagemAdvertisers();

                    // A) CASE: NÃO HÁ ADVERTISERS
                    if ( (lista == null) || (lista.size() == 0)) {
%>
                        <tr class="B">
                            Nenhum Advertiser detectado no sistema!
                        </tr>
<%                  } // fim: case a: sem advertisers

                    // B) CASE: HÁ ADVERTISERS
                    else {
                        for(int i = 0; i < lista.size(); i++){
                            ListagemAdvertisersDTO advDTO = (ListagemAdvertisersDTO)lista.elementAt(i);
%>                    
                            <tr class="B">
                                
                                <!-- 1) Identificação do advertiser -->
                                <td class="B"><b><%=advDTO.getNome()%>&nbsp<%=advDTO.getSobrenome()%></b><br>&nbsp&nbsp(<%= advDTO.getE_mail() %>) </td>
                                
                                <!-- 2) Cadastro: ID e data de cadastro -->
                                <td class="B" style="text-align:center"><%= advDTO.getID() %><br>
                                (<%= advDTO.getData_de_cadastro() %>)</td>
                                
                                <!-- 3) Situação Econômica: credito e conta -->
                                <td class="B" style="text-align:center"><%= advDTO.getCredito_disponivel() %>&nbsp<br>
                                (<%= advDTO.getConta_de_banco() %>)&nbsp </td>
                                
                                <!-- 4) Situação no Sistema: bloqueio -->
                                <% // CASO A - ADVERTISER BLOQUEADO
                                if ( advDTO.getBloqueio() == 1 ){ %>
                                    <th bgcolor="#FFAF96">
                                        <table class="A">
                                            <tr> 
                                                <center>
                                                    <font size="4" color = "red"> <center>BLOQUEADO</center></font>
                                                </center>
                                            </tr>
                                            <tr>
                                                <center>
                                                    <a id=<%= String.format("Botao_%d_to_block_or_not_to_block", i)%>, href="Listagem_advertisers.jsp?Action=0&id_to_use=<%=advDTO.getID()%>" class="button_menu">&nbsp Desbloquear &nbsp</a>
                                                </center>
                                            </tr>
                                        </table>
                                    </th>
                                <% } // fim: caso a - advertiser bloqueado
                                
                                // CASO B - ASVERTISER NÃO BLOQUEADO
                                else{%>
                                    <th bgcolor="#90EE90">
                                        <table class="A">
                                            <tr> 
                                                <center>
                                                    <font size="4" color = "green"> <center>ATIVO</center></font>
                                                </center>
                                            </tr>
                                            <tr> 
                                                <center>
                                                    <a id=<%= String.format("Botao_%d_to_block_or_not_to_block", i)%>, href="Listagem_advertisers.jsp?Action=1&id_to_use=<%=advDTO.getID()%>" class="button_menu">&nbsp Bloquear &nbsp</a>
                                                </center>
                                            </tr>
                                        </table>
                                    </th>
                                <% } // fim: caso b - advertiser não bloqueado
                        } // fim - for: percorre comprimento da lista de advertisers
                    } // fim: case b: há advertisers
%>
            </table> <!--fim: da tabela de listagem de advertisers-->     

<!--

    //////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                      //
    // FIM: USECASE-AM06 LISTAGEM DE advertisers [Nelson: 20/11/2016]                       //
    //                                                                                      //
    //////////////////////////////////////////////////////////////////////////////////////////

-->


            <!-- OUTRAS AÇÕES DO ADMINISTADOR -->            
            <!-- para acrescentar se quiser -->

            <br><br><hr><br>
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>
