import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'cadastro_locacao_presentar.dart';

class GetCadastroLocacao implements ICadastroLocacao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _idCarro = '';
  @override
  String get idCarro => _idCarro;
  @override
  set idCarro(String idCarro) => _idCarro = idCarro;

  String _idUser = '';
  @override
  String get idUser => _idUser;
  @override
  set idUser(String idUser) => _idUser = idUser;

  List _clientesCadastrados = [];
  @override
  List get clientesCadastrados => _clientesCadastrados;
  @override
  set clientesCadastrados(List clientesCadastrados) =>
      _clientesCadastrados = clientesCadastrados;

  List _carrosCadastrados = [];
  @override
  List get carrosCadastrados => _carrosCadastrados;
  @override
  set carrosCadastrados(List carrosCadastrados) =>
      _carrosCadastrados = carrosCadastrados;

  @override
  Future addLocacao(DateTime dataInicio,
      DateTime dataVencimento, String idUser, String idCarro, String formaPagamento, String qtdParcelas, num valorTotal) async {
    await _firestore
        .collection('clientes')
        .doc(idUser)
        .collection('locacoes')
        .add({
      'idUser': idUser,
      'idCarro': idCarro,
      'dataInicio': dataInicio,
      'dataVencimento': dataVencimento,
      'formaPagamento': formaPagamento,
      'quantidadeParcelas': qtdParcelas,
      'valotTotal': valorTotal,
      'status': 'await',
    });
  }


  @override
  Future getUsers(VoidCallback attdono) async {
    var colletion = _firestore.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      clientesCadastrados.add(doc['nome']);
      attdono();
    }
  }

  @override
  Future getUserID(String user) async {
    var colletion = FirebaseFirestore.instance.collection('clientes');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc['nome'] == user) {
        idUser = doc.id;
      }
    }
  }

  @override
  Future getCarros(VoidCallback attCarro) async {
    var colletion = await _firestore.collection('carros').get();
    for (var doc in colletion.docs) {
        carrosCadastrados.add(doc['placa']);
        attCarro();
    }
  }

  @override
  Future getCarroID(String carro) async {
    var colletion = await _firestore.collection('carros').get();
    for (var doc in colletion.docs) {
      if (doc['placa'] == carro) {
        idCarro = doc.id;
      }
    }
  }
}
