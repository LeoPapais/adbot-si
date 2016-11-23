/*
 * UsuarioData: Classe que acessa o banco de dados para Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *
 *
 */

package data_Model;

import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class UsuarioData {
    
    // Adquirir nome do usuário necessário à página Listagem_campaigns.jsp [Diego]
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
    
}
