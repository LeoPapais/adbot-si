<%-- 
    Página : Sumario_geral_das_metricas_de_performance_de_campaigns.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, Glass Fish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
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
       pageContext.forward("Log_in_de_usuario.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");
    int Usuario_ID = Integer.parseInt(Usuario_ID_st);

%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Sumário geral das métricas de performance das Campaigns</title> <!-- Título da página -->
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
                <input id="Botao_Log_out" type="button" class="button_log_out" value="Log out">    
                <!------ Implementar rotina de Log Out -> On click function ------>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_PErfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>

<%
            UsuarioController uc = new UsuarioController();
            UsuarioNomeDTO ud = uc.getNomeUsuario(Usuario_ID);
            UsuarioBloqueioDTO ub = uc.getBloqueioUsuario(Usuario_ID);
            
            if ( ub.getBloqueio() == 1) { // Se o usuário estiver bloqueado, não deixá-lo ir para esta página
                pageContext.forward("Perfil_de_advertiser.jsp");
            }
%>
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
                    CampaignController cc = new CampaignController();
                    Vector lista = cc.getListagemCampaigns(Usuario_ID);
                    if ( (lista == null) || (lista.size() == 0)) {
                        // avisar usuario que nao há Campaigns
%>
                        Nenhuma <i>Campaign</i> foi encontrada!
<%                  } else {
                        int Balanco_Total_visualizacoes = 0;
                        int Balanco_Total_clicks = 0;
                        double Balanco_Gasto_total = 0;
                        for(int i = 0; i < lista.size(); i++){
                            ListagemCampaignsDTO c = (ListagemCampaignsDTO)lista.elementAt(i);
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
                        <tr class="B">
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
            <center>
                <a id="Botao_Voltar" href="Listagem_campaigns.jsp" class="button_options">Voltar</a> 
            </center>
            <br><br><hr><br>
                        
            <div id="footer">
                <font size="4"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>
            </div>
        </div>

        <img id="bottom" src="bottom.png" alt="">

    </body>

</html>