/*
 * BloqueioAdvertiserPublisherDTO: Classe que contém o objeto de
 *                transferência de dados de Advertisers(DTO)[Nelson]
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial de ListagemCampaignDTO
 *           [19/11/2016] Nelson - Adaptação para ListagemAdvertiserDTO
 *           [19/11/2016] Nelson - Adaptação para BloqueioAdvertiserPublisherDTO
 *
 */

package DTO_Objects;

public class BloqueioAdvertiserPublisherDTO {

   // Construtor
   public BloqueioAdvertiserPublisherDTO(int to_block_or_not_to_block){
      this.bloqueio = to_block_or_not_to_block;
   } // fim: contructor

   private int bloqueio;

    // GETTERS AND SETTERS
    public int getBloqueio() {
        return bloqueio;
    }

    public void setBloqueio(int bloqueio) {
        this.bloqueio = bloqueio;
    }
    // fim: getters and setters

    
} // fim: ListagemAdvertisersDTO