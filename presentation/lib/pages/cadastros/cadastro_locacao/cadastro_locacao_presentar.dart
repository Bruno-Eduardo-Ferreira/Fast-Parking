import 'package:flutter/cupertino.dart';

import 'get_cadastro_locacao_presenter.dart';

abstract class ICadastroLocacao {
  factory ICadastroLocacao() => GetCadastroLocacao();

  String get idUser;
  set idUser(String idUser);
  String get idPet;
  set idPet(String idPet);
  List<dynamic> get clientesCadastrados;
  set clientesCadastrados(List<dynamic> clientesCadastrados);
  List<dynamic> get petsCadastrados;
  set petsCadastrados(List<dynamic> clientesCadastrados);

  Future addVacina(String nomeVacina, DateTime dataAplicado,
      DateTime dataVencimento, String idUser, nomePetAplicado);
  Future getPets(VoidCallback attdono, VoidCallback clearSelectPet, String pet);
  Future getPetID(String pet, String user);
  Future getUsers(VoidCallback attdono);
  Future getUserID(String user);
}
