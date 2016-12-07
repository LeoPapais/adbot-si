<%-- 
    Página : Listagem_campaigns.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
            [12/11/2016] Diego - Envio de parâmetro (Campaign_ID) para as páginas específicas de cada Campaign
            [27/11/2016] Diego - Os estilos dos botões foram passados para o arquivo index.css
            [28/11/2016] Victor Teodoro - Implementação do logout
            [01/12/2016] Diego - Verificação de tipo de usuário (se não for "Advertiser", não pode entrar nesta página) 
                               - Ajustes de comentários
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
    if ( ut.getTipo() == "Advertiser") { // Se o usuário não for Advertiser, não deixá-lo ir para esta página
        pageContext.forward("Homepage.jsp");
    }
    
    // Verificação de bloqueio do usuário
    UsuarioBloqueioDTO ub = uc.getBloqueioUsuario(Usuario_ID);
    if ( ub.getBloqueio() == 1) { // Se o usuário estiver bloqueado, não deixá-lo ir para esta página
        pageContext.forward("Perfil_de_advertiser.jsp");
    }
    
    // Nome + Sobrenome do usuário
    UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID); 
    
//    if (request.getParameter("Acao") != null){
//        // Case A - to unauthorize
//        if (Integer.parseInt( (String)request.getParameter("Acao") ) == 1){
//            System.out.println("Listagem_campaign.jsp: Action: unauthorize");
//            int id_to_use = Integer.parseInt( (String)request.getParameter("id_to_use") );
//            BloqueioCampaignDTO blockDTO = new BloqueioCampaignDTO( 0 );
//            AdministradorController adminCtl = new AdministradorController();
//            adminCtl.bloquearCampaign(id_to_use, blockDTO);
//            System.out.println("Listagem_Campaign.jsp: Action: unauthorize: proceed...");
//        } // fim: case a
//    }
%>    

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Listagem de Campaigns</title> <!-- Título da página -->
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
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdvertiser</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Listagem de <i>Campaigns</i></font></center></h3>

            <br><hr><br>
                        
            <table class="B">
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Campaign</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Tipo</th>                   
                    <th class="B" bgcolor="#FFFFFF"><center>Marca</th>                    
                    <th class="B" bgcolor="#FFFFFF"><center>Bid<br>(R$/click)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Total de visualizações</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Total de <i>clicks</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Gasto total da <i>Campaign</i> (R$)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Limite máximo de gasto (R$)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center><i>Status</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Ação</center></th>
                    <!--<th class="B" bgcolor="#FFFFFF"><center>Autorizacao</center></th>-->

                </tr>
                
<%
                    // Instanciar CampaignController
                    CampaignController cc = new CampaignController();
                    
                    // Obter vetor com todas as Campaigns com os dados a serem exibidos na listagem
                    Vector lista = cc.getListagemCampaigns(Usuario_ID);
                    
                    // Verificar se há Campaigns a serem exibidas
                    if ( (lista == null) || (lista.size() == 0)) { // Avisar usuario que nao há Campaigns
%>
                        <tr class="B">
                            Nenhuma <i>Campaign</i> foi encontrada!
                        </tr>
<%                  } else { // Listagem de Campaigns

                        // Inicializar totais de visualizações, clicks e gasto
                        int Balanco_Total_visualizacoes = 0;
                        int Balanco_Total_clicks = 0;
                        double Balanco_Gasto_total = 0;

                        // Exibir todas as Campaigns na tela, em forma de tabela
                        for(int i = 0; i < lista.size(); i++){

                            // Obter uma das Campaigns da listagem
                            ListagemCampaignsDTO c = (ListagemCampaignsDTO)lista.elementAt(i);

                            // Atualizar totais de visualizações, clicks e gasto
                            Balanco_Total_visualizacoes += c.getTotal_visualizacoes();
                            Balanco_Total_clicks += c.getTotal_clicks();
                            Balanco_Gasto_total += c.getGasto_total();
%>                    
                            <!-- Exibir dados da linha da listagem de Campaigns -->
                            <tr class="B">
                                <td class="B"><b><%= c.getNome() %></b><br>&nbsp&nbsp<%= c.getClickURL() %></td>
                                <td class="B" style="text-align:center"><%= c.getTipo_produto() %>&nbsp</td>
                                <td class="B" style="text-align:center"><%= c.getMarca_produto() %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getBid()) %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= c.getTotal_visualizacoes() %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= c.getTotal_clicks() %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getGasto_total()) %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getLimite_gasto()) %>&nbsp</td>
<%
                            if(c.getAutorizacao() == 0){ // Verificar autorização da Campaign (i.e., se foi bloqueada pelo Administrador)
%>    
                                    <th bgcolor="#D3D3D3">
                                        <table class="A">
                                            <tr>
                                                <center>
                                                    <input id=<%= String.format("Botao_%d_X", i)%>, onclick="return false" type="button" class="button_blocked" value="X">
                                                </center>
                                            </tr>
                                            <td class="A"><font size="4" color = "gray"> <center>BLOQUEADA<br> pelo Adm do <i>SI AdBot</i></center></font></td>
                                        </table>
                                    </th>    
<%    
                            } else if(c.getEstado() == 0){ // Campaign ativa

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
                            } else { // Campaign inativa
%>
                                    <th bgcolor="#FFAF96">
                                        <table class="A">
                                            <tr>
                                                <center>
                                                    <a id=<%= String.format("Botao_%d_Play", i)%>, href="Listagem_campaigns.jsp?Action=1&id_to_use=<%=c.getID()%>" type="button" class="button_play" value="Play"></a>
                                                </center>
                                            </tr>   
                                            <td class="A"><font size="4" color = "red"> <center>INATIVA</center></font></td>  
                                        </table>
                                    </th>    
<%
                            }
%>
                                <!-- Botões de cada linha da listagem de Campaigns -->
                                <!-- Ao se clicar em um dos seguintes botões, o Campaign_ID é enviado para a próxima tela pelo método "GET" de processamento de formulário em JSP -->
                                <!-- Para pegar o parâmetro enviado, utilize o seguinte código JSP:
                                     String Campaign_ID_st = request.getParameter("Campaign_ID");
                                     session.setAttribute("Campaign_ID", Campaign_ID_st);    
                                     int Campaign_ID = Integer.parseInt(Campaign_ID_st);
                                -->
                                <th>
                                    <table class="A">
                                        <tr> 
                                            <center>
                                                <a id=<%= String.format("Botao_%d_Ver_campaign", i)%>, href="Atributos_de_uma_campaign.jsp?Campaign_ID=<%=c.getID()%>" class="button_menu">&nbsp&nbsp&nbsp&nbsp&nbsp&nbspVer&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
                                            </center>
                                        </tr>
                                        <tr> 
                                            <center>
                                                <a id=<%= String.format("Botao_%d_Editar_campaign", i)%>, href="Edicao_de_campaign.jsp?Campaign_ID=<%=c.getID()%>" class="button_menu">&nbsp&nbsp&nbsp&nbspEditar&nbsp&nbsp&nbsp&nbsp</a>
                                            </center>
                                        </tr>
                                        <tr>
                                            <center>
                                                <input id=<%= String.format("Botao_%d_Remover_campaign", i)%>, href="Remover_campaign.jsp?Campaign_ID=<%=c.getID()%>" type="button" class="button_menu" value="&nbsp Remover &nbsp">
                                            </center>
                                        </tr>
                                    </table>
                                </th>
                                            
<!--                                <td>
                                    <table class="A">
                                        <tr>
                                            <center>
                                                <a id=<%= String.format("Botao_%d_desautorizar", i)%>, href="Listagem_campaigns.jsp?Acao=1&id_to_use=<%=c.getID()%>" type="button" class="button_blocked">&nbsp Remover &nbsp</a>
                                            </center>
                                        </tr>
                                    </table>
                                </td>-->
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
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= Balanco_Total_clicks %>&nbsp</td>
                                <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= String.format("%1.2f", Balanco_Gasto_total) %>&nbsp</td>
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
                <a id="Botao_Criar_campaign" href="Criacao_de_campaign.jsp" class="button_options">Criar <i>Campaign</i></a>
                <a id="Botao_Sumario_geral" href="Sumario_geral_das_metricas_de_performance_de_campaigns.jsp" class="button_options">Sumário geral</a>  
                <a id="Botao_Quebra_de_gastos" href="Quebra_de_gastos.jsp" class="button_options">Quebra de gastos</a> 
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