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
    
    // Adquirir Crédito disponível de Advertiser
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
    
}
