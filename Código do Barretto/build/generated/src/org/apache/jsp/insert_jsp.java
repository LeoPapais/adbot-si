package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import transacoes.Contato;
import data.ContatoDO;

public final class insert_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<html>\r\n");
      out.write("<header>\r\n");
      out.write("  <title>Inserir Contato</title>\r\n");
      out.write("</header>\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"white\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<! ------------------------------------------------------------>\r\n");
      out.write("<!--   se for o request inicial, mostrar somente o formulario -->\r\n");
      out.write("\r\n");
     if ( null == request.getParameterValues("incluir") ) {

      out.write("\r\n");
      out.write("       <form action=\"./insert.jsp\" method=\"post\">\r\n");

    // VERIFICACAO MANUAL DO LOGIN
    if ( session.getAttribute("user_name") == null) {
       pageContext.forward("index.jsp");
       
      out.write("\r\n");
      out.write("           error\r\n");
      out.write("       ");

    }

    String nome = (String)session.getAttribute("user_name");

      out.write("\r\n");
      out.write("    Bom dia ");
      out.print( nome );
      out.write(" !!\r\n");
      out.write("\r\n");
      out.write("           <table>\r\n");
      out.write("            <tr>\r\n");
      out.write("               <td>Nome</td>\r\n");
      out.write("               <td><input type=\"text\" name=\"nome\" />\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("               <td>Telefone</td>\r\n");
      out.write("               <td><input type=\"text\" name=\"telefone\" />\r\n");
      out.write("            </tr>\r\n");
      out.write("          </table>\r\n");
      out.write("          <input type=\"submit\" name=\"incluir\" value=\"incluir\" />\r\n");
      out.write("        </form>\r\n");
      out.write("\r\n");
      } else { 

      out.write("\r\n");
      out.write("<! ------------------------------------------------------------------->\r\n");
      out.write("<!--   se nao for o request inicial, acionar a transacao de negocio -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
     String nome = request.getParameter("nome");
       String telefone = request.getParameter("telefone");
       transacoes.Contato tn = new transacoes.Contato();
       data.ContatoDO contato = new data.ContatoDO();
       contato.setNome(nome);
       contato.setTelefone(telefone); 
       if ( tn.incluir(contato)) {
         // avisar usuario que transacao foi feita com sucesso

      out.write("\r\n");
      out.write("          Transação realizada com sucesso!\r\n");
      out.write("          <form action=\"./main.jsp\" method=\"post\">\r\n");
      out.write("             <input type=\"submit\" name=\"voltar\" value=\"Voltar\" />\r\n");
      out.write("          </form>\r\n");
     } else {

      out.write("\r\n");
      out.write("          Erro ao incluir usuário            \r\n");
      out.write("          <form action=\"./insert.jsp\" method=\"post\">\r\n");
      out.write("             <input type=\"submit\" name=\"retry\" value=\"Repetir\" />\r\n");
      out.write("          </form>\r\n");
     }
       }

      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
