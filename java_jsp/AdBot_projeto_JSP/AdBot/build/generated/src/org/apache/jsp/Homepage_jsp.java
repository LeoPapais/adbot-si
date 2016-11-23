package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Vector;
import transacoes_Controller.*;
import data_Model.*;
import DTO_Objects.*;

public final class Homepage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
      out.write("  <!importando biblioteca SQL do Java>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>AdBot</title>\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"view.css\" media=\"all\">\n");
      out.write("        <script type=\"text/javascript\" src=\"view.js\"></script>\n");
      out.write("        <link rel=\"shortcut icon\" href=\"imagens/icone_homepage.ico\" type=\"image/x-icon\" />\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body id=\"main_body\" >\n");
      out.write("\n");
      out.write("        <img id=\"top\" src=\"top.png\" alt=\"\">\n");
      out.write("            \n");
      out.write("        <div id=\"form_container\">\n");
      out.write("            <br>\n");
      out.write("\n");
      out.write("            <h2><font size=\"5\"><i><center>AdBot</center></i></font></h2>\n");
      out.write("            <br>\n");
      out.write("            <h3><font size=\"5\"><center>TESTE DE <i>LOG IN</i> SOMENTE PARA <i>ADVERTISER</i> <br> Usar o Usuario_ID = 6 para testes</center></font></h3>\n");
      out.write("            <br><br>\n");

            if ( request.getParameter("Campo_controle") != null ) { 
                
                // PRECISA do procedimento abaixo após obter o Usuario_ID (as outras páginas vão utilizar esse número):
                String Usuario_ID = request.getParameter("Usuario_ID");
                session.setAttribute("Usuario_ID", Usuario_ID);     
                // Aqui precisa verificar o tipo de usuário
                pageContext.forward("Listagem_campaigns.jsp");
                
            }

      out.write("\n");
      out.write("\n");
      out.write("            <center>\n");
      out.write("                <form method=\"post\" action=Listagem_campaigns.jsp>\n");
      out.write("                    Usuario_ID <input type=\"text\" name=\"Usuario_ID\" /> <!-- No lugar disto, teria que estar UserName e Senha -->\n");
      out.write("                    <input id=\"Botao_Log_in\" type=\"submit\" name=\"Botao_Log_in\" value=\"Log in\" />\n");
      out.write("                    <input type=\"hidden\" name=\"Campo_controle\" />\n");
      out.write("                </form>\n");
      out.write("            </center>\n");
      out.write("            <br><br>\n");
      out.write("\n");
      out.write("            <img id=\"bottom\" src=\"bottom.png\" alt=\"\">\n");
      out.write("\n");
      out.write("            <div id=\"footer\">\n");
      out.write("                <font size=\"4\"><i>AdBot</i> - PMR2490 (turma 4-B)</a></font>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </div>    \n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
