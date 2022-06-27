import 'package:cloud_firestore/cloud_firestore.dart';
import 'consulta_carro_presenter.dart';

class GetConsultaCarro implements IConsultaCarro {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future deleteCarro(String idCarro) async {
    // ignore: unused_local_variable
    var collection = _firestore.collection('carros').doc(idCarro).delete();
  }

  @override
  Stream<QuerySnapshot> getList() {
    return _firestore.collection('carros').snapshots();
  }
}
