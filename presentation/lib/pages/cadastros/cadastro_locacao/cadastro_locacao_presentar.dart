import 'package:flutter/cupertino.dart';
import 'get_cadastro_locacao_presenter.dart';

abstract class ICadastroLocacao {
  factory ICadastroLocacao() => GetCadastroLocacao();

  String get idUser;
  set idUser(String idUser);
  String get idCarro;
  set idCarro(String idCarro);
  List<dynamic> get clientesCadastrados;
  set clientesCadastrados(List<dynamic> clientesCadastrados);
  List<dynamic> get carrosCadastrados;
  set carrosCadastrados(List<dynamic> carrosCadastrados);

  Future addLocacao(
      DateTime dataInicio,
      DateTime dataVencimento,
      String idUser,
      String idCarro,
      String formaPagamento,
      String qtdParcelas,
      num valorTotal,
      String nomeUser,
      String placaCarro);
  Future getUsers(VoidCallback attdono);
  Future getCarros(VoidCallback attCarro);
  Future getUserID(String user);
  Future getCarroID(String carro);
}
