import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'get_consulta_notificacao_presenter.dart';

abstract class IConsultaVacina {
  factory IConsultaVacina() => GetConsultaVacina();

  String get celularNotificacao;
  set celularNotificacao(String celularNotificacao);
  String get nome;
  set nome(String nome);

  Stream<QuerySnapshot> getList();
  Future lauchWpp({@required number, @required message});
  Future finishNotify(String idVac, String idUser, String idPet);
  Future getCelular(String idUser);
}
