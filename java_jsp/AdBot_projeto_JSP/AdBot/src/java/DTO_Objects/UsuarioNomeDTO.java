/*
 * UsuarioNomeDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                          para verificar nome+sobrenome de usuário
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

public class UsuarioNomeDTO {
    
    private String Nome;
    private String Sobrenome;
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public UsuarioNomeDTO() {
    }

    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public void setSobrenome(String Sobrenome) {
        this.Sobrenome = Sobrenome;
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public String getNome() {
        return Nome;
    }

    public String getSobrenome() {
        return Sobrenome;
    }
    
}
