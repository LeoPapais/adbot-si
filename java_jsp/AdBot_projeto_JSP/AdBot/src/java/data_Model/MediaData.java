/*
 * MediasData: Classe que acessa o banco de dados para Medias
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *           [22/11/2016] Diego - Queries ajustadas para o script MySQL que foi
 *                                alterado segundo o professor Barretto
 *
 *
 */

package data_Model;

import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class MediaData {
    
    // Adquirir dados necessários à página Listagem_Medias.jsp [Gabriel: 06/12/2016]
    public Vector getListagemMedias(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select Nome, ID, Estado, TestMode, Tipo_produto, "
                + "Endereco_REST_API_chatbot, Total_visualizacoes, "
                + "CPC_minimo from Media C where C.Usuario_ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        Vector lista = new Vector();
        while (rs.next()) {
            ListagemMediasDTO l = new ListagemMediasDTO();
            l.setNome(rs.getString("Nome"));
            l.setID(rs.getInt("ID"));       
            l.setTipo_produto(rs.getString("Tipo_produto")); 
            l.setEstado(rs.getInt("Estado"));
            l.setTestMode(rs.getInt("TestMode"));
            l.setEndereco_REST_API_chatbot(rs.getString("Endereco_REST_API_chatbot"));
            l.setTotal_visualizacoes(rs.getInt("Total_visualizacoes"));         
            l.setCPC_minimo(rs.getFloat("CPC_minimo"));  
            lista.add(l);
        }
        return lista;
    } //getListagemMedias
    
    public boolean criarMedia(int Usuario_ID, CriacaoUpdateMediaDTO M, Transacao tr) throws Exception{
        Connection con = tr.obterConexao();
        String sql= "insert into Media (Usuario_ID, Nome, Tipo_produto, Endereco_REST_API_chatbot, CPC_minimo) values (?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1,Usuario_ID);
        ps.setString(2, M.getNome());
        ps.setString(3, M.getTipo_produto());
        ps.setString(4, M.getEndereco_REST_API_chatbot());
        ps.setFloat(5, M.getCPC_minimo());
        
        int result = ps.executeUpdate();
        System.out.println("update executado");

        return (result != 0);
    }
    
    public boolean editarMedia(int Media_ID, CriacaoUpdateMediaDTO C, Transacao tr) throws Exception{
        Connection con = tr.obterConexao();
        String sql= "update Media set Nome=?, Tipo_produto=?, Endereco_REST_API_chatbot=?, CPC_minimo=? where ID=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, C.getNome());
        ps.setString(2, C.getTipo_produto());
        ps.setString(3, C.getEndereco_REST_API_chatbot());
        ps.setFloat(4, C.getCPC_minimo());
        ps.setInt(5, Media_ID);
        int result = ps.executeUpdate();
        System.out.println("edicao realizada");
        return (result != 0);
    }
    
    public boolean removerMedia (int Media_ID, Transacao tr) throws Exception {
        Connection con = tr.obterConexao();
        String sql= "Delete from Media where ID=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Media_ID);
        int result = ps.executeUpdate();
        System.out.println("remocao realizada");
        return (result !=0);
    }
        // Ativar o Test Mode de uma Media [Douglas]
    public int mudarTestMode ( int media_ID ,TestModeDTO testDTO, Transacao tr ) throws Exception {
        System.out.println("MediaData: TM.MD: Begin.");
        Connection con = tr.obterConexao();
        String sql;
        sql = "update Media set TestMode = ? where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        if ( testDTO.getMode()==1 )
            ps.setBoolean(1, true);
        else
            ps.setBoolean(1, false);
        ps.setInt(2, media_ID);
        try {
            int rs = ps.executeUpdate();
            System.out.println("MediaData: TD.MD: Database updated. Number of modifications = " + rs);
            return rs;
        }
        catch (Exception e){
            System.out.println("MediaData: TD.MD: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        }
    }//fim: mudarTestMode
}
