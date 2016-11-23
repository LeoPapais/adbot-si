/*
 * UsuarioController: Classe que controla as transações relacionadas a Usuário
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

public class UsuarioController {

    public UsuarioController() {
    }
    
    // Adquirir nome do usuário necessário à página Listagem_campaigns.jsp e Sumario_geral_das_metricas_de_performance_de_campaigns.jsp [Diego]
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
            System.out.println("Erro ao pesquisar Usuário " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getListagemCampaigns
    
}
