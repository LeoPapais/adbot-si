/*
 * UsuarioData: Classe que acessa o banco de dados para Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *                              - getNomeUsuario
 *           [23/11/2016] Diego - visualizarPerfilAdvertiserPublisher
 *                              - getUsuarioBloqueioDTO
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
}
