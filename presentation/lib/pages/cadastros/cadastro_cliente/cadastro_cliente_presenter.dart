import 'get_cadastro_cliente_presenter.dart';

abstract class ICadastroCliente {
  factory ICadastroCliente() => GetCadastroCliente();
  
  Future addCliente(String nome, String cpf, String celular, String endereco);
}
