import 'package:flutter/cupertino.dart';
import 'get_edicao_carro_presenter.dart';

abstract class IEdicaoCarro {
  factory IEdicaoCarro() => GetEdicaoCarro();

  String get marca;
  set marca(String marca);
  String get modelo;
  set modelo(String modelo);
  String get cor;
  set cor(String cor);
  String get placa;
  set placa(String placa);

  Future updateCarro(
      String marca, String modelo, String cor, String placa, String idCarro);
  Future getCarro(VoidCallback atribuirDados, String idCarro);
}
