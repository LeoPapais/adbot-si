package utils;

import java.sql.*;

public class Transacao {

  // connection data
  static final String ODBC_DRIVER = "sun.jdbc.odbc.JdbcOdbcDriver";
  static final String DSN = "jdbc:odbc:pmr2490";
  static final String USER = "admin";
  static final String PWD = "";

  private Connection _conexao = null;
  private boolean _readOnly = false;

  public void begin() throws Exception{
      Class.forName(ODBC_DRIVER).newInstance();
      _conexao = DriverManager.getConnection(DSN,USER,PWD);
      _conexao.setAutoCommit(false);
	  _readOnly = false;
  } // begin

  public void beginReadOnly() throws Exception{
      Class.forName(ODBC_DRIVER).newInstance();
      _conexao = DriverManager.getConnection(DSN,USER,PWD);
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