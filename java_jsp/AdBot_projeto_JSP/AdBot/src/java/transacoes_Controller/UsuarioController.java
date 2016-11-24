/*
 * UsuarioController: Classe que controla as transações relacionadas a Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *                              - getNomeUsuario
 *           [23/11/2016] Diego - visualizarPerfilAdvertiserPublisher
 *                              - getUsuarioBloqueioDTO
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

public class UsuarioController {

    public UsuarioController() {
    }
    
    // Adquirir nome do usuário
    public UsuarioNomeDTO getNomeUsuario(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              UsuarioData udata = new UsuarioData();
              UsuarioNomeDTO u = udata.getNomeUsuario(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return u;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar Nome + Sobrenome do Usuário " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getListagemCampaigns
    
    // Adquirir valor que mostra se o usuário está bloqueado ou não
    public UsuarioBloqueioDTO getBloqueioUsuario(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              UsuarioData udata = new UsuarioData();
              UsuarioBloqueioDTO u = udata.getBloqueioUsuario(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return u;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar bloqueio do Usuário " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getBloqueioUsuario
    
    // Adquirir dados de perfil do usuário necessários à página Perfil_de_advertiser.jsp [Diego]
    public VisualizacaoAdvertiserPublisherDTO visualizarPerfilAdvertiserPublisher(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              UsuarioData udata = new UsuarioData();
              VisualizacaoAdvertiserPublisherDTO u = udata.visualizarPerfilAdvertiserPublisher(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return u;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar perfil do Usuário " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    
    } //visualizarPerfilAdvertiserPublisher

}
