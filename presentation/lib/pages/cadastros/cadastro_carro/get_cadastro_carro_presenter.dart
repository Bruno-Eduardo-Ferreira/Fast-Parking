import 'package:cloud_firestore/cloud_firestore.dart';
import 'cadastro_carro_presenter.dart';

class GetCadastroCarro implements ICadastroCarro {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addCarro(String marca, String modelo, String tipo, String cor,
      String placa) async {
    await _firestore.collection('carros').add({
      'marca': marca,
      'modelo': modelo,
      'tipo': tipo,
      'cor': cor,
      'placa': placa,
    });
  }
}
