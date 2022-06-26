import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'consulta_notificacao_presenter.dart';

class GetConsultaNotificao implements IConsultaNotificao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _placaCarro = '';
  @override
  String get placaCarro => _placaCarro;
  @override
  set placaCarro(String placaCarro) =>
      _placaCarro = placaCarro;

  String _celularNotificacao = '';
  @override
  String get celularNotificacao => _celularNotificacao;
  @override
  set celularNotificacao(String celularNotificacao) =>
      _celularNotificacao = celularNotificacao;

  String _nome = '';
  @override
  String get nome => _nome;
  @override
  set nome(String nome) => _nome = nome;

  @override
  Stream<QuerySnapshot> getList() {
    return _firestore.collectionGroup('locacoes').snapshots();
  }

  @override
  Future lauchWpp({@required number, @required message}) async {
    final url = 'whatsapp://send?phone=$number&text=$message';
    final uri = Uri.parse('whatsapp://send?phone=$number&text=$message');
    // ignore: deprecated_member_use, avoid_print
    await canLaunchUrl(uri) ? launch(url) : print("não abriu o wpp");
  }

  @override
  Future finishNotify(String idLocacao, String idUser) async {
    // ignore: unused_local_variable
    var collection = await _firestore
        .collection('clientes')
        .doc(idUser)
        .collection('locacoes')
        .doc(idLocacao)
        .update({
      'status': 'done',
    });
  }

  @override
  Future getCelularAndNome(String idUser) async {
    var colletion = await _firestore.collection('clientes').get();
    for (var doc in colletion.docs) {
      if (doc.id == idUser) {
        celularNotificacao = doc['celular'];
        nome = doc['nome'];
      }
    }
  }

    @override
  Future getPlaca(String idCarro) async {
    var colletion = await _firestore.collection('clientes').get();
    for (var doc in colletion.docs) {
      if (doc.id == idCarro) {
        idCarro = doc.id;
        placaCarro = doc['placa'];
      }
    }
  }
}
