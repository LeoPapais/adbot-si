package data;

public class ContatoDO {
  private int _id;
  private String _nome;
  private String _telefone;

  public int getId() {
     return _id;
  } // getId

  public void setId(int id) {
    _id = id;
  } // setId

  public String getNome() {
    return _nome;
  } // obterNome

  public void setNome(String nome) {
    _nome = nome;
  } // setNome


  public String getTelefone() {
    return _telefone;
  } // getTelefone

  public void setTelefone(String tel) {
    _telefone = tel;
  } // setTelefone


} // ContatoDO