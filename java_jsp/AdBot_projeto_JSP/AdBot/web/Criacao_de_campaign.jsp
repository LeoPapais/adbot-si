
<html>
<header>
  <title>Inserir Contato</title>
</header>

<body bgcolor="white">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.sql.*" %>  <!importando biblioteca SQL do Java>
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes_Controller.*" %>
<%@ page import="data_Model.*" %>
<%@ page import="DTO_Objects.*" %>
<%@ page import="java.lang.Integer.*" %>

<! ------------------------------------------------------------>
<!--   se for o request inicial, mostrar somente o formulario -->

<%     if ( null == request.getParameterValues("incluir") ) {
%>
       <form action="./Criacao_de_campaign.jsp" method="post">
<%
    // Verificação manual do Log in e obter o Usuario_ID da página "Homepage.jsp"
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Homepage.jsp");
    }

    String Usuario_ID_st = (String)session.getAttribute("Usuario_ID");
    int Usuario_ID = Integer.parseInt(Usuario_ID_st);
%>
    Insira os parâmetros da campanha:

           <table>
            <tr>
               <td>Nome da Campanha</td>
               <td><input type="text" name="Nome" maxlength="500" required/>
            </tr>
            <tr>
               <td>clickURL</td>
               <td><input type="url" name="clickURL" maxlength="200" required/>
            </tr>
            <tr>
               <td>Bid</td>
               <td><input type="number" name="Bid" min="0" step="0.01" max="4000000000" required/>
            </tr>
            <tr>
               <td>Tipo do Produto</td>
               <td><input type="text" name="Tipo_produto" maxlength="25" required/>
            </tr>
            <tr>
               <td>Marca do Produto</td>
               <td><input type="text" name="Marca_produto" maxlength="25" required/>
            </tr>
            <tr>
               <td>Limite de Gasto</td>
               <td><input type="number" name="Limite_gasto" min="0" step="0.01" max="4000000000" required/>
            </tr>
            <tr>
               <td>Genero Alvo</td>
               <td><input type="radio" name="Genero_alvo" value="Masculino"/> Masculino
               <td><input type="radio" name="Genero_alvo" value="Feminino"/> Feminino
               <td><input type="radio" name="Genero_alvo" value="Outro"/> Outro
               <td><input type="radio" name="Genero_alvo" value="Qualquer" checked/> Qualquer
            </tr>
            <tr>
               <td>Idade Alvo Mínima</td>
               <td><input type="number" name="Idade_alvo_min" min="0" max="130"/>
            </tr>
            <tr>
               <td>Idade Alvo Máxima</td>
               <td><input type="number" name="Idade_alvo_max" min="0" max="130"/>
            </tr>
            <tr>
               <td>Link da Figura</td>
               <td><input type="url" name="Link_figura_da_impression" maxlength="1000" required/>
            </tr>
            <tr>
               <td>Black ou Whitelist?</td>
               <td><input type="radio" name="Black_ou_whitelist" value="Blacklist"/> Blacklist
               <td><input type="radio" name="Black_ou_whitelist" value="Whitelist"/> Whitelist
               <td><input type="radio" name="Black_ou_whitelist" value="None" checked/> None
            </tr>
          </table>
          <input type="submit" name="incluir" value="criar" />
        </form>

<%      } else { 
       CampaignController cc = new CampaignController();
       CreateUpdateCampaignDTO cDTO = new CreateUpdateCampaignDTO();
       cDTO.setNome(request.getParameter("Nome"));
       cDTO.setClickURL(request.getParameter("clickURL"));
       cDTO.setTipo_produto(request.getParameter("Tipo_produto"));
       cDTO.setMarca_produto(request.getParameter("Marca_produto"));
       cDTO.setGenero_alvo(request.getParameter("Genero_alvo"));
       cDTO.setLink_figura_da_impression(request.getParameter("Link_figura_da_impression"));
       cDTO.setBlack_ou_whitelist(request.getParameter("Black_ou_whitelist"));
       cDTO.setBid(Float.parseFloat(request.getParameter("Bid")));
       cDTO.setLimite_gasto(Float.parseFloat(request.getParameter("Limite_gasto")));
       cDTO.setAutorizacao(1);
       if (request.getParameter("Idade_alvo_min").length() > 0) 
           cDTO.setIdade_alvo_min(Integer.parseInt(request.getParameter("Idade_alvo_min")));
       else 
           cDTO.setIdade_alvo_min(0);
       if (request.getParameter("Idade_alvo_max").length() > 0) 
           cDTO.setIdade_alvo_max(Integer.parseInt(request.getParameter("Idade_alvo_max")));
       else
           cDTO.setIdade_alvo_max(130);
       
       if ( cc.criarCampaign(cDTO) ) {
         // avisar usuario que transacao foi feita com sucesso
%>
          Campaign Criada com sucesso!
          <form action="./Homepage.jsp" method="post">
             <input type="submit" name="voltar" value="Voltar" />
          </form>
<%     } else {
%>
          Erro ao criar Campaign. 
          Idade alvo máxima deve ser maior que a Idade alvo Mínima.
          Limite de gasto deve ser maior do que Bid.
          
          <form action="./Perfil_de_advertiser.jsp" method="post">
             <input type="submit" name="retry" value="Repetir" />
          </form>
<%     }
       }
%>

</body>
</html>
