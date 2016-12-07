/*
 * SaqueMediaDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                        para Saque_de_dinheiro.jsp e Edicao_de_media.jsp [Breno]
 *
 * Histórico de edição deste arquivo :
 *           [16/11/2016] Breno - Versão inicial
 *
 *
 */
package DTO_Objects;

public class SaqueMediaDTO {
    
    private float Valor;
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public SaqueMediaDTO() {
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public float getValor() {
        return Valor;
    }
    
    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setValor(float Valor) {
        this.Valor = Valor;
    }
    
    
}
