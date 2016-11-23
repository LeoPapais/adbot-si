<%-- 
    Página : Listagem_campaigns.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
            [12/11/2016] Diego - Envio de parâmetro (Campaign_ID) para as páginas específicas de cada Campaign
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Homepage.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");

    int Usuario_ID = Integer.parseInt(Usuario_ID_st);

%>    

    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Listagem de Campaigns</title> <!-- Título da página -->
        <link rel="stylesheet" type="text/css" href="view.css" media="all">
        <script type="text/javascript" src="view.js"></script>
        <style type="text/css">

            .button_menu {
                background-color: #FF91A4;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            .button_options {
                background-color: #E04C64;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: right;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }   
            
            .button_log_out {
                background-color: #64AEA6;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            } 
            
            .button_play {
                background-color: #FF3F3F;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }  
            
            .button_pause {
                background-color: #4CAF50;
                border: none;
                color: white;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            .button_blocked {
                background-color: #919191;
                border: none;
                color: black;
                padding: 10px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                margin: 2px 2px;
                cursor: pointer;
            }
            
            
            table.A {
                width: 100%; 
            }

            table.B {
                width: 100%; 
                padding: 5px;
                border-spacing: 5px;
                border-collapse: collapse;
                overflow: scroll;
                border-style: solid;
                border-width: 5px;
                border-color: #FF91A4;
            }

            th.B {
                border: 1px solid graytext;
                border-collapse: collapse;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            td.B {
                border: 1px solid graytext;
                border-collapse: collapse;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            tr.B:nth-child(even) {
                background-color: #FFC0CB;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            tr.B:nth-child(odd) {
                background-color:#fff;
                border-style: solid;
                border-width: 3px;
                border-color: #FF91A4;
            }

            hr {
                border: none;
                height: 5px;
                background-color: #eee;
            }
        </style>
        <link rel="shortcut icon" href="imagens/icone_advertiser.ico" type="image/x-icon" />
    </head>

    <body id="main_body" >

        <img id="top" src="top.png" alt="">
        <div id="form_container">
            <br>
                
            <!------ Linha 1 ------>
            <h2>     
                <input id="Botao_Log_out" type="button" class="button_log_out" value="Log out"> <!------ Implementar rotina de Log Out ... ------>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>

<%
            UsuarioController uc = new UsuarioController();
            UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID);
%>
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
                </tr>
                
<%
                    CampaignController cc = new CampaignController();
                    Vector lista = cc.getListagemCampaigns(Usuario_ID);
                    if ( (lista == null) || (lista.size() == 0)) {
                        // avisar usuario que nao há Campaigns
%>
                        <tr class="B">
                            Nenhuma <i>Campaign</i> foi encontrada!
                        </tr>
<%                  } else {
                        String Autorizacao_Campaign;
                        int Balanco_Total_visualizacoes = 0;
                        int Balanco_Total_clicks = 0;
                        double Balanco_Gasto_total = 0;
                        for(int i = 0; i < lista.size(); i++){
                            ListagemCampaignsDTO c = (ListagemCampaignsDTO)lista.elementAt(i);

                            // Totais
                            Balanco_Total_visualizacoes += c.getTotal_visualizacoes();
                            Balanco_Total_clicks += c.getTotal_clicks();
                            Balanco_Gasto_total += c.getGasto_total();

                            // Verificar autorização da Campaign (i.e., se foi bloqueada pelo Administrador)
                                    // * "false" e "true" precisam estar escritos com letras minúsulas
                            if(c.getAutorizacao() == 0)
                                Autorizacao_Campaign = "false";
                            else 
                                Autorizacao_Campaign = "true";

%>                    
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
                            if(Autorizacao_Campaign == "false"){ // Campaign bloqueada
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
                                            <input id=<%= String.format("Botao_%d_Play", i)%>, type="button" class="button_play" value="Play">
                                        </center>
                                    </tr>
                                    <td class="A"><font size="4" color = "red"> <center>INATIVA</center></font></td>  
                                </table>
                            </th>    
<%
                            }
%>
               

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
                        </tr>  

<%
                        }
%>
                        <tr class="B">
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
            <center>
                <a id="Bota_Criar_campaign" href="Criacao_de_campaign.jsp" class="button_options">Criar <i>Campaign</i></a>
                <a id="Bota_Sumario_geral" href="Sumario_geral_das_metricas_de_performance_de_campaigns.jsp" class="button_options">Sumário geral</a>  
                <a id="Bota_Quebra_de_gastos" href="Quebra_de_gastos.jsp" class="button_options">Quebra de gastos</a> 
            </center>
            <br><br><hr><br>
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>