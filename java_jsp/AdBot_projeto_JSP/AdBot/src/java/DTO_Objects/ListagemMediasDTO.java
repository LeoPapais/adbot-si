/*
 * ListagemMediasDTO: Classe que contém o objeto de transferência de dados 
 *                       (DTO) para Listagem_medias.jsp e 
 *                       Sumario_geral_das_metricas_de_performance_de_medias.jsp 
 *
 * Histórico de edição deste arquivo :
 *           [06/12/2016] Gabriel - Versão inicial
 *
 *
 */

package DTO_Objects;

public class ListagemMediasDTO {

    private String Nome;
    private int ID;
    private int Estado;
    private int TestMode;
    private String Tipo_produto;
    private String Endereco_REST_API_chatbot;
    private int Total_visualizacoes;
    private float CPC_minimo;


    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public ListagemMediasDTO() {
    }

    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setEndereco_REST_API_chatbot(String Endereco_REST_API_chatbot) {
        this.Endereco_REST_API_chatbot = Endereco_REST_API_chatbot;
    }

    public void setCPC_minimo(float CPC_minimo) {
        this.CPC_minimo = CPC_minimo;
    }

    public void setEstado(int Estado) {
        this.Estado = Estado;
    }

    public void setTestMode(int TestMode) {
        this.TestMode = TestMode;
    }

    public void setTipo_produto(String Tipo_produto) {
        this.Tipo_produto = Tipo_produto;
    }

    public void setTotal_visualizacoes(int Total_visualizacoes) {
        this.Total_visualizacoes = Total_visualizacoes;
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public String getNome() {
        return Nome;
    }

    public int getID() {
        return ID;
    }

    public int getEstado() {
        return Estado;
    }

    public int getTestMode() {
        return TestMode;
    }

    public String getTipo_produto() {
        return Tipo_produto;
    }

    public String getEndereco_REST_API_chatbot() {
        return Endereco_REST_API_chatbot;
    }

    public int getTotal_visualizacoes() {
        return Total_visualizacoes;
    }

    public float getCPC_minimo() {
        return CPC_minimo;
    }

}