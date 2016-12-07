/*
 * BloqueioCampaignDTO: Classe que contÃ©m o objeto de
 *                transferÃªncia de dados de BloqueioCampaign(DTO)[Douglas]
 *
 * HistÃ³rico de ediÃ§Ã£o deste arquivo :
 *           [02/11/2016] Diego - VersÃ£o inicial de ListagemCampaignDTO
 *           [19/11/2016] Nelson - AdaptaÃ§Ã£o para ListagemAdvertiserDTO
 *           [19/11/2016] Nelson - AdaptaÃ§Ã£o para BloqueioAdvertiserPublisherDTO
 *           [23/11/2016] Douglas - Adaptaçao para BloqueioCampaignDTO
 *
 */

package DTO_Objects;

public class BloqueioCampaignDTO {
    
    // Construtor
    public BloqueioCampaignDTO(int bloqueiostate) {
        this.bloqueio = bloqueiostate;
    }

   private int bloqueio;

    // GETTERS AND SETTERS
    public int getBloqueio() {
        return bloqueio;
    }

    public void setBloqueio(int state) {
        this.bloqueio = state;
    }
    // fim: getters and setters

    
} // fim: BloqueioCampaingDTO