/*
 * MediaController: Classe que controla as transações relacionadas a Medias
 *
 * Histórico de edição deste arquivo :
 *           [06/12/2016] Gabriel - Versão inicial
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

public class MediaController {

    public MediaController() {
    }

    // Adquirir dados necessários à página Listagem_medias.jsp e Sumario_geral_das_metricas_de_performance_de_medias.jsp [Gabriel: 06/12/2016]
    public Vector getListagemMedias(int Usuario_ID) throws Exception {

        Transacao tr = new Transacao();
        try {
            tr.beginReadOnly();
              MediaData mdata = new MediaData();
              Vector v = mdata.getListagemMedias(Usuario_ID, tr);
            tr.commit();
            System.out.println("OK!");   
            return v;
        } catch(Exception e) {
            System.out.println("Erro ao pesquisar Publisher - Usuario_ID = " + Usuario_ID);
            e.printStackTrace();
        }
        return null;
    } //getListagemCampaigns
    public boolean criarMedia(int Usuario_ID, CriacaoUpdateMediaDTO M) throws Exception {
        System.out.println("entrou no media controler");
        if ((isEmpty(String.valueOf(M.getCPC_minimo()))) || (isEmpty(M.getNome())) || (isEmpty(M.getTipo_produto())) || (isEmpty(M.getEndereco_REST_API_chatbot()))) {
            return false;
        }
        System.out.println("not empty");
    Transacao tr = new Transacao();

    
        try{
    tr.begin();
        MediaData mdata = new MediaData();
        mdata.criarMedia(Usuario_ID, M, tr);
        tr.commit();
        return true;
    }
    catch (Exception e){
    tr.rollback();
        System.out.println("erro");
        e.printStackTrace();
    }
        return false;
    }
    
    public boolean editarMedia(int Media_ID, CriacaoUpdateMediaDTO C) throws Exception{
        System.out.println("entrou no media controler");
        Transacao tr = new Transacao();
	 try{
	   // inserir validacoes de regras de negocio
	   tr.begin();
  	     MediaData cdata = new MediaData();
	     cdata.editarMedia(Media_ID, C, tr);
	   tr.commit();
	   return true;
	 } catch (Exception e) {
	   tr.rollback();
	   System.out.println("erro");
	   e.printStackTrace();
	 }
	 return false;
  }
    
  public boolean removerMedia(int Media_ID) throws Exception {
      System.out.println("entrou no media controler");
      Transacao tr = new Transacao();
      try{
          tr.begin();
          MediaData MData = new MediaData();
          MData.removerMedia(Media_ID, tr);
          tr.commit();
          return true;
      } catch (Exception e){
          tr.rollback();
          System.out.println("erro");
          e.printStackTrace();
      }
      return false;
  }
    
    
    
    
  private boolean isEmpty(String s) {
     if (null == s)
       return true;
     if (s.length() == 0)
       return true;
     return false;
  }
    
  public int mudarTestMode(int media_ID, TestModeDTO testDTO) {

        Transacao tr = new Transacao();
        try {
            System.out.println("MediaControler: TM.MD: begin.");
            tr.begin();
            MediaData mediaData = new MediaData();
            int test_ok = mediaData.mudarTestMode(media_ID, testDTO, tr);
            tr.commit();
            System.out.println("MediaControler: TM.MD: Success.");
            return test_ok;
        } catch(Exception e) {
            System.out.println("MediaControler: TM.MD: Failed. Exception.");
            e.printStackTrace();
            return 0;
        }
  }
  
  //Confirma saque de dinheiro da media para as páginas Edicao_de_media.jsp e Saque_de_dinheiro.jsp [Breno]
    public boolean saqueMedia(int Media_ID, SaqueMediaDTO ps) throws Exception {
        Transacao tr = new Transacao();
        try {
            boolean b;
            tr.begin();
            MediaData mdata = new MediaData();
            DinheiroArrecadadoDTO viz = mdata.getDinheiroArrecadadoForUpdate(Media_ID, tr);
            if (viz.getDinheiro_arrecadado() >= ps.getValor()) {
                float saldo = viz.getDinheiro_arrecadado() - ps.getValor();
                b = mdata.saqueMedia(Media_ID, saldo, tr);
            } else {
                b = false;
            }
            tr.commit();
            System.out.println("OK");
            return b;
        } catch (Exception e) {
            System.out.println("Erro ao sacar dinheiro");
            e.printStackTrace();
        }
        return false;
    }
  
}
