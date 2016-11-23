/*
 * AdministradorController: Classe que controla as transações para administradores
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *           [19/11/2016] Nelson - Adaptação para AdministradorController
 *
 */

package transacoes_Controller;

import data_Model.*;
import DTO_Objects.*;
import java.sql.*;
import utils.*;
import java.util.*;
import utils.Transacao;

public class AdministradorController {

    public AdministradorController() {
    } // fim: construtor

    // Adquirir dados necessários à página Listagem_Advertisers.jsp [Nelson]
    public Vector getListagemAdvertisers() throws Exception {

        Transacao tr = new Transacao();
        try {
            System.out.println("AdministradorControler: L.ADV: begin.");
            tr.beginReadOnly();
            AdministradorData adminData = new AdministradorData();
            Vector v = adminData.getListagemAdvertisers(tr);
            tr.commit();
            System.out.println("AdministradorControler: L.ADV: Success.");
            return v;
        } catch(Exception e) {
            System.out.println("AdministradorControler: L.ADV: Failed. Exception.");
            e.printStackTrace();
            return null;
        }
        
    } // fim: getListagemAdvetisers

    // Adquirir dados necessários à página Listagem_Advertisers.jsp [Nelson]
    public Vector getListagemPublishers() throws Exception {

        Transacao tr = new Transacao();
        try {
            System.out.println("AdministradorControler: L.PBSH: begin.");
            tr.beginReadOnly();
            AdministradorData adminData = new AdministradorData();
            Vector v = adminData.getListagemPublishers(tr);
            tr.commit();
            System.out.println("AdministradorControler: L.PBSH: Success.");
            return v;
        } catch(Exception e) {
            System.out.println("AdministradorControler: L.PBSH: Failed. Exception.");
            e.printStackTrace();
            return null;
        }
    } // fim: getListagemPublishers

    // Bloquear Advertiser Publisher
    public int bloquearAdvertiserPublisher(int usuario_ID, BloqueioAdvertiserPublisherDTO blockDTO) {

        Transacao tr = new Transacao();
        try {
            System.out.println("AdministradorControler: Blk.UB: begin.");
            tr.begin();
            AdministradorData adminData = new AdministradorData();
            int bloqueio_ok = adminData.bloquearAdvertiserPublisher(usuario_ID, blockDTO, tr);
            tr.commit();
            System.out.println("AdministradorControler: Blk.UB: Success.");
            return bloqueio_ok;
        } catch(Exception e) {
            System.out.println("AdministradorControler: Blk.UB: Failed. Exception.");
            e.printStackTrace();
            return 0;
        }

    } // fim: BloqueioAdvertiserPublisher

} // fim: AdministradorController