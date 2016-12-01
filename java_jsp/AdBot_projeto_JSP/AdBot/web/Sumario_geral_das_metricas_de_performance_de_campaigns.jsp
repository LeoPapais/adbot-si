<%-- 
    Página : Sumario_geral_das_metricas_de_performance_de_campaigns.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
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
%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Sumário geral das métricas de performance das Campaigns</title> <!-- Título da página -->
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
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                    <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
                </form> 
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>
            <font size="3" color="#BF223C"><i>&nbsp&nbsp&nbspAdvertiser</i>: <%= String.format("%s %s", ud.getNome(), ud.getSobrenome()) %> </font>
                
            <!------ Título da página ------>
            <h3><center><font size="5" color="#FF5773">Sumário geral das métricas de <i>performance</i>  das <i>Campaigns</i></font></center></h3>

            <br><hr><br>
                        
            <table class="B">
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Campaign</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>(Gasto total da <i>Campaign</i>)/<br> &nbsp(Total de visualizações) <br> (R$/visualização)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>(Gasto total da <i>Campaign</i>)/<br> &nbsp(Total de <i>clicks</i>) <br> (R$/<i>click</i>)</center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>(Total de <i>clicks</i>)/<br> &nbsp(Total de visualizações) <br> (<i>click(s)</i>/visualização)</center></th>
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
<%                  } else {

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
                            <tr class="B">
                                <td class="B"><b><%= c.getNome() %></b><br>&nbsp&nbsp<%= c.getClickURL() %></td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getGasto_total()/c.getTotal_visualizacoes()) %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getGasto_total()/c.getTotal_clicks()) %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", c.getTotal_clicks()/((float)c.getTotal_visualizacoes())) %>&nbsp</td>
                            </tr>  

<%
                        }
%>
                        <tr class="B"> <!-- Exibir os valores gerais na última linha da tabela -->
                            <td class="B" bgcolor="#ADD8E6" style="text-align:center">Valores gerais: </td>        
                            <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= String.format("%1.2f", Balanco_Gasto_total/Balanco_Total_visualizacoes) %>&nbsp</td>
                            <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= String.format("%1.2f", Balanco_Gasto_total/Balanco_Total_clicks) %>&nbsp</td>
                            <td class="B" bgcolor="#ADD8E6" style="text-align:right"><%= String.format("%1.2f", Balanco_Total_clicks/((float)Balanco_Total_visualizacoes)) %>&nbsp</td>          
                        </tr>
<%
                    }
%>
               
            </table> 
                        
            <br><br>  
            <center> <!-- Botão embaixo da página -->
                <a id="Botao_Voltar" href="Listagem_campaigns.jsp" class="button_options">Voltar</a> 
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