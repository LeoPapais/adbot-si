/*
 * UsuarioData: Classe que acessa o banco de dados para Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *                              - getNomeUsuario
 *           [23/11/2016] Diego - visualizarPerfilAdvertiserPublisher
 *                              - getUsuarioBloqueioDTO
 *           [28/11/2016] Nelson - inclusao de edicao de perfil de usuario
 *
 */

package data_Model;

import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class UsuarioData {
    
    // Adquirir nome do usuário
    public UsuarioNomeDTO getNomeUsuario(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select Nome, Sobrenome from Usuario where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        rs.next(); // Antes de começar a ler os resultados, precisa desta linha
        
        UsuarioNomeDTO u = new UsuarioNomeDTO();
        u.setNome(rs.getString("Nome"));
        u.setSobrenome(rs.getString("Sobrenome"));

        return u;
    } //getNomeUsuario

    // Adquirir valor que mostra se o usuário está bloqueado ou não
    public UsuarioBloqueioDTO getBloqueioUsuario(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select Bloqueio from Usuario where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        rs.next(); // Antes de começar a ler os resultados, precisa desta linha
        
        UsuarioBloqueioDTO u = new UsuarioBloqueioDTO();
        u.setBloqueio(rs.getInt("Bloqueio"));

        return u;
    } //getBloqueioUsuario
    
    // Adquirir dados de perfil do usuário necessários à página Perfil_de_advertiser.jsp [Diego]
    public VisualizacaoAdvertiserPublisherDTO visualizarPerfilAdvertiserPublisher(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select UserName, Nome, Sobrenome, E_mail, Conta_de_banco, Senha, Tipo_Usuario, Data_de_cadastro, Bloqueio from Usuario where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        rs.next(); // Antes de começar a ler os resultados, precisa desta linha
        
        VisualizacaoAdvertiserPublisherDTO u = new VisualizacaoAdvertiserPublisherDTO();
        u.setUserName(rs.getString("UserName"));
        u.setNome(rs.getString("Nome"));
        u.setSobrenome(rs.getString("Sobrenome"));
        u.setE_mail(rs.getString("E_mail"));
        u.setConta_de_banco(rs.getString("Conta_de_banco"));
        u.setTipo_Usuario(rs.getString("Tipo_Usuario"));
        
        // Armazenar a data de cadastro (dia e horário)
        Timestamp stamp;
        stamp = rs.getTimestamp("Data_de_cadastro");
        u.setData_de_cadastro(new java.sql.Date(stamp.getTime()));
        
        u.setBloqueio(rs.getInt("Bloqueio"));

        // O que é passado para visualização é a indicativa de quantidade de caracteres da senha 
        String st = rs.getString("Senha");
        String x = "*";
        for(int i = 1; i < st.length(); i++){
            x = x.concat("*");
        }
        u.setSenha(x);
        
        return u;
    } //visualizarPerfilAdvertiserPublisher

    // editarPerfilAdvertiserPublisher [Nelson: 28/11/2016]
    public int editarPerfilAdvertiserPublisher(int usuario_ID, CriacaoUpdateAdvertiserPublisherDTO updateUsuarioDTO, Transacao tr) throws Exception {
        System.out.println("UserData: profEdit: Begin.");
        int update_result = 0; // valor de atualizacoes no database
        Connection con = tr.obterConexao();
        
        // 1) Construcao das sentencas da query
        String query_block          = "select U.UserName, U.Nome, U.Sobrenome, U.E_mail, U.Conta_de_banco, U.Senha, U.Tipo_Usuario from Usuario U where ID = ?";
        String update_UserName      = "update Usuario set UserName = ?       where ID = ?";
        String update_Nome          = "update Usuario set Nome = ?           where ID = ?";
        String update_Sobrenome     = "update Usuario set Sobrenome = ?      where ID = ?";
        String update_E_mail        = "update Usuario set E_mail = ?         where ID = ?";
        String update_ContaBanco    = "update Usuario set Conta_de_banco = ? where ID = ?";
        String update_Senha         = "update Usuario set Senha = ?          where ID = ?";
        String update_TipoUsuario   = "update Usuario set Tipo_Usuario = ?   where ID = ?";

        // 2) Construcao dos preparedStatements
        PreparedStatement st_block              = con.prepareStatement(query_block          );
        PreparedStatement st_update_UserName    = con.prepareStatement(update_UserName      );
        PreparedStatement st_update_Nome        = con.prepareStatement(update_Nome          );
        PreparedStatement st_update_Sobrenome   = con.prepareStatement(update_Sobrenome     );
        PreparedStatement st_update_E_mail      = con.prepareStatement(update_E_mail        );
        PreparedStatement st_update_ContaBanco  = con.prepareStatement(update_ContaBanco    );
        PreparedStatement st_update_Senha       = con.prepareStatement(update_Senha         );
        PreparedStatement st_update_TipoUsuario = con.prepareStatement(update_TipoUsuario   );
        
        // 3) Introduzir dados do Usuario nos prepared Statements
        st_block.setInt(1, usuario_ID);
        st_update_UserName.setString    (1, updateUsuarioDTO.getUserName() );
        st_update_UserName.setInt       (2, usuario_ID );
        st_update_Nome.setString        (1, updateUsuarioDTO.getNome() );
        st_update_Nome.setInt           (2, usuario_ID );
        st_update_Sobrenome.setString   (1, updateUsuarioDTO.getSobrenome() );
        st_update_Sobrenome.setInt      (2, usuario_ID );
        st_update_E_mail.setString      (1, updateUsuarioDTO.getE_mail() );
        st_update_E_mail.setInt         (2, usuario_ID );
        st_update_ContaBanco.setString  (1, updateUsuarioDTO.getConta_de_banco() );
        st_update_ContaBanco.setInt     (2, usuario_ID );
        st_update_Senha.setString       (1, updateUsuarioDTO.getSenha() );
        st_update_Senha.setInt          (2, usuario_ID );
        st_update_TipoUsuario.setString (1, updateUsuarioDTO.getTipo_Usuario() );
        st_update_TipoUsuario.setInt    (2, usuario_ID );

        // 4) Execucao das querrys e updates
        try {
            System.out.println("UserData: profEdit: blocking database...");
            //ResultSet block_result = st_block.executeQuery();
            System.out.println("UserData: profEdit: changing UserName...");
            update_result += st_update_UserName.executeUpdate();
            System.out.println("UserData: profEdit: changing Nome...");
            update_result += st_update_Nome.executeUpdate();
            System.out.println("UserData: profEdit: changing Sobrenome...");
            update_result += st_update_Sobrenome.executeUpdate();
            System.out.println("UserData: profEdit: changing E_mail...");
            update_result += st_update_E_mail.executeUpdate();
            System.out.println("UserData: profEdit: changing Conta_de_Banco...");
            update_result += st_update_ContaBanco.executeUpdate();
            System.out.println("UserData: profEdit: changing Senha...");
            update_result += st_update_Senha.executeUpdate();
            System.out.println("UserData: profEdit: changing Tipo_Usuario...");
            update_result += st_update_TipoUsuario.executeUpdate();
            System.out.println("UserData: profEdit: Database updated. Number of modifications: " + update_result);
            return update_result;
        } catch (Exception e){
            System.out.println("UserData: profEdit: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        } // fim: try-catch

    } // fim: editarPerfilAdvertiserPublisher

} // fim: UsuarioData
