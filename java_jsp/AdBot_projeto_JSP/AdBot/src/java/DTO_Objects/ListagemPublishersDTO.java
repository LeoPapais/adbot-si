/*
 * ListagemPublishersDTO: Classe que contém o objeto de
 *                transferência de dados de Publishers(DTO)[Nelson]
 *
 * Histórico de edição deste arquivo :
 *           [02/11/2016] Diego - Versão inicial de ListagemCampaignDTO
 *           [19/11/2016] Nelson - Adaptação para ListagemAdvertiserDTO
 *           [19/11/2016] Nelson - Adaptação para ListagemPublishersDTO
 *
 */

package DTO_Objects;

public class ListagemPublishersDTO {

    // CONSTRUTOR
    public ListagemPublishersDTO() {
    } // fim: Construtor
    
    private int     ID;
    private String  Nome;
    private String  Sobrenome;
    private String  E_mail;
    private String  Data_de_cadastro;
    private int     Bloqueio;
    private String  Tipo_Usuario;
    private int     ID_Tipo_Usuario;
    private String  Conta_de_banco;

    // GETTERS AND SETTERS
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public String getSobrenome() {
        return Sobrenome;
    }

    public void setSobrenome(String Sobrenome) {
        this.Sobrenome = Sobrenome;
    }

    public String getE_mail() {
        return E_mail;
    }

    public void setE_mail(String E_mail) {
        this.E_mail = E_mail;
    }

    public String getData_de_cadastro() {
        return Data_de_cadastro;
    }

    public void setData_de_cadastro(String Data_de_cadastro) {
        this.Data_de_cadastro = Data_de_cadastro;
    }

    public int getBloqueio() {
        return Bloqueio;
    }

    public void setBloqueio(int Bloqueio) {
        this.Bloqueio = Bloqueio;
    }

    public String getTipo_Usuario() {
        return Tipo_Usuario;
    }

    public void setTipo_Usuario(String Tipo_Usuario) {
        this.Tipo_Usuario = Tipo_Usuario;
    }

    public int getID_Tipo_Usuario() {
        return ID_Tipo_Usuario;
    }

    public void setID_Tipo_Usuario(int ID_Tipo_Usuario) {
        this.ID_Tipo_Usuario = ID_Tipo_Usuario;
    }

    public String getConta_de_banco() {
        return Conta_de_banco;
    }

    public void setConta_de_banco(String Conta_de_banco) {
        this.Conta_de_banco = Conta_de_banco;
    }
    // fim: getters and setters
    
} // fim: ListagemPublishersDTO