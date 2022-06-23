import 'package:flutter/cupertino.dart';
import 'get_edicao_cliente_presenter.dart';

abstract class IEdicaoCliente {
  factory IEdicaoCliente() => GetEdicaoCliente();

  String get nome;
  set nome(String nome);
  String get cpf;
  set cpf(String cpf);
  String get celular;
  set celular(String celular);
  String get endereco;
  set endereco(String endereco);
  
  Future updateCliente(String nome, String cpf, String celular, String endereco, String idUser);
  Future getCliente(VoidCallback atribuirDados, String idUser);
}
