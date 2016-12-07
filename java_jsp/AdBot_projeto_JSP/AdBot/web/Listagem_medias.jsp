<%-- 
    Página : Listagem_medias.jsp
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
<%@ page import="utils.Logout" %>               <!-- Importando Servlet de Logout -->

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
        <title>AdBot Publisher: Listagem de Medias</title> <!-- Título da página -->
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
                <form action="Logout">
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Log out">
                    <i><left><font color="#4CAF50">&nbsp&nbsp&nbspAdBot: Publisher</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_publisher" href="Perfil_de_publisher.jsp" class="button_options">Perfil de <i>Publisher</i></a>
            <font size="3" color="#4CAF50"><i>&nbsp&nbsp&nbspPublisher</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#4CAF50">Listagem de <i>Medias</i></font></center></h3>

            <br><hr><br>
                        
            <table class="B">
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Media</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center><i>Status</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Mode de Teste</th>
                    <th class="B" bgcolor="#FFFFFF"><center>Tipo de produto</th>
                    <th class="B" bgcolor="#FFFFFF"><center>Total de visualizações</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>CPC Mínimo</center></th>

                    <th class="B" bgcolor="#FFFFFF"><center>Ação</center></th>
                </tr>
                
<%
                    // Instanciar MediaController
                    MediaController mm = new MediaController();
                    
                    // Obter vetor com todas as Medias com os dados a serem exibidos na listagem
                    Vector lista = mm.getListagemMedias(Usuario_ID);
                    
                    // Verificar se há Medias a serem exibidas
                    if ( (lista == null) || (lista.size() == 0)) { // Avisar usuario que nao há Medias
%>
                        <tr class="B">
                            Nenhuma <i>Media</i> foi encontrada!
                        </tr>
<%                  } else { // Listagem de Medias

                        // Inicializar totais de visualizações
                        int Balanco_Total_visualizacoes = 0;

                        // Exibir todas as Medias na tela, em forma de tabela
                        for(int i = 0; i < lista.size(); i++){

                            // Obter uma das Medias da listagem
                            ListagemMediasDTO m = (ListagemMediasDTO)lista.elementAt(i);

                            // Atualizar totais de visualizações, clicks e gasto
                            Balanco_Total_visualizacoes += m.getTotal_visualizacoes();
%>                    
                            <!-- Exibir dados da linha da listagem de Medias -->
                            <tr class="B">
                                <td class="B"><b><%= m.getNome() %></b><br>&nbsp&nbsp</td>
                                <td class="B" style="text-align:right"><%= m.getEstado() %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= m.getTestMode() %>&nbsp</td>
                                <td class="B" style="text-align:center"><%= m.getTipo_produto() %>&nbsp</td>                             
                                <td class="B" style="text-align:right"><%= m.getTotal_visualizacoes()%>&nbsp</td>                       
                                <td class="B" style="text-align:right"><%= m.getCPC_minimo() %>&nbsp</td>    
<%                            
                            if(m.getEstado() == 0) {
%>    
                                    <th bgcolor="#90EE90">
                                        <table class="A">
                                            <tr>
                                                <center>
                                                    <input id=<%= String.format("Botao_%d_Pause", i)%>, type="button" class="button_pause" value="Pause">
                                                </center>
                                            </tr>
                                            <td class="A"><font size="4" color = "green"> <center>ATIVA</center></font></td>
                                        </table>
                                    </th>    
<%
                            } else { // Media inativa
%>
                                    <th bgcolor="#FFAF96">
                                        <table class="A">
                                            <tr>
                                                <center>
                                                    <input id=<%= String.format("Botao_%d_Play", i)%>, type="button" class="button_play" value="Play">
                                                </center>
                                            </tr>
                                            <td class="A"><font size="4" color = "red"> <center>INATIVA</center></font></td>  
                                        </table>
                                    </th>    
<%
                            }
%>
                                <!-- Botões de cada linha da listagem de Medias -->
                                <!-- Ao se clicar em um dos seguintes botões, o Media_ID é enviado para a próxima tela pelo método "GET" de processamento de formulário em JSP -->
                                <!-- Para pegar o parâmetro enviado, utilize o seguinte código JSP:
                                     String Media_ID_st = request.getParameter("Media_ID");
                                     session.setAttribute("Media_ID", Media_ID_st);    
                                     int Media_ID = Integer.parseInt(Media_ID_st);
                                -->
                                <th>
                                    <table class="A">
                                        <tr> 
                                            <center>
                                                <a id=<%= String.format("Botao_%d_Ver_media", i)%>, href="Atributos_de_uma_media.jsp?Media_ID=<%=m.getID()%>" class="button_menu">&nbsp&nbsp&nbsp&nbsp&nbsp&nbspVer&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                                            </center>
                                        </tr>
                                        <tr> 
                                            <center>
                                                <a id=<%= String.format("Botao_%d_Editar_media", i)%>, href="Edicao_de_media.jsp?Media_ID=<%=m.getID()%>" class="button_menu">&nbsp&nbsp&nbsp&nbspEditar&nbsp&nbsp&nbsp&nbsp</a>
                                            </center>
                                        </tr>
                                        <tr>
                                            <center>
                                                <a id=<%= String.format("Botao_%d_Remover_media", i)%>, href="Remover_media.jsp?Media_ID=<%=m.getID()%>" class="button_menu">&nbspRemover&nbsp</a>
                                            </center>
                                        </tr>
                                    </table>
                                </th>
                            </tr>  

<%
                        }
%>
                        <tr class="B"> <!-- Exibir os valores dos totais na última linha da tabela -->
                                <td class="B" bgcolor="#ADD8E6" style="text-align:center">Totais: </td>                               
                                <td class="B" bgcolor="#ADD8E6" style="text-align:center"> </td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:center"> </td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"> </td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= Balanco_Total_visualizacoes %>&nbsp</td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"> </td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"> </td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"> </td>                             
                        </tr>
<%
                    }
%>
            </table> 
                        
            <br><br>  
            <center> <!-- Botões embaixo da página -->
                <a id="Botao_Criar_media" href="Criacao_de_media.jsp" class="button_options">Criar <i>Media</i></a>
                <a id="Botao_Sumario_geral" href="Sumario_geral_das_metricas_de_performance_de_medias.jsp" class="button_options">Sumário geral</a>  
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