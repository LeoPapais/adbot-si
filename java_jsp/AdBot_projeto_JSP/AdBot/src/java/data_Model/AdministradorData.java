/*
 * AdministradorData: Classe que acessa o banco de dados para Administradores
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial do arquivo CampaignData
 *           [18/11/2016] Nelson - Adaptação para AdministradorData
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
        String query = "select U.ID, Nome, U.Sobrenome, U.E_mail, U.Data_de_cadastro, U.Bloqueio, "
                + "U.Tipo_Usuario, U.Conta_de_banco, U.Credito_disponivel "
                + "from Usuario U where U.Tipo_Usuario = 'Advertiser' ";
        PreparedStatement statement = con.prepareStatement(query);
        ResultSet result = statement.executeQuery();
        System.out.println("AdminData: L.ADV: Query received.");
        
        Vector lista = new Vector();
        while (result.next()) {
            ListagemAdvertisersDTO l = new ListagemAdvertisersDTO();
            l.setID                 (result.getInt    ("U.ID"));
            l.setNome               (result.getString ("U.Nome"));
            l.setSobrenome          (result.getString ("U.Sobrenome"));
            l.setE_mail             (result.getString ("U.E_mail"));
            l.setData_de_cadastro   (result.getString ("U.Data_de_cadastro"));
            l.setBloqueio           (result.getInt    ("U.Bloqueio"));
            l.setTipo_Usuario       (result.getString ("U.Tipo_Usuario"));
            l.setConta_de_banco     (result.getString ("U.Conta_de_banco"));
            l.setCredito_disponivel (result.getFloat  ("U.Credito_disponivel"));
            lista.add(l); // adiciona na lista
        } // fim: while para contruir lista
        System.out.println("AdminData: L.ADV: All Done. Returning List...");
        return lista;
    } // fim: getListagemAdvertisers

    // 2) Pegar Listagem Publishers para Listagem_Publishers.jsp [Nelson]
    public Vector getListagemPublishers(Transacao tr) throws Exception {
        System.out.println("AdminData: L.PBSH: Begin.");
        Connection con = tr.obterConexao();
        String query = "select U.ID, Nome, U.Sobrenome, U.E_mail, U.Data_de_cadastro, U.Bloqueio, "
                + "U.Tipo_Usuario, U.Conta_de_banco "
                + "from Usuario U where U.Tipo_Usuario = 'Publisher' ";
        PreparedStatement statement = con.prepareStatement(query);
        ResultSet result = statement.executeQuery();
        System.out.println("AdminData: L.PBSH: Query received.");
        
        Vector lista = new Vector();
        while (result.next()) {
            ListagemPublishersDTO l = new ListagemPublishersDTO();
            l.setID                 (result.getInt    ("U.ID"));
            l.setNome               (result.getString ("U.Nome"));
            l.setSobrenome          (result.getString ("U.Sobrenome"));
            l.setE_mail             (result.getString ("U.E_mail"));
            l.setData_de_cadastro   (result.getString ("U.Data_de_cadastro"));
            l.setBloqueio           (result.getInt    ("U.Bloqueio"));
            l.setTipo_Usuario       (result.getString ("U.Tipo_Usuario"));
            l.setConta_de_banco     (result.getString ("U.Conta_de_banco"));
            lista.add(l); // adiciona na lista
        } // fim: while para contruir lista
        System.out.println("AdminData: L.PBSH: All Done. Returning List...");
        return lista;
    } // fim: getListagemPublishers

    // 3) Bloquear Advertiser publisher [Nelson]
    public int bloquearAdvertiserPublisher(int usuario_ID, BloqueioAdvertiserPublisherDTO blockDTO, Transacao tr) throws Exception {
        System.out.println("AdminData: Blk.UB: Begin.");
        Connection con = tr.obterConexao();
        String query_update = "update Usuario set Bloqueio = ? where ID = ?";
        String query_block = "select Bloqueio from Usuario where ID = ?";
        PreparedStatement st_update = con.prepareStatement(query_update);
        PreparedStatement st_block = con.prepareStatement(query_block);
        if ( blockDTO.getBloqueio()==1 )
            st_update.setBoolean(1, true);
        else
            st_update.setBoolean(1, false);
        st_update.setInt(2, usuario_ID);
        st_block.setInt(1, usuario_ID);
        try {
            ResultSet block_result = st_block.executeQuery();
            System.out.println("AdminData: Blk.UB: Database is being blocked.");
            int update_result = st_update.executeUpdate();
            System.out.println("AdminData: Blk.UB: Database updated. Number of modifications = " + update_result);
            return update_result;
        }
        catch (Exception e){
            System.out.println("AdminData: Blk.UB: Failed Exception. No modifications on Database.");
            e.printStackTrace();
            return 0;
        }

    } // fim: getListagemPublishers

} // fim: AdministradorData
