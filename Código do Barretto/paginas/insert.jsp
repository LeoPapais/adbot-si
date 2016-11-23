<html>
<header>
  <title>Inserir Contato</title>
</header>

<body bgcolor="white">
<%@ page import="transacoes.Contato" %>
<%@ page import="data.ContatoDO" %>

<! ------------------------------------------------------------>
<!--   se for o request inicial, mostrar somente o formulario -->

<%     if ( null == request.getParameterValues("incluir") ) {
%>
       <form action="./insert.jsp" method="post">
<%
    // VERIFICACAO MANUAL DO LOGIN
    if ( session.getAttribute("user_name") == null) {
       pageContext.forward("index.jsp");
    }

    String nome = (String)session.getAttribute("user_name");
%>
    Bom dia <%= nome %> !!

           <table>
            <tr>
               <td>Nome</td>
               <td><input type="text" name="nome" />
            </tr>
            <tr>
               <td>Telefone</td>
               <td><input type="text" name="telefone" />
            </tr>
          </table>
          <input type="submit" name="incluir" value="incluir" />
        </form>

<%      } else { 
%>
<! ------------------------------------------------------------------->
<!--   se nao for o request inicial, acionar a transacao de negocio -->


<%     String nome = request.getParameter("nome");
       String telefone = request.getParameter("telefone");
       transacoes.Contato tn = new transacoes.Contato();
       data.ContatoDO contato = new data.ContatoDO();
       contato.setNome(nome);
       contato.setTelefone(telefone); 
       if ( tn.incluir(contato)) {
         // avisar usuario que transacao foi feita com sucesso
%>
          Transação realizada com sucesso!
          <form action="./main.jsp" method="post">
             <input type="submit" name="voltar" value="Voltar" />
          </form>
<%     } else {
%>
          Erro ao incluir usuário            
          <form action="./insert.jsp" method="post">
             <input type="submit" name="retry" value="Repetir" />
          </form>
<%     }
       }
%>

</body>
</html>
