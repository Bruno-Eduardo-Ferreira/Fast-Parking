import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'edicao_cliente_presenter.dart';

class GetEdicaoCliente implements IEdicaoCliente {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _nome = '';
  @override
  String get nome => _nome;
  @override
  set nome(String nome) => _nome = nome;

  String _cpf = '';
  @override
  String get cpf => _cpf;
  @override
  set cpf(String cpf) => _cpf = cpf;

  String _celular = '';
  @override
  String get celular => _celular;
  @override
  set celular(String celular) => _celular = celular;

  String _endereco = '';
  @override
  String get endereco => _endereco;
  @override
  set endereco(String endereco) => _endereco = endereco;

  @override
  Future updateCliente(
    String nome,
    String cpf,
    String celular,
    String endereco,
    String idUser
  ) async {
    await _firestore.collection('clientes').doc(idUser).update({
      'nome': nome,
      'cpf': cpf,
      'celular': celular,
      'endereço': endereco,
    });
  }

  @override
  Future getCliente(VoidCallback atribuirDados, String idUser) async {
    var collection = await _firestore.collection('clientes').doc(idUser).get();
    nome = collection['nome'];
    cpf = collection['cpf'];
    celular = collection['celular'];
    endereco = collection['endereço'];
    atribuirDados();
  }
}
