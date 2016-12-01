/*
 * UsuarioController: Classe que controla as transações relacionadas a Usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *                              - getNomeUsuario
 *           [23/11/2016] Diego - visualizarPerfilAdvertiserPublisher
 *                              - getUsuarioBloqueioDTO
 *           [28/11/2016] Nelson - editarPerfilAdvertiserPublisher
 *           [01/12/2016] Diego - getTipoUsuario
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
    
    // Adquirir nome do usuário [Diego: 02/11/2016]
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
    } //getNomeUsuario
    
    // Adquirir tipo do usuário [Diego: 01/12/2016]
    public UsuarioTipoDTO getTipoUsuario(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              UsuarioData udata = new UsuarioData();
              UsuarioTipoDTO u = udata.getTipoUsuario(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK ");   
            return u;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar Tipo do Usuário " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getTipoUsuario    
    
    
    // Adquirir valor que mostra se o usuário está bloqueado ou não [Diego: 23/11/2016]
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
    
    // Adquirir dados de perfil do usuário necessários à página Perfil_de_advertiser.jsp [Diego:  23/11/2016]
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
            if (updateUsuarioDTO.getUserName() == null)       updateUsuarioDTO.setUserName        (userProfDTO.getUserName()      );
            if (updateUsuarioDTO.getNome() == null)           updateUsuarioDTO.setNome            (userProfDTO.getNome()          );
            if (updateUsuarioDTO.getSobrenome() == null)      updateUsuarioDTO.setSobrenome       (userProfDTO.getSobrenome()     );
            if (updateUsuarioDTO.getE_mail() == null)         updateUsuarioDTO.setE_mail          (userProfDTO.getE_mail()        );
            if (updateUsuarioDTO.getConta_de_banco() == null) updateUsuarioDTO.setConta_de_banco  (userProfDTO.getConta_de_banco());
            if (updateUsuarioDTO.getSenha() == null)          updateUsuarioDTO.setSenha           (userProfDTO.getSenha()         );
            if (!"Advertiser".equals(updateUsuarioDTO.getTipo_Usuario())){
                if (!"Publisher".equals(updateUsuarioDTO.getTipo_Usuario())){
                    if (!"Administrador".equals(updateUsuarioDTO.getTipo_Usuario())){
                        if (updateUsuarioDTO.getTipo_Usuario() == null) {
                            updateUsuarioDTO.setTipo_Usuario    (userProfDTO.getTipo_Usuario()  );
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
