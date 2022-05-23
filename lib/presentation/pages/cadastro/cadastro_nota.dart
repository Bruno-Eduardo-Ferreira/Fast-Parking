import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../home/home_page.dart';

class CadastroNota extends StatefulWidget {
  const CadastroNota({Key? key}) : super(key: key);

  @override
  State<CadastroNota> createState() => _CadastroNotaState();
}

class _CadastroNotaState extends State<CadastroNota> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final placa = TextEditingController();
  final dias = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addNota(String nome, String placa, String dataInicial,
      String datafinal, num dias) async {
    await _firestore.collection('notas').add({
      'nome': nome,
      'placa': placa,
      'dataincial': dataInicial,
      'datafinal': dataFinal,
      'dias': dias,
    });
  }

  String? nomeDigitado;
  String? placaDigitado;
  num? diasDigitado;
  DateTime? dataiDigitado;
  DateTime? datafDigitado;
  DateTime? dataFinal;
  String? dataPtInicial;
  DateTime? dataAtual = DateTime.now();
  bool teste = false;
  String? dataPtFinal = 'Sem data final Previsto';

  @override
  Widget build(BuildContext context) {
    
    dataPtInicial =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(dataAtual!);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Text(
                    'Cadastrar Nota',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                          controller: nome,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum nome!';
                            } else if (value.length > 80) {
                              return 'São permitidos no máximo 80 caracteres para o nome!';
                            }
                            nomeDigitado = value;
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: TextFormField(
                        controller: placa,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Placa',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe alguma placa!';
                          } else if (value.length < 7) {
                            return 'Verifique a quantidade de caracteres informados!';
                          }
                          placaDigitado = value;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
                      child: Text('Data inicial: $dataPtInicial'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 310, 6),
                      child: TextFormField(
                        controller: dias,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Dias',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe quantos dias!';
                          }
                          diasDigitado = num.parse(value);
                          dataFinal = dataAtual!
                              .add(Duration(days: diasDigitado as int));
                          dataPtFinal =
                              DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                  .format(dataFinal!);
                                  print(dataPtFinal);
                                  setState(() => txtDatafinal(dataPtFinal!),);
                                  teste = true;
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
                      child: teste ? Text(dataPtFinal!) : const Text('Sem data final prevista ainda.')
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();

                            if (nomeDigitado != null &&
                                placaDigitado != null &&
                                dataPtInicial != null &&
                                dataPtFinal != null &&
                                diasDigitado != null) {
                              await _addNota(nomeDigitado!, placaDigitado!,
                                  dataPtInicial!, dataPtFinal!, diasDigitado!);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                            }
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget txtDatafinal(String data){
  return Text('Data final: $data');
}