/*
 * UsuarioTipoDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                          para verificar tipo de usuário
 *
 * Histórico de edição deste arquivo :
 *           [01/12/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

public class UsuarioTipoDTO {

    private String Tipo;
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public UsuarioTipoDTO() {
    }

    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setTipo(String Tipo) {
        this.Tipo = Tipo;
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public String getTipo() {
        return Tipo;
    }
    
}
