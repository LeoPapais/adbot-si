<%-- 
    Página : Quebra_de_gastos.jsp
    Sistema de Informação : AdBot
    Disciplina: PMR2490 - Sistemas de Informação
    Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto
    Turma: 4(B) (2016)  Professor: José Reinaldo Silva  
    Desenvolvido em : NetBeans IDE 8.2, Java 1.8.0_111, GlassFish Server 4.1.1
    Histórico de edição deste arquivo :
            [02/11/2016] Diego - Versão inicial
            [04/11/2016] Diego - Edições adicionais na formatação
            [27/11/2016] Diego - Os estilos dos botões foram passados para o arquivo index.css
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!-- importando biblioteca SQL do Java -->
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
       pageContext.forward("Log_in_de_usuario.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");
    
    int Usuario_ID = Integer.parseInt(Usuario_ID_st);

%>    
    
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdBot Advertiser: Quebra de gastos Campaign/Media</title> <!-- Título da página -->
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
                <form action="Logout">
                    <input id="Botao_Log_out" type="submit" class="button_log_out" value="Logout">
                </form>
                <i><left><font color="#BF223C">&nbsp&nbsp&nbspAdBot: Advertiser</font></left></i>  
            </h2>
            
            <!------ Linha 2 ------>
            <a id="Botao_Perfil_advertiser" href="Perfil_de_advertiser.jsp" class="button_options">Perfil de <i>Advertiser</i></a>

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
            <h3><center><font size="5" color="#FF5773">Quebra de gastos <i>Campaign</i>/<i>Media</i></font></center></h3>

            <br><hr><br>
                        
            <table class="B">
                <tr class="B">
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Campaign</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Nome da <i>Media</i></center></th>
                    <th class="B" bgcolor="#FFFFFF"><center>Gasto total</center></th>
                </tr>
                
<%
                    CampaignController cc = new CampaignController();
                    Vector lista_quebra = cc.getQuebraCampaignMediaDTO(Usuario_ID);
                    if ( (lista_quebra == null) || (lista_quebra.size() == 0)) {
                        // avisar usuario que nao há Campaigns
%>
                        Nenhuma <i>Campaign</i> foi encontrada!
<%                  } else {
                        String CampaignNome;
                        String MediaNome;
                        float Gasto_total_Campaign_Media;
                        for(int i = 0; i < lista_quebra.size(); i++){
                            QuebraCampaignMediaDTO qc = (QuebraCampaignMediaDTO)lista_quebra.elementAt(i);
                            CampaignNome = qc.getCampaignNome();
                            MediaNome = qc.getMediaNome();
                            Gasto_total_Campaign_Media = qc.getGasto();
                    
                            // Obter os totais de gastos para cada Campaign com cada Media (pois uma Media 
                            // pode ter mais de um cliente que clicou na propaganda)
                                // * Os itens do query do banco de dados já estão ordenados de forma a simplificar
                                 // o procedimento abaixo.
                            if((i + 1) < lista_quebra.size()){
                                QuebraCampaignMediaDTO qc2 = (QuebraCampaignMediaDTO)lista_quebra.elementAt(i + 1);
                                while(qc.getCampaignID() == qc2.getCampaignID() && qc.getMediaID() == qc2.getMediaID() && ((i + 1) < lista_quebra.size())){

                                    Gasto_total_Campaign_Media += qc2.getGasto();
                                    i++;
                                    if((i + 1) >= lista_quebra.size())
                                        break;
                                    qc2 = (QuebraCampaignMediaDTO)lista_quebra.elementAt(i + 1);
                                }
                            }

%>                    
                            <tr class="B">
                                <td class="B"><%= CampaignNome %></td>
                                <td class="B"><%= MediaNome %>&nbsp</td>
                                <td class="B" style="text-align:right"><%= String.format("%1.2f", Gasto_total_Campaign_Media) %>&nbsp</td>
                            </tr>  

<%
                        }
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