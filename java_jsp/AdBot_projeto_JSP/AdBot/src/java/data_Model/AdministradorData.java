/*
 * AdministradorData: Classe que acessa o banco de dados para Administradores
 *
 * HistÃ³rico de ediÃ§Ã£o deste arquivo :
 *           [02/11/2016] Diego - VersÃ£o inicial do arquivo CampaignData
 *           [18/11/2016] Nelson - AdaptaÃ§Ã£o para AdministradorData
 *           [23/11/2016] Douglas - Atualizaçao com AM04 e AM08 [Douglas]
 * 
 */

package data_Model;

import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class AdministradorData {
    
    // 1) Pegar Listagem Advertisers para Listagem_Advsertisers.jsp [Nelson]
    public Vector getListagemAdvertisers(Transacao tr) throws Exception {
        System.out.println("AdminData: L.ADV: Begin.");
        Connection con = tr.obterConexao();
        String sql = "select U.ID, Nome, U.Sobrenome, U.E_mail, U.Data_de_cadastro, U.Bloqueio," +                
                "U.Tipo_Usuario, U.Conta_de_banco, U.Credito_disponivel " +
                "from Usuario U where U.Tipo_Usuario = 'Advertiser' ";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        System.out.println("AdminData: L.ADV: Query received.");
        
        Vector lista = new Vector();
        while (rs.next()) {
            ListagemAdvertisersDTO l = new ListagemAdvertisersDTO();
            l.setID                 (rs.getInt("U.ID"));
            l.setNome               (rs.getString("U.Nome"));
            l.setSobrenome          (rs.getString ("U.Sobrenome"));
            l.setE_mail             (rs.getString("U.E_mail"));
            l.setData_de_cadastro   (rs.getString("U.Data_de_cadastro"));
            l.setBloqueio           (rs.getInt("U.Bloqueio"));
            l.setTipo_Usuario       (rs.getString("U.Tipo_Usuario"));
            l.setConta_de_banco     (rs.getString("U.Conta_de_banco"));
            l.setCredito_disponivel (rs.getFloat("U.Credito_disponivel"));
            lista.add(l); // adiciona na lista
        } // fim: while para contruir lista
        System.out.println("AdminData: L.ADV: All Done. Returning List...");
        return lista;
    } // fim: getListagemAdvertisers

    // 2) Pegar Listagem Publishers para Listagem_Publishers.jsp [Nelson]
    public Vector getListagemPublishers(Transacao tr) throws Exception {
        System.out.println("AdminData: L.PBSH: Begin.");
        Connection con = tr.obterConexao();
        String sql = "select U.ID, Nome, U.Sobrenome, U.E_mail, U.Data_de_cadastro, U.Bloqueio, "
                + "U.Tipo_Usuario, U.Conta_de_banco "
                + "from Usuario U where U.Tipo_Usuario = 'Publisher' ";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        System.out.println("AdminData: L.PBSH: Query received.");
        
        Vector lista = new Vector();
        while (rs.next()) {
            ListagemPublishersDTO l = new ListagemPublishersDTO();
            l.setID                 (rs.getInt("U.ID"));
            l.setNome               (rs.getString("U.Nome"));
            l.setSobrenome          (rs.getString ("U.Sobrenome"));
            l.setE_mail             (rs.getString("U.E_mail"));
            l.setData_de_cadastro   (rs.getString("U.Data_de_cadastro"));
            l.setBloqueio           (rs.getInt("U.Bloqueio"));
            l.setTipo_Usuario       (rs.getString("U.Tipo_Usuario"));
            l.setConta_de_banco     (rs.getString("U.Conta_de_banco"));
            lista.add(l); // adiciona na lista
        } // fim: while para contruir lista
        System.out.println("AdminData: L.PBSH: All Done. Returning List...");
        return lista;
    } // fim: getListagemPublishers

    // 3) Bloquear Advertiser publisher [Nelson]
    public int bloquearAdvertiserPublisher(int usuario_ID, BloqueioAdvertiserPublisherDTO blockDTO, Transacao tr) throws Exception {
        System.out.println("AdminData: Blk.UB: Begin.");
        Connection con = tr.obterConexao();
        String sql;
        sql = "update Usuario set Bloqueio = ? where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        if ( blockDTO.getBloqueio()==1 )
            ps.setBoolean(1, true);
        else
            ps.setBoolean(1, false);
        ps.setInt(2, usuario_ID);
        try {
            int rs = ps.executeUpdate();
            System.out.println("AdminData: Blk.UB: Database updated. Number of modifications = " + rs);
            return rs;
        }
        catch (Exception e){
            System.out.println("AdminData: Blk.UB: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        }

    } // fim: getListagemPublishers
    
    // 4) Bloquear Campaign [Douglas]
    public int bloquearCampaign (int campaign_ID, BloqueioCampaignDTO blockDTO, Transacao tr) throws Exception{
        System.out.println("AdminData: Blk.Camp: Begin.");
        Connection con = tr.obterConexao();
        String sql;
        sql = "update Campaign set Autorizacao = ? where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        if (blockDTO.getBloqueio()==1)
            ps.setBoolean(1,true);
        else
            ps.setBoolean(1, false);
        ps.setInt(2,campaign_ID);
        try{
            int rs = ps.executeUpdate();
            System.out.println("AdminData: Blk.Camp: Database Updated. Number of modifications = "+rs);
            return rs;
        }
        catch(Exception e){
            System.out.println("AdminData: Blk.Camp: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        }
    } // fim : bloquearCampaign
    
    // 5) Remover Advertiser Publisher [Douglas]
    public int removerAdvertiserPublisher(int usuario_ID, Transacao tr) throws Exception{
        System.out.println("AdminData: Rem.UB: Begin.");
        Connection con = tr.obterConexao();
        String sql;
        sql = "Delete From Usuario"+
                " Where ID = ? ";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1,usuario_ID);
        try{
            ps.executeUpdate();
            System.out.println("AdminData: Rem.UB: Database Updated. Number of modifications = 1");
            return 1;
        }
        catch(Exception e){
            System.out.println("AdminData: Rem.UB: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        }
    }// fim: removerAdvertiserPublisher
} // fim: AdministradorData
