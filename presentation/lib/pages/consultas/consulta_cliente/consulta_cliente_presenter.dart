import 'package:cloud_firestore/cloud_firestore.dart';
import 'get_consulta_cliente_presenter.dart';

abstract class IConsultaCliente {
  factory IConsultaCliente() => GetConsultaCliente();

  Future deleteUser(String idUser);
  Stream<QuerySnapshot> getList();
}
