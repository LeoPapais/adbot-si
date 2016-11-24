/*
 * UsuarioBloqueioDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                     para verificar bloqueio de usuário
 *
 * Histórico de edição deste arquivo :
 *           [23/11/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

public class UsuarioBloqueioDTO {
    
    private int Bloqueio;
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public UsuarioBloqueioDTO() {
    }
    
    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setBloqueio(int Bloqueio) {
        this.Bloqueio = Bloqueio;
    }
    
    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public int getBloqueio() {
        return Bloqueio;
    }

}
