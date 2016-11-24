/*
 * VisualizacaoAdvertiserPublisherDTO: Classe que contém o objeto de transferência de dados (DTO)
 *                        para Perfil_de_advertiser.jsp [Diego]
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial
 *
 *
 */

package DTO_Objects;

import java.sql.Date;

public class VisualizacaoAdvertiserPublisherDTO {
    private String UserName;
    private String Nome;
    private String Sobrenome;
    private String E_mail;
    private String Conta_de_banco;
    private String Senha;
    private String Tipo_Usuario;
    private Date Data_de_cadastro;
    private int Bloqueio;
    
    // Construtor (para incluí-lo, clique com o botão direito > Insert Code ... > Constructor)
    public VisualizacaoAdvertiserPublisherDTO() {
    }
    
    // Setters (para incluí-los, clique com o botão direito > Insert Code ... > Setters)
    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public void setSobrenome(String Sobrenome) {
        this.Sobrenome = Sobrenome;
    }

    public void setE_mail(String E_mail) {
        this.E_mail = E_mail;
    }

    public void setConta_de_banco(String Conta_de_banco) {
        this.Conta_de_banco = Conta_de_banco;
    }

    public void setSenha(String Senha) {
        this.Senha = Senha;
    }

    public void setTipo_Usuario(String Tipo_Usuario) {
        this.Tipo_Usuario = Tipo_Usuario;
    }

    public void setData_de_cadastro(Date Data_de_cadastro) {
        this.Data_de_cadastro = Data_de_cadastro;
    }

    public void setBloqueio(int Bloqueio) {
        this.Bloqueio = Bloqueio;
    }

    // Getters (para incluí-los, clique com o botão direito > Insert Code ... > Getters)
    public String getUserName() {
        return UserName;
    }

    public String getNome() {
        return Nome;
    }

    public String getSobrenome() {
        return Sobrenome;
    }

    public String getE_mail() {
        return E_mail;
    }

    public String getConta_de_banco() {
        return Conta_de_banco;
    }

    public String getSenha() {
        return Senha;
    }

    public String getTipo_Usuario() {
        return Tipo_Usuario;
    }

    public Date getData_de_cadastro() {
        return Data_de_cadastro;
    }

    public int getBloqueio() {
        return Bloqueio;
    }
    
}
