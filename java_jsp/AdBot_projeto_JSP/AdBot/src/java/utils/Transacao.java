/*
 * Transacao: Classe que faz transação de dados, que será fornecida para o projeto de SI.
 *            Faz parte da infraestrutura do MVC.
 *
 * Classe fornecida aos alunos no final da página: http://monoceros.mcca.ep.usp.br/CGL/disciplinas/sistemas-de-informacao/itens
 *
 * Histórico de edição deste arquivo :
 *           Baixado de http://monoceros.mcca.ep.usp.br/CGL/disciplinas/sistemas-de-informacao/itens
 *           [02/11/2016] Diego - Senha e usuários dfierentes
 *
 */

package utils;

import java.sql.*;

public class Transacao {
    
  // connection data
  private Connection _conexao = null;
  private boolean _readOnly = false;
  
  // Senha e usuário
        //Original:private String USER_PASSWORD = "user=aluno&password=pmr2490";
  private String USER_PASSWORD = "user=aluno&password=Pmr2490a.";
  
  // Nome do banco de dados
  private String DATABASE_NAME = "bd_adbot";
  
  public void begin() throws Exception{
      Class.forName("com.mysql.jdbc.Driver");
      _conexao = DriverManager.getConnection("jdbc:mysql://localhost/" + DATABASE_NAME + "?" + USER_PASSWORD);
      _conexao.setAutoCommit(false);
      _readOnly = false;
  } // begin
  
  public void beginReadOnly() throws Exception{
      Class.forName("com.mysql.jdbc.Driver");
      _conexao = DriverManager.getConnection("jdbc:mysql://localhost/" + DATABASE_NAME + "?" + USER_PASSWORD);
      _readOnly = true;
  } // begin
  
  public void commit() throws Exception {
      if ( !_readOnly) {
         _conexao.commit();
      }
      _conexao.close();
  } // commit
  
  public void rollback() throws Exception {
      if ( !_readOnly) {
         _conexao.rollback();
      }
      _conexao.close();
  } // rollback
  
  public Connection obterConexao() {
      return _conexao;
  } // obterConexao
  
} // Transacao