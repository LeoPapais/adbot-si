/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO_Objects;

/**
 *
 * @author felip
 */
public class CriacaoUpdateMediaDTO {
    private int Media_ID;
    private String Nome;
    private String Tipo_produto;
    private String Endereco_REST_API_chatbot;
    private float CPC_minimo;
    
    public int getMedia_ID() {
     return Media_ID;
  } // getId

    public String getNome() {
        return Nome;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public String getTipo_produto() {
        return Tipo_produto;
    }

    public void setTipo_produto(String Tipo_produto) {
        this.Tipo_produto = Tipo_produto;
    }

    public String getEndereco_REST_API_chatbot() {
        return Endereco_REST_API_chatbot;
    }

    public void setEndereco_REST_API_chatbot(String Endereco_REST_API_chatbot) {
        this.Endereco_REST_API_chatbot = Endereco_REST_API_chatbot;
    }

    public float getCPC_minimo() {
        return CPC_minimo;
    }

    public void setCPC_minimo(float CPC_minimo) {
        this.CPC_minimo = CPC_minimo;
    }

    
//Construtor
    public CriacaoUpdateMediaDTO() {
    }
   
}
