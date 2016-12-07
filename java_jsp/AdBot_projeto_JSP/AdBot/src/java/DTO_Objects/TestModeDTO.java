/*
 * BloqueioCampaignDTO: Classe que contém o objeto de
 *                transferência de dados de TestMode(DTO)[Douglas]
 *
 * HistÃ³rico de ediÃ§Ã£o deste arquivo :
 *           [02/11/2016] Diego - VersÃ£o inicial de ListagemCampaignDTO
 *           [19/11/2016] Nelson - AdaptaÃ§Ã£o para ListagemAdvertiserDTO
 *           [19/11/2016] Nelson - AdaptaÃ§Ã£o para BloqueioAdvertiserPublisherDTO
 *           [23/11/2016] Douglas - Adaptaçao para BloqueioCampaignDTO
 *           [23/11/2016] Douglas - Adaptaçao para TestModeDTO
 *
 */

package DTO_Objects;

public class TestModeDTO {
    
    // Construtor
    public TestModeDTO(int testestate) {
        this.teste = testestate;
    }

   private int teste;

    // GETTERS AND SETTERS
    public int getMode() {
        return teste;
    }

    public void setMode(int state) {
        this.teste = state;
    }
    // fim: getters and setters

    
} // fim: TestModeDTO