/*
 * CampaignData: Classe que acessa o banco de dados para Campaigns
 *
 * Histórico de edição deste arquivo :
 *           [23/11/2016] Diego - getCredito_disponivel
 *
 *
 */

package data_Model;

import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class AdvertiserData {
    
    // Adquirir Crédito disponível de Advertiser [Diego: 23/11/2016]
    public AdvertiserCredito_disponivelDTO getCredito_disponivel(int Usuario_ID, Transacao tr) throws Exception {
        
        Connection con = tr.obterConexao();

        String sql = "select Credito_disponivel from Usuario where ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Usuario_ID);
        ResultSet rs = ps.executeQuery();
        System.out.println("Query executada");
        
        rs.next(); // Antes de começar a ler os resultados, precisa desta linha
        
        AdvertiserCredito_disponivelDTO a = new AdvertiserCredito_disponivelDTO();
        a.setCredito_disponivel(rs.getFloat("Credito_disponivel"));

        return a;
    } //getCredito_disponivel
    
    //setar crédito disponível do advertiser
    public boolean setCredito_disponivel(int Usuario_ID, AdvertiserCredito_disponivelDTO c, Transacao tr) throws Exception{
        
        try{
            Connection con = tr.obterConexao();

            String sql = "update Usuario set Credito_disponivel= Credito_disponivel + ? where ID=?";
                    
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setFloat(1, c.getCredito_disponivel());
            ps.setInt(2, Usuario_ID);
            ps.executeUpdate();
            ps.close();
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }//setCredito_disponivel
    
}
