import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'cadastro_vacina_presentar.dart';

class GetCadastroVacina implements ICadastroVacina {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _idPet = '';
  @override
  String get idPet => _idPet;
  @override
  set idPet(String idPet) => _idPet = idPet;

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

  List _petsCadastrados = [];
  @override
  List get petsCadastrados => _petsCadastrados;
  @override
  set petsCadastrados(List petsCadastrados) =>
      _petsCadastrados = petsCadastrados;

  @override
  Future addVacina(String nomeVacina, DateTime dataAplicado,
      DateTime dataVencimento, String idUser, nomePetAplicado) async {
    await _firestore
        .collection('clientes')
        .doc(idUser)
        .collection('pets')
        .doc(idPet)
        .collection('vacinas')
        .add({
      'idUser': idUser,
      'idPet': idPet,
      'nomeVacina': nomeVacina,
      'dataAplicado': dataAplicado,
      'dataVencimento': dataVencimento,
      'nomePet': nomePetAplicado,
      'status': 'await',
    });
  }

  @override
  Future getPetID(String pet, String user) async {
    var colletion = _firestore.collectionGroup('pets');
    var result = await colletion.get();
    for (var doc in result.docs) {
      if (doc['nomePet'] == pet && doc['nomeDono'] == user) {
        idPet = doc.id;
      }
    }
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
  Future getPets(VoidCallback attpet, VoidCallback clearSelectPet, String pet) async {
    var colletion = FirebaseFirestore.instance.collectionGroup('pets');
    var result = await colletion.get();
    clearSelectPet();
    petsCadastrados.clear();
    for (var doc in result.docs) {
      if (doc['nomeDono'] == pet) {
        petsCadastrados.add(doc['nomePet']);
        attpet();
      }
    }
  }
}
