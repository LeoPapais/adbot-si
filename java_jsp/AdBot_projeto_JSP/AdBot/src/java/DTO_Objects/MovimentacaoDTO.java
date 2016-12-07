/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO_Objects;

import java.sql.Date;

public class MovimentacaoDTO {
    
    private String Descricao;
    private float Valor;
    private Date Data_movimentacao;
         

    public MovimentacaoDTO() {
    }

    public String getDescricao() {
        return Descricao;
    }

    public void setDescricao(String Descricao) {
        this.Descricao = Descricao;
    }

    public float getValor() {
        return Valor;
    }

    public void setValor(float Valor) {
        this.Valor = Valor;
    }

    public Date getData_movimentacao() {
        return Data_movimentacao;
    }

    public void setData_movimentacao(Date Data_movimentacao) {
        this.Data_movimentacao = Data_movimentacao;
    }
}