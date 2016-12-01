/*
 * AdvertiserController: Classe que controla as transações relacionadas a um Advertiser
 *
 * Histórico de edição deste arquivo :
 *           [23/11/2016] Diego - Versão inicial - getCredito_disponivel
 *
 *
 */

package transacoes_Controller;

import data_Model.*;
import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class AdvertiserController {

    public AdvertiserController() {
    }
    
    // Adquirir Crédito disponível de Advertiser [Diego: 01/12/2016]
    public AdvertiserCredito_disponivelDTO getCredito_disponivel(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              AdvertiserData adata = new AdvertiserData();
              AdvertiserCredito_disponivelDTO v = adata.getCredito_disponivel(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return v;
        } catch(Exception e) {
            System.out.println("Erro ao verificar crédito disponível de Advertiser - Usuario_ID = " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getCredito_disponivel
   
}
