/*
 * CampaignData: Classe que acessa o banco de dados para Campaigns
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

public class CampaignData {
    
    // Adquirir dados necessários à página Listagem_campaigns.jsp [Diego]
    public Vector getListagemCampaigns(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select Nome, ID, clickURL, Bid, Tipo_produto, Marca_produto, Total_visualizacoes, "
                     + "Total_clicks, Gasto_total, Limite_gasto, Estado, Autorizacao from Campaign C where C.Usuario_ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        Vector lista = new Vector();
        while (rs.next()) {
            ListagemCampaignsDTO l = new ListagemCampaignsDTO();
            l.setNome(rs.getString("Nome"));
            l.setID(rs.getInt("ID"));     
            l.setClickURL(rs.getString("clickURL"));           
            l.setBid(rs.getFloat("Bid"));
            l.setTipo_produto(rs.getString("Tipo_produto"));  
            l.setMarca_produto(rs.getString("Marca_produto"));  
            l.setTotal_visualizacoes(rs.getInt("Total_visualizacoes"));     
            l.setTotal_clicks(rs.getInt("Total_clicks"));     
            l.setGasto_total(rs.getFloat("Gasto_total"));     
            l.setLimite_gasto(rs.getFloat("Limite_gasto"));      
            l.setEstado(rs.getInt("Estado"));
            l.setAutorizacao(rs.getInt("Autorizacao"));
            lista.add(l);
        }
        return lista;
    } //getListagemCampaigns
    
    // Adquirir dados necessários à página Quebra_de_gastos.jsp [Diego]
    public Vector getQuebraCampaignMedia(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select C.ID, C.Nome, M.ID, M.Nome, CL.Gasto_click "
                + "from Usuario U, Campaign C, Media M, Click_log CL "
                + "where CL.Media_ID = M.ID "
                + "and CL.Campaign_ID = C.ID "
                + "and C.Usuario_ID = U.ID "
                + "and U.ID = ? "
                + "order by C.ID, M.ID";       
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        Vector lista = new Vector();
        while (rs.next()) {
            QuebraCampaignMediaDTO l = new QuebraCampaignMediaDTO();
            l.setCampaignID(rs.getInt("C.ID"));
            l.setCampaignNome(rs.getString("C.Nome"));     
            l.setMediaID(rs.getInt("M.ID"));           
            l.setMediaNome(rs.getString("M.Nome"));  
            l.setGasto(rs.getFloat("CL.Gasto_click"));
            lista.add(l);
        }
        return lista;
    } //getQuebraCampaignMediaDTO
    
}
