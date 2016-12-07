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
import static javax.faces.component.UIInput.isEmpty;
import utils.Transacao;

public class CampaignController {

    public CampaignController() {
    }
    
    public boolean criarCampaign(CreateCampaignDTO C) throws Exception {
        
     // validacao das regras de negocio
        System.out.println("C.getNome()");
        System.out.println(C.getNome());
     if ( (isEmpty(C.getNome())) ) {
       return false;
     }

     // efetuando a transacao
     Transacao tr = new Transacao();
     try {
        System.out.println("try");
       tr.begin();
         CampaignData cdata = new CampaignData();
         cdata.createCampaign(C, tr);
       tr.commit();
       return true;
     } catch(Exception e) {
        System.out.println("catch");
        System.out.println(e);
         tr.rollback();
         System.out.println("erro ao incluir ");
         e.printStackTrace();
     }
     return false;
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
