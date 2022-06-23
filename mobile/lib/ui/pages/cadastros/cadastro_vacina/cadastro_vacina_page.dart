import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/cadastros/cadastro_vacina/cadastro_vacina_presentar.dart';
import '../../home/home_page.dart';

class CadastroVacina extends StatefulWidget {
  const CadastroVacina({Key? key}) : super(key: key);

  @override
  State<CadastroVacina> createState() => _CadastroVacinaState();
}

class _CadastroVacinaState extends State<CadastroVacina> {
  final ICadastroVacina presenter = ICadastroVacina();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nomeVacina = TextEditingController();
  final dataAplicado = TextEditingController();
  final dataVencimento = TextEditingController();
  final dias = TextEditingController();

  String? nomeVacinaDigitado;
  DateTime? dataVacAplicado = DateTime.now();
  DateTime? dataVacVencimento;
  String? dataPtVacAplicado;
  String? dataPtVacVencimento;
  DateTime? dataAtual = DateTime.now();
  num? tempoDigitado;

  String? selectPet;
  String? selectDono;
  String? selectTempo;
  bool? flagTempo;

  final tempo = ['Dia', 'Mês'];

  void attDono() {
    setState(() {
      presenter.clientesCadastrados;
    });
  }

  void attPet() {
    setState(() {
      presenter.petsCadastrados;
    });
  }

  void clearSelectPet(){
    selectPet = null;
  }

  @override
  void initState() {
    presenter.getUsers(attDono);
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    dataPtVacAplicado =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(dataAtual!);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cadastro de vacinas',
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
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Dono do pet:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o dono do pet"),
                                value: selectDono,
                                items: presenter.clientesCadastrados
                                    .map((username) {
                                  return DropdownMenuItem(
                                      value: username,
                                      child: Text(
                                        username,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  setState(() {
                                    selectDono = valuename as String;
                                  });
                                  presenter.getUserID(selectDono!);
                                  presenter.getPets(attPet, clearSelectPet, selectDono!);
                                },
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Pet:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o pet"),
                                value: selectPet,
                                items: presenter.petsCadastrados.map((petname) {
                                  return DropdownMenuItem(
                                      value: petname,
                                      child: Text(
                                        petname,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  setState(() {
                                    selectPet = valuename as String;
                                  });
                                  presenter.getPetID(selectPet!, selectDono!);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: TextFormField(
                            controller: nomeVacina,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome da vacina',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe algum nome!';
                              } else if (value.length > 80) {
                                return 'São permitidos no máximo 80 caracteres para o nome!';
                              }
                              nomeVacinaDigitado = value;
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 24, 12),
                        child: Text('Data de aplicação: $dataPtVacAplicado.',
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text('Informe o tempo:   '),
                            ),
                            DropdownButton(
                              hint: const Text('Selecione o tempo'),
                              value: selectTempo,
                              items: tempo.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 20),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                selectTempo = value as String;
                                selectTempo == 'Dia'
                                    ? flagTempo = true
                                    : flagTempo = false;
                                setState(() {
                                  selectTempo = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 31, 12),
                        child: TextFormField(
                          controller: dias,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Informe quanto tempo',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe quantos dias!';
                            }
                            if (flagTempo == true) {
                              tempoDigitado = num.parse(value);
                            } else if (flagTempo == false) {
                              tempoDigitado = num.parse(value) * 30;
                            } else {
                              return 'Informe o tempo no campo superior!';
                            }
                            dataVacVencimento = dataAtual!
                                .add(Duration(days: tempoDigitado as int));
                            dataPtVacVencimento =
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                    .format(dataVacVencimento!);
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: dataPtVacVencimento != null
                            ? Text('Data de vencimento: $dataPtVacVencimento.',
                                style: const TextStyle(fontSize: 16))
                            : const Text('Sem data de vencimento.'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              setState(() {
                                dataPtVacVencimento;
                              });
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.calendar_month_outlined),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Verificar data',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              if (selectPet != null &&
                                  nomeVacinaDigitado != null &&
                                  dataVacAplicado != null &&
                                  dataVacVencimento != null) {
                                await presenter.addVacina(
                                    nomeVacinaDigitado!,
                                    dataVacAplicado!,
                                    dataVacVencimento!,
                                    presenter.idUser,
                                    selectPet!);
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
                              Icon(Icons.add_box_outlined),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Cadastrar vacina',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
