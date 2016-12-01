/*
 * CampaignController: Classe que controla as transações relacionadas a Campaigns
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
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

public class CampaignController {

    public CampaignController() {
    }

    // Adquirir dados necessários à página Listagem_campaigns.jsp e Sumario_geral_das_metricas_de_performance_de_campaigns.jsp [Diego: 02/11/2016]
    public Vector getListagemCampaigns(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              CampaignData cdata = new CampaignData();
              Vector v = cdata.getListagemCampaigns(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return v;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar Advertiser - Usuario_ID = " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getListagemCampaigns
   
    
    // Adquirir dados necessários à página Quebra_de_gastos.jsp [Diego: 02/11/2016]
    public Vector getQuebraCampaignMediaDTO(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              CampaignData cdata = new CampaignData();
              Vector v = cdata.getQuebraCampaignMedia(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return v;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar pelo balanço das Campaigns de Advertiser (Usuario_ID = " + Usuario_ID + ") para cada Media");
            e.printStackTrace();
        }
        return null;
    } //getQuebraCampaignMediaDTO
   
}
