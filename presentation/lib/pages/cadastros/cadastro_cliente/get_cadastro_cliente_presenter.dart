import 'package:cloud_firestore/cloud_firestore.dart';
import 'cadastro_cliente_presenter.dart';

class GetCadastroCliente implements ICadastroCliente {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future addCliente(
    String nome,
    String cpf,
    String celular,
    String endereco,
  ) async {
    await _firestore.collection('clientes').add({
      'nome': nome,
      'cpf': cpf,
      'celular': celular,
      'endereço': endereco,
    });
  }
}
