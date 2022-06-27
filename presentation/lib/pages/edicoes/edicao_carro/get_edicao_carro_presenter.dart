import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'edicao_carro_presenter.dart';

class GetEdicaoCarro implements IEdicaoCarro {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _marca = '';
  @override
  String get marca => _marca;
  @override
  set marca(String marca) => _marca = marca;

  String _modelo = '';
  @override
  String get modelo => _modelo;
  @override
  set modelo(String modelo) => _modelo = modelo;

  String _cor = '';
  @override
  String get cor => _cor;
  @override
  set cor(String cor) => _cor = cor;

  String _placa = '';
  @override
  String get placa => _placa;
  @override
  set placa(String placa) => _placa = placa;

  @override
  Future updateCarro(String marca, String modelo, String cor, String placa,
      String idCarro) async {
    await _firestore.collection('carros').doc(idCarro).update({
      'marca': marca,
      'modelo': modelo,
      'cor': cor,
      'placa': placa,
    });
  }

  @override
  Future getCarro(VoidCallback atribuirDados, String idCarro) async {
    var collection = await _firestore.collection('carros').doc(idCarro).get();
    marca = collection['marca'];
    modelo = collection['modelo'];
    cor = collection['cor'];
    placa = collection['placa'];
    atribuirDados();
  }
}
