package transacoes;

import utils.*;
import data.*;
import java.util.*;

public class Contato {

  public boolean incluir (ContatoDO contato) throws Exception{

     // validacao das regras de negocio
     if ( (isEmpty(contato.getNome())) || ( isEmpty(contato.getTelefone())) ) {
       return false;
     }

     // efetuando a transacao
     Transacao tr = new Transacao();
     try {

       tr.begin();
         ContatoData cdata = new ContatoData();
         cdata.incluir(contato, tr);
       tr.commit();
       return true;
       
     } catch(Exception e) {
         tr.rollback();
         System.out.println("erro ao incluir " + contato.getNome());
         e.printStackTrace();
     }
     return false;
  } // incluir

  public boolean atualizar(ContatoDO contato) throws Exception {
     Transacao tr = new Transacao();
	 try{
	   // inserir validacoes de regras de negocio
	   tr.begin();
  	     ContatoData cdata = new ContatoData();
	     cdata.atualizar(contato, tr);
	   tr.commit();
	   return true;
	 } catch (Exception e) {
	   tr.rollback();
	   System.out.println("erro ao atualizar" + contato.getNome());
	   e.printStackTrace();
	 }
	 return false;
  } // atualizar

  public ContatoDO buscar(int idobj) throws Exception{
     Transacao tr = new Transacao();
	 try{
	   tr.beginReadOnly();
  	     ContatoData cdata = new ContatoData();
	     ContatoDO c = cdata.buscar(idobj, tr);
	   tr.commit();
	   return c;
	 } catch (Exception e) {
	   tr.rollback();
	   System.out.println("erro ao buscar" + idobj);
	   e.printStackTrace();
	 }
	 return null;
  } // buscar

  public Vector pesquisar(String nome) {
     if ( isEmpty(nome) )
        return null;

     Transacao tr = new Transacao();
     try {
	     tr.beginReadOnly();
           ContatoData cdata = new ContatoData();
           Vector v = cdata.pesquisarPorNome(nome, tr);
		 tr.commit();
		 return v;
     } catch(Exception e) {
         System.out.println("erro ao pesquisar " + nome);
         e.printStackTrace();
     }
     return null;
  } // pesquisar

  private boolean isEmpty(String s) {
     if (null == s)
       return true;
     if (s.length() == 0)
       return true;
     return false;
  }

  public static void main(String[] args) {
      Contato c = new Contato();
      ContatoDO contato = new ContatoDO();
      try {
	    contato = c.buscar(6);
		System.out.println(contato.getNome());
      } catch(Exception e) {
          e.printStackTrace();
      }
  } // main
} // Contato