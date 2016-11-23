<html>
<header>
  <title>Pesquisar Contato</title>
</header>

<body bgcolor="white">
<%@ page import="java.util.Vector" %>
<%@ page import="transacoes.Contato" %>
<%@ page import="data.ContatoDO" %>

<! ------------------------------------------------------------------->
<!--   sempre mostrar o formulario de busca, ateh acao ser "voltar" -->

<%     if ( null != request.getParameter("voltar")) {
%>        <jsp:forward page="./main.jsp" />
<%        return;
       }
%>

         <form action="./search.jsp" method="post">
<%
    // VERIFICACAO MANUAL DO LOGIN
    if ( session.getAttribute("user_name") == null) {
       pageContext.forward("index.jsp");
    }

    String nome1 = (String)session.getAttribute("user_name");
%>
    Bom dia <%= nome1 %> !!
           <table>
             <tr>
               <td>Nome para pesquisar: </td>
               <td><input type="text" name="nome" />
             </tr>
           </table>
           <input type="submit" name="pesquisar" value="pesquisar" />
           <input type="submit" name="voltar" value="voltar" />
         </form>

<! ------------------------------------------------------------------->
<!--   se nao for o request inicial, acionar a transacao de negocio -->


<%   if ( null != request.getParameter("pesquisar")) {  
       String nome = request.getParameter("nome");
       transacoes.Contato tn = new transacoes.Contato();
       Vector contatos = tn.pesquisar(nome);
       if ( (contatos == null) || (contatos.size() == 0)) {
         // avisar usuario que nao ha' contatos com este nome
%>
          Nenhum contato com este nome foi encontrado!
          <form action="./main.jsp" method="post">
             <input type="submit" name="voltar" value="Voltar" />
          </form>
<%     } else {
%>
          <table>
             <tr>
                <td>Nome</td>
                <td>Telefone</td>
             </tr>
<%           for(int i = 0; i < contatos.size(); i++) {
                ContatoDO contato = (ContatoDO)contatos.elementAt(i);
%>              <tr>
                   <td><%= contato.getNome() %></td>
                   <td><%= contato.getTelefone() %></td>
                </tr>        
<%           } // for i      
%>        </table>            
<%     } // contatos retornados
     } // pesquisar
%>

</body>
</html>
