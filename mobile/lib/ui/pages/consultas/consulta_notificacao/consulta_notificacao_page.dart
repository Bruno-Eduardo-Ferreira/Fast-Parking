import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/consultas/consulta_notificacao/consulta_notificacao_presenter.dart';

class ConsultaVacina extends StatefulWidget {
  const ConsultaVacina({Key? key}) : super(key: key);

  @override
  State<ConsultaVacina> createState() => _ConsultaVacinaState();
}

class _ConsultaVacinaState extends State<ConsultaVacina> {
  final IConsultaVacina presenter = IConsultaVacina();

  DateTime dataAtual = DateTime.now();
  DateTime? dataNotificacao;
  String? dataPtExibir;
  final celularPorCard = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Notificações pendentes',
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
      backgroundColor: Colors.blue.shade50,
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
                      child:
                          Text('Não possui vacinas para notificar vencimento.'),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        dataNotificacao = doc['dataVencimento'].toDate();
                        dataPtExibir =
                            DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                .format(dataNotificacao!);
                        if (dataNotificacao!.difference(dataAtual).inDays < 7 &&
                            doc['status'] == 'await') {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.blue.shade200),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0)),
                                color: Colors.white,
                              ),
                              child: cardVac(doc['idUser'], doc['nomeVacina'],
                                  doc['nomePet'], doc['idPet'], doc.id),
                            ),
                          );
                        }
                        return const SizedBox();
                      });
              }
            }),
      )),
    );
  }

  Widget cardVac(String idUser, String nomeVacina, String nomePet, String idPet,
      String idVac) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await presenter.getCelular(idUser);
            presenter.lauchWpp(
                number: presenter.celularNotificacao,
                message:
                    "Olá ${presenter.nome}, a vacina: $nomeVacina, do seu pet: $nomePet, está para vencer na data de: $dataPtExibir");
            count++;
          },
          child: ListTile(
            title: Text(
              nomeVacina,
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Venc.: $dataPtExibir.',
                style: const TextStyle(
                    fontSize: 16.0, height: 2, fontWeight: FontWeight.w600)),
            trailing: Icon(
              Icons.whatsapp_rounded,
              color: Colors.green.shade500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
            onPressed: () {
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
                    'Você tem certeza que essa notificação foi enviada?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
                        presenter.finishNotify(idVac, idUser, idPet);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.notifications_off_outlined),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Finalizar notificação',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
