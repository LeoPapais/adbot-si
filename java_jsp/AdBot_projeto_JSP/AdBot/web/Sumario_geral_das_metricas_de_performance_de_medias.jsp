<%-- 
    Página : Sumario_geral_das_metricas_de_performance_de_medias.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [06/12/2016] Gabriel - Versão inicial
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>                 <!-- Importando biblioteca SQL do Java -->
<%@ page import="java.util.Vector" %>           <!-- Importando variável Vector de Java -->
<%@ page import="transacoes_Controller.*" %>    <!-- Importando Controllers -->
<%@ page import="data_Model.*" %>               <!-- Importando Models -->
<%@ page import="DTO_Objects.*" %>              <!-- Importando DTOs -->
<%@ page import="java.lang.Integer.*" %>        <!-- Importando Integer de Java (para poder utilizar Integer.parseInt) -->
<%@ page import="utils.Logout" %>               <!-- Importando Servlet de Logout [Victor Teodoro: 28/11/2016] -->

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in
    if ( session.getAttribute("Usuario_ID") == null ) {
       pageContext.forward("Log_in_de_usuario.jsp");
    }
    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID"); // Obter o Usuario_ID da página "Homepage.jsp"
    int Usuario_ID = Integer.parseInt(Usuario_ID_st); // Converter para número

    // Instanciar UsuarioController
    UsuarioController uc = new UsuarioController();
        
    // Verificação do tipo do usuário
    UsuarioTipoDTO ut = uc.getTipoUsuario(Usuario_ID);
    if ( ut.getTipo() == "Publisher") { // Se o usuário não for Publisher, não deixá-lo ir para esta página
        pageContext.forward("Homepage.jsp");
    }
    
    // Verificação de bloqueio do usuário
    UsuarioBloqueioDTO ub = uc.getBloqueioUsuario(Usuario_ID);
    if ( ub.getBloqueio() == 1) { // Se o usuário estiver bloqueado, não deixá-lo ir para esta página
        pageContext.forward("Perfil_de_publisher.jsp");
    }
    
    // Nome + Sobrenome do usuário
    UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID); 
%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Publisher: Sumário geral das métricas de performance das Medias</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <link rel="stylesheet" type="text/css" href="index.css"> <!-- Arquivo com as formatações de página e cores dos tipos de botão -->
        <link rel="shortcut icon" href="imagens/icone_publisher.ico" type="image/x-icon" />
    </head>
    
    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>
                <form action="Logout"> <!-- [Victor Teodoro: 28/11/2016] -->
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Log out">
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Publisher</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_publisher" href="Perfil_de_publisher.jsp" class="button_options">Perfil de <i>Publisher</i></a>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspPublisher</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Sumário geral das métricas de <i>performance</i>  das <i>Medias</i></font></center></h3>

            <br><hr><br>
                        
            <table class="B">
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Media</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>(Gasto total da <i>Media</i>)/<br> &nbsp(Total de visualizações) <br> (R$/visualização)</center></th>
                </tr>
                
<%
                    // Instanciar MediaController
                    MediaController cc = new MediaController();
                    
                    // Obter vetor com todas as Medias com os dados a serem exibidos na listagem
                    Vector lista = cc.getListagemMedias(Usuario_ID);
                    
                    // Verificar se há Medias a serem exibidas
                    if ( (lista == null) || (lista.size() == 0)) { // Avisar usuario que nao há Medias
%>
                        <tr class="B">
                            Nenhuma <i>Media</i> foi encontrada!
                        </tr>
<%                  } else {

                        // Inicializar totais de visualizações, clicks e gasto
                        int Balanco_Total_visualizacoes = 0;
                        int Balanco_Total_clicks = 0;
                        double Balanco_Gasto_total = 0;

                        // Exibir todas as Medias na tela, em forma de tabela
                        for(int i = 0; i < lista.size(); i++){

                            // Obter uma das Medias da listagem
                            ListagemMediasDTO c = (ListagemMediasDTO)lista.elementAt(i);

                            // Atualizar totais de visualizações, clicks e gasto
                            Balanco_Total_visualizacoes += c.getTotal_visualizacoes();
%>                    
                            <tr class="B">
                                <td class="B"><b><%= c.getNome() %></b></td>
                                <td class="B" style="text-align:right"><%= c.getTotal_visualizacoes() %>&nbsp</td>
                            </tr>  

<%
                        }

                    }
%>
               
            </table> 
                        
            <br><br>  
            <center> <!-- Botão embaixo da página -->
                <a id="Botao_Voltar" href="Listagem_medias.jsp" class="button_options">Voltar</a> 
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