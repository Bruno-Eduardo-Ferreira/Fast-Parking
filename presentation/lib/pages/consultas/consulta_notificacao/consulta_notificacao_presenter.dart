import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'get_consulta_notificacao_presenter.dart';

abstract class IConsultaNotificao {
  factory IConsultaNotificao() => GetConsultaNotificao();

  String get placaCarro;
  set placaCarro(String placaCarro);
  String get celularNotificacao;
  set celularNotificacao(String celularNotificacao);
  String get nome;
  set nome(String nome);

  Stream<QuerySnapshot> getList();
  Future lauchWpp({@required number, @required message});
  Future finishNotify(String idLocacao, String idUser);
  Future getCelularAndNome(String idUser);
  Future getPlaca(String idCarro);
}
