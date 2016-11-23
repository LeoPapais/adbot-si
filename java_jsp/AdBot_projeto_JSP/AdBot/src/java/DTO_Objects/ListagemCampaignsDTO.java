/*
 * ListagemCampaignsDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                        para Listagem_campaigns.jsp e Sumario_geral_das_metricas_de_performance_de_campaigns.jsp [Diego]
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

public class ListagemCampaignsDTO {

    private String Nome;
    private int ID;
    private String clickURL;
    private float Bid;;
    private String Tipo_produto;
    private String Marca_produto;
    private int Total_visualizacoes;
    private int Total_clicks;
    private float Gasto_total;
    private float Limite_gasto;
    private int Estado;
    private int Autorizacao;

    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public ListagemCampaignsDTO() {
    }

    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public void setID(int ID) {
        this.ID = ID;
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

    public void setTotal_visualizacoes(int Total_visualizacoes) {
        this.Total_visualizacoes = Total_visualizacoes;
    }

    public void setTotal_clicks(int Total_clicks) {
        this.Total_clicks = Total_clicks;
    }

    public void setGasto_total(float Gasto_total) {
        this.Gasto_total = Gasto_total;
    }

    public void setLimite_gasto(float Limite_gasto) {
        this.Limite_gasto = Limite_gasto;
    }

    public void setEstado(int Estado) {
        this.Estado = Estado;
    }

    public void setAutorizacao(int Autorizacao) {
        this.Autorizacao = Autorizacao;
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public String getNome() {
        return Nome;
    }

    public int getID() {
        return ID;
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

    public int getTotal_visualizacoes() {
        return Total_visualizacoes;
    }

    public int getTotal_clicks() {
        return Total_clicks;
    }

    public float getGasto_total() {
        return Gasto_total;
    }

    public float getLimite_gasto() {
        return Limite_gasto;
    }

    public int getEstado() {
        return Estado;
    }

    public int getAutorizacao() {
        return Autorizacao;
    }
 
    
}
