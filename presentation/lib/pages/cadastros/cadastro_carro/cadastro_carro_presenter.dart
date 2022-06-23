import 'get_cadastro_carro_presenter.dart';

abstract class ICadastroCarro {
  factory ICadastroCarro() => GetCadastroCarro();

  Future addCarro(
      String marca, String modelo, String tipo, String cor, String placa);
}
