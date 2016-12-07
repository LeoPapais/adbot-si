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
            String userName = updateUsuarioDTO.getUserName(); // mantem codigo limpo [Nelson:05/12/2016]
            String nome = updateUsuarioDTO.getNome();
            String sobrenome = updateUsuarioDTO.getSobrenome();
            String e_mail = updateUsuarioDTO.getE_mail();
            String conta_de_banco = updateUsuarioDTO.getConta_de_banco();
            String senha = updateUsuarioDTO.getSenha();
            String tipo_usuario = updateUsuarioDTO.getTipo_Usuario();
            
            // A) USERNAME
            if (userName==null){
                updateUsuarioDTO.setUserName (userProfDTO.getUserName() );
            } else{
                if(userName.length()<2) updateUsuarioDTO.setUserName (userProfDTO.getUserName());
            } // fim: processamento username

            // B) NOME
            if (nome==null) {       
                updateUsuarioDTO.setNome(userProfDTO.getNome());
            } else{
                if(nome.length()<2) updateUsuarioDTO.setNome(userProfDTO.getNome());;
            } // fim: procesamento nome
            
            // C) SOBRENOME
            if (sobrenome==null){
                updateUsuarioDTO.setSobrenome(userProfDTO.getSobrenome());
            } else{
                if(sobrenome.length()<2)updateUsuarioDTO.setSobrenome(userProfDTO.getSobrenome());
            } // fim: processamento sobrenome
            
            // D) E_MAIL
            if (e_mail==null){
               updateUsuarioDTO.setE_mail(userProfDTO.getE_mail());
            } else{
               if(e_mail.length()<2) updateUsuarioDTO.setE_mail(userProfDTO.getE_mail());
            } // fim: processamento e_mail
            
            // E) CONTA_DE_BANCO
            if (conta_de_banco==null) { 
               updateUsuarioDTO.setConta_de_banco  (userProfDTO.getConta_de_banco());
            } else{
               if(conta_de_banco.length()<5) updateUsuarioDTO.setConta_de_banco  (userProfDTO.getConta_de_banco());
            } // fim: processamento conta_de_banco

            // F) SENHA
            if (senha==null){ 
               updateUsuarioDTO.setSenha(userProfDTO.getSenha());
            } else{
               if(senha.length()<2) updateUsuarioDTO.setSenha(userProfDTO.getSenha());
            } // fim: processamento senha
            
            // G) TIPO_USUARIO
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
    
    // Obtém as movimentações feitas pelo usuário identificado por usuario_id
    // Retorna uma lista com todas as movimentações
    public List<MovimentacaoDTO> getMovimentacao(int usuario_id) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
            UsuarioData udata = new UsuarioData();
            List<MovimentacaoDTO> movimentacoes = udata.getMovimentacoes(usuario_id, tr);
            tr.commit();
            System.out.println("OK ");   
            return movimentacoes;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar perfil do Usuário " + usuario_id);
            e.printStackTrace();
        }
        return null;
    
    } //getMovimentacao
    
    // Obtém o balance do usuário
    public double getBalance(int usuario_id) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
            UsuarioData udata = new UsuarioData();
            double balance = udata.getBalance(usuario_id, tr);
            tr.commit();
            System.out.println("OK ");   
            return balance;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar perfil do Usuário " + usuario_id);
            e.printStackTrace();
        }
        return 0;
    
    } //getBalance
    
    // Obtém o balance do usuário
    public int verificaSenha(String usuario, String senha) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
            UsuarioData udata = new UsuarioData();
            int id = udata.verificaSenha(usuario, senha, tr);
            tr.commit();
            System.out.println("OK ");   
            return id;
        } catch(Exception e) {
            System.out.println("Erro ao acessar senha do usuário " + usuario);
            e.printStackTrace();
        }
        return -1;
    
    } //getBalance

    public boolean cadastroUsuario(CriacaoUpdateAdvertiserPublisherDTO u2) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              UsuarioData udata = new UsuarioData();
              boolean conf = udata.cadastroUsuario( u2, tr);
            tr.commit();
            System.out.println("OK ");   
            return conf;
       
        } catch(Exception e) {
            System.out.println("Erro no cadastro!");
            e.printStackTrace();
        }
        return false;
    }
    
     public boolean setMovimentacao(int Usuario_ID, MovimentacaoDTO m) throws Exception{
        Transacao tr = new Transacao();
        try{
            tr.begin();
            UsuarioData udata = new UsuarioData();
            boolean b = udata.setMovimentacao(Usuario_ID, m, tr);            
            tr.commit();
            System.out.println("OK ");   
            return b;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
    
} // fim: UsuarioController
