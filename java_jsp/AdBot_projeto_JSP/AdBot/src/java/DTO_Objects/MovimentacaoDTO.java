/**
 * É o container dos dados das movimentações. 
 * Usado pra poder refazer o histórico de movimentações do usuário.
 */

package DTO_Objects;

import java.sql.Timestamp;

public class MovimentacaoDTO {

    private String descricao;
    private double valor;
    private Timestamp data_hora;
    private int id, usuario_id;

    // Construtor inicializa tudo como null. 
    // Depois esses valores serão atualizados via DB
    public MovimentacaoDTO() {}

    // Setter
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public void setUsuarioId(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public void setDataHora(Timestamp data_hora) {
        this.data_hora = data_hora;
    }

    // Getters
    public String getDescricao() {
        return descricao;
    }

    public int getId() {
        return id;
    }
    
    public int getUsuarioId() {
        return usuario_id;
    }

    public double getValor() {
        return valor;
    }

    public Timestamp getDataHora() {
        return data_hora;
    }    
}
