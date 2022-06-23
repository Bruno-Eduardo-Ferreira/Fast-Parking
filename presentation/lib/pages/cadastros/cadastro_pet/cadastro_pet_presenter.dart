import 'package:flutter/cupertino.dart';

import 'get_cadastro_pet_presenter.dart';

abstract class ICadastroPet {
  factory ICadastroPet() => GetCadastroPet();

  String get idUser;
  set idUser(String idUser);
  List<dynamic> get clientesCadastrados;
  set clientesCadastrados(List<dynamic> clientesCadastrados);

  Future getUserId(String user);
  Future getUsers(VoidCallback attdono);
  Future addPet(String nomeDono, String nomePet, String idadePet,
      String sexoPet, String pesoPet, String racaPet, String idUser);
}
