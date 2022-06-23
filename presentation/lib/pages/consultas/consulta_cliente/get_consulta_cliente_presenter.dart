import 'package:cloud_firestore/cloud_firestore.dart';
import 'consulta_cliente_presenter.dart';

class GetConsultaCliente implements IConsultaCliente {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future deleteUser(String idUser) async {
    // ignore: unused_local_variable
    var collection = _firestore.collection('clientes').doc(idUser).delete();
  }

  @override
  Stream<QuerySnapshot> getList() {
    return _firestore.collection('clientes').snapshots();
  }
}
