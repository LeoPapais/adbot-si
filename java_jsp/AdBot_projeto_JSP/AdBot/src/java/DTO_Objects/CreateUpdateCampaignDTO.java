/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO_Objects;

/**
 *
 * @author leo
 */
public class CreateUpdateCampaignDTO {

    public CreateUpdateCampaignDTO() {
    }
    
    private String Nome;
    private String clickURL;
    private float Bid;
    private String Tipo_produto;
    private String Marca_produto;
    private float Limite_gasto;
    private int Autorizacao;
    private String Genero_alvo;
    private int Idade_alvo_min;
    private int Idade_alvo_max;
    private String Link_figura_da_impression;
    private String Black_ou_whitelist;


    public String getNome() {
        return Nome;
    }

    public String getClickURL() {
        return clickURL;
    }

    public float getBid() {
        return Bid;
    }

    public String getTipo_produto() {
        return Tipo_produto;
    }

    public String getMarca_produto() {
        return Marca_produto;
    }

    public float getLimite_gasto() {
        return Limite_gasto;
    }

    public int getAutorizacao() {
        return Autorizacao;
    }

    public String getGenero_alvo() {
        return Genero_alvo;
    }

    public int getIdade_alvo_min() {
        return Idade_alvo_min;
    }

    public int getIdade_alvo_max() {
        return Idade_alvo_max;
    }

    public String getLink_figura_da_impression() {
        return Link_figura_da_impression;
    }

    public String getBlack_ou_whitelist() {
        return Black_ou_whitelist;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public void setClickURL(String clickURL) {
        this.clickURL = clickURL;
    }

    public void setBid(float Bid) {
        this.Bid = Bid;
    }

    public void setTipo_produto(String Tipo_produto) {
        this.Tipo_produto = Tipo_produto;
    }

    public void setMarca_produto(String Marca_produto) {
        this.Marca_produto = Marca_produto;
    }

    public void setLimite_gasto(float Limite_gasto) {
        this.Limite_gasto = Limite_gasto;
    }

    public void setAutorizacao(int Autorizacao) {
        this.Autorizacao = Autorizacao;
    }

    public void setGenero_alvo(String Genero_alvo) {
        this.Genero_alvo = Genero_alvo;
    }

    public void setIdade_alvo_min(int Idade_alvo_min) {
        this.Idade_alvo_min = Idade_alvo_min;
    }

    public void setIdade_alvo_max(int Idade_alvo_max) {
        this.Idade_alvo_max = Idade_alvo_max;
    }

    public void setLink_figura_da_impression(String Link_figura_da_impression) {
        this.Link_figura_da_impression = Link_figura_da_impression;
    }

    public void setBlack_ou_whitelist(String Black_ou_whitelist) {
        this.Black_ou_whitelist = Black_ou_whitelist;
    }
    
}
