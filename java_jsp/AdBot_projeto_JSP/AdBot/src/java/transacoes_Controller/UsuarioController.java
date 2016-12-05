/*
 * UsuarioController: Classe que controla as transações relacionadas a Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *                              - getNomeUsuario
 *           [23/11/2016] Diego - visualizarPerfilAdvertiserPublisher
 *                              - getUsuarioBloqueioDTO
 *           [28/11/2016] Nelson - PerfilAdvertiserPublisher
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

    // editarPerfilAdvertiserPublisher [Nelson: 28/11/2016]
    public int editarPerfilAdvertiserPublisher(int usuario_ID, CriacaoUpdateAdvertiserPublisherDTO updateUsuarioDTO) {

        Transacao tr = new Transacao();
        try {
            System.out.println("UsuarioControler: profEdit: begin.");
            tr.begin();
            UsuarioData userData = new UsuarioData();
            // Completa info recebidas com info do database
            VisualizacaoAdvertiserPublisherDTO userProfDTO = userData.visualizarPerfilAdvertiserPublisher(usuario_ID, tr);
            String userName = updateUsuarioDTO.getUserName(); // mantem codigo limpo [Nelson:05/12/2016]
            String nome = updateUsuarioDTO.getNome();
            String sobrenome = updateUsuarioDTO.getSobrenome();
            String e_mail = updateUsuarioDTO.getE_mail();
            String conta_de_banco = updateUsuarioDTO.getConta_de_banco();
            String senha = updateUsuarioDTO.getSenha();
            String tipo_usuario = updateUsuarioDTO.getTipo_Usuario();
            if (userName==null ||userName.length()<2)              updateUsuarioDTO.setUserName        (userProfDTO.getUserName()      );
            if (nome==null || nome.length()<2)                     updateUsuarioDTO.setNome            (userProfDTO.getNome()          );
            if (sobrenome==null || sobrenome.length()<2)           updateUsuarioDTO.setSobrenome       (userProfDTO.getSobrenome()     );
            if (e_mail==null || e_mail.length()<2)                 updateUsuarioDTO.setE_mail          (userProfDTO.getE_mail()        );
            if (conta_de_banco==null || conta_de_banco.length()<5) updateUsuarioDTO.setConta_de_banco  (userProfDTO.getConta_de_banco());
            if (senha==null || senha.length()<2)                   updateUsuarioDTO.setSenha           (userProfDTO.getSenha()         );
            if (!"Advertiser".equals(tipo_usuario)){
                if (!"Publisher".equals(tipo_usuario)){
                    if (!"Administrador".equals(tipo_usuario)){
                        if (tipo_usuario == null || !"".equals(tipo_usuario) ) {
                            updateUsuarioDTO.setTipo_Usuario( userProfDTO.getTipo_Usuario() );
                        } // if: tipo_usuario == null
                    } // if: tipo_usuario != Administrador
                } // if: tipo_usuario != Publisher
            } // if: tipo_usuario != Advertiser
            int bloqueio_ok = userData.editarPerfilAdvertiserPublisher(usuario_ID, updateUsuarioDTO, tr);
            tr.commit();
            System.out.println("UsuarioControler: profEdit: Success.");
            return bloqueio_ok;
        } catch(Exception e) {
            System.out.println("UsuarioControler: profEdit: Failed. Exception.");
            e.printStackTrace();
            return 0;
        } // fim: try-catch

    } // fim: editarPerfilAdvertiserPublisher

} // fim: UsuarioController
