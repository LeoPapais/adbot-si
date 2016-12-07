<html>
<header>
  <title>Pesquisar Contato</title>
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

<%     if ( null != request.getParameter("voltar")) {
%>        <jsp:forward page="./Listagem_campaigns" />
<%        return;
       }

       String Campaign_ID_str = request.getParameter("Campaign_ID");
       
       if(null == request.getParameter("editou")){
           
%>

         <form action="./Edicao_de_campaign.jsp?Campaign_ID=<%=Campaign_ID_str%>" method="post">
<%
    // VERIFICACAO MANUAL DO LOGIN
    if ( session.getAttribute("Usuario_ID") == null) {
       pageContext.forward("Homepage.jsp");
    }
    
    int Campaign_ID = Integer.parseInt(Campaign_ID_str);
    
    CampaignController cc = new CampaignController();
    VisualizacaoCampaignDTO c = cc.visualizarCampaign(Campaign_ID) ;
%>
           Insira os parâmetros da campanha <%=Campaign_ID_str%>:
           <table>
            <tr>
               <td>Nome da Campanha</td>
               <td><input type="text" name="Nome" maxlength="500" value="<%=c.getNome()%>" required/>
            </tr>
            <tr>
               <td>clickURL</td>
               <td><input type="url" name="clickURL" maxlength="200"  value="<%=c.getClickURL()%>" required/>
            </tr>
            <tr>
               <td>Bid</td>
               <td><input type="number" name="Bid" min="0" step="0.01" max="4000000000"  value="<%=c.getBid()%>" required/>
            </tr>
            <tr>
               <td>Tipo do Produto</td>
               <td><input type="text" name="Tipo_produto" maxlength="25" value="<%=c.getTipo_produto()%>"required/>
            </tr>
            <tr>
               <td>Marca do Produto</td>
               <td><input type="text" name="Marca_produto" maxlength="25" value="<%=c.getMarca_produto()%>" required/>
            </tr>
            <tr>
               <td>Limite de Gasto</td>
               <td><input type="number" name="Limite_gasto" min="0" step="0.01" max="4000000000" value="<%=c.getLimite_gasto()%>" required/>
            </tr>
            <tr>
               <td>Genero Alvo</td>
               <td><input type="radio" name="Genero_alvo" value="Masculino" <%if("Masculino".equals(c.getGenero_alvo())){%> checked <%}%>/> Masculino
               <td><input type="radio" name="Genero_alvo" value="Feminino" <%if("Feminino".equals(c.getGenero_alvo())){%> checked<%}%>/> Feminino
               <td><input type="radio" name="Genero_alvo" value="Outro" <%if("Outro".equals(c.getGenero_alvo())){%> checked<%}%>/> Outro
               <td><input type="radio" name="Genero_alvo" value="Qualquer" <%if("Qualquer".equals(c.getGenero_alvo())){%> checked<%}%> /> Qualquer
            </tr>
            <tr>
               <td>Idade Alvo Mínima</td>
               <td><input type="number" name="Idade_alvo_min" min="0" max="130" value="<%=c.getIdade_alvo_min()%>"/>
            </tr>
            <tr>
               <td>Idade Alvo Máxima</td>
               <td><input type="number" name="Idade_alvo_max" min="0" max="130" value="<%=c.getIdade_alvo_max()%>"/>
            </tr>
            <tr>
               <td>Link da Figura</td>
               <td><input type="url" name="Link_figura_da_impression" maxlength="1000" value="<%=c.getLink_figura_da_impression()%>" required/>
            </tr>
            <tr>
               <td>Black ou Whitelist?</td>
               <td><input type="radio" name="Black_ou_whitelist" value="Blacklist" <%if("Blacklist".equals(c.getBlack_ou_whitelist())){%> checked<%}%>/> Blacklist
               <td><input type="radio" name="Black_ou_whitelist" value="Whitelist" <%if("Whitelist".equals(c.getBlack_ou_whitelist())){%> checked<%}%>/> Whitelist
               <td><input type="radio" name="Black_ou_whitelist" value="None"  <%if("None".equals(c.getBlack_ou_whitelist())){%> checked<%}%>/> None
            </tr>
          </table>
          <input type="submit" name="editou" value="feito" />
        </form>
<%
       }
       else { 
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
       cDTO.setIdade_alvo_min(Integer.parseInt(request.getParameter("Idade_alvo_min")));
       cDTO.setIdade_alvo_min(Integer.parseInt(request.getParameter("Idade_alvo_max")));
       int Usuario_ID = Integer.parseInt((String) session.getAttribute("Usuario_ID"));
       if ( cc.editarCampaign(Usuario_ID, Integer.parseInt(Campaign_ID_str), cDTO) ) {
         // avisar usuario que transacao foi feita com sucesso
%>
          Campaign Editada com sucesso!
          <form action="./Listagem_campaigns.jsp" method="post">
             <input type="submit" name="voltar" value="Voltar" />
          </form>
<%     } else {
%>
          Erro ao Editar Campaign. 
          Idade alvo máxima deve ser maior que a Idade alvo Mínima.
          Gasto Máximo deve ser maior do que Bid.
          
          <form action="./Listagem_campaigns.jsp" method="post">
             <input type="submit" name="retry" value="Repetir" />
          </form>
<%     }
       }%>
</body>
</html>
