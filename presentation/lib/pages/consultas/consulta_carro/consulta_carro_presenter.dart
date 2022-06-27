import 'package:cloud_firestore/cloud_firestore.dart';
import 'get_consulta_carro_presenter.dart';

abstract class IConsultaCarro {
  factory IConsultaCarro() => GetConsultaCarro();

  Future deleteCarro(String idCarro);
  Stream<QuerySnapshot> getList();
}
