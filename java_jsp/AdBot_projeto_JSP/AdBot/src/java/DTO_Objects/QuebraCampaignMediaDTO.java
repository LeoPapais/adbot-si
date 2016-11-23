/*
 * QuebraCampaignMediaDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                          para Quebra_de_gastos.jsp [Diego]
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

public class QuebraCampaignMediaDTO {
    
    private int CampaignID;
    private String CampaignNome;
    private int MediaID;  
    private String MediaNome;
    private float Gasto;  
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public QuebraCampaignMediaDTO() {
    }
    
    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setCampaignID(int CampaignID) {
        this.CampaignID = CampaignID;
    }

    public void setCampaignNome(String CampaignNome) {
        this.CampaignNome = CampaignNome;
    }

    public void setMediaID(int MediaID) {
        this.MediaID = MediaID;
    }

    public void setMediaNome(String MediaNome) {
        this.MediaNome = MediaNome;
    }

    public void setGasto(float Gasto) {
        this.Gasto = Gasto;
    }
    
    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public int getCampaignID() {
        return CampaignID;
    }

    public String getCampaignNome() {
        return CampaignNome;
    }

    public int getMediaID() {
        return MediaID;
    }

    public String getMediaNome() {
        return MediaNome;
    }

    public float getGasto() {
        return Gasto;
    }

    
    
}
