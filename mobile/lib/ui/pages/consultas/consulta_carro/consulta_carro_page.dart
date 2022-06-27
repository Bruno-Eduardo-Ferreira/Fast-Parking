import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/consultas/consulta_carro/consulta_carro_presenter.dart';
import '../../edicoes/edicao_carro/edicao_carro_page.dart';

class ConsultaCarro extends StatefulWidget {
  const ConsultaCarro({Key? key}) : super(key: key);

  @override
  State<ConsultaCarro> createState() => _ConsultaCarroState();
}

class _ConsultaCarroState extends State<ConsultaCarro> {
  final IConsultaCarro presenter = IConsultaCarro();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Consulta de veículos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: 60,
                height: 40,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: StreamBuilder<QuerySnapshot>(
            stream: presenter.getList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:

                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.active:

                case ConnectionState.done:
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('Não possui veículos cadastrado'),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.blue.shade200),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0)),
                              color: Colors.white,
                            ),
                            child: cardCliente(
                                doc.id, doc['placa'], doc['marca']),
                          ),
                        );
                      });
              }
            }),
      )),
    );
  }

  Widget cardCliente(String idCarro, String placa, String marca) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EdicaoCarro(
                      idCarro: idCarro,
                    )));
          },
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  placa,
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                              child: Text(
                                'Atenção!',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.warning_amber_outlined,
                                color: Colors.red,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                        content: const Text(
                          'Você tem certeza que deseja excluir permanentemente o cadastro desse veículo?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text(
                              'Não',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              presenter.deleteCarro(idCarro);
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text(
                              'Sim',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                    size: 35,
                  ),
                )
              ],
            ),
            subtitle: Text(
              'Marca: $marca',
              style: const TextStyle(
                  fontSize: 15.0, height: 2, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
