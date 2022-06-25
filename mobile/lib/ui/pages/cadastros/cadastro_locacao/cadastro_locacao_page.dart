import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/cadastros/cadastro_locacao/cadastro_locacao_presentar.dart';
import '../../home/home_page.dart';

class CadastroLocacao extends StatefulWidget {
  const CadastroLocacao({Key? key}) : super(key: key);

  @override
  State<CadastroLocacao> createState() => _CadastroLocacaoState();
}

class _CadastroLocacaoState extends State<CadastroLocacao> {
  final ICadastroLocacao presenter = ICadastroLocacao();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nomeVacina = TextEditingController();
  final dataAplicadoCotroller = TextEditingController();
  final dataVencimentoController = TextEditingController();
  final dias = TextEditingController();

  DateTime? dataInicio = DateTime.now();
  DateTime? dataVencimento;
  String? dataPtInicio;
  String? dataPtVencimento;
  DateTime? dataAtual = DateTime.now();
  num? tempoDigitado;

  String? selectedPagamento;
  String? selectedDono;
  String? selectedCarro;
  String? selectedTempo;
  bool? flagTempo;

  final selectTempo = ['Dia', 'Mês'];
  final selectPagamento = ['à Vista', 'Cartão / crédito', 'Cartão / débito'];

  void attDono() {
    setState(() {
      presenter.clientesCadastrados;
    });
  }

  void attCarro() {
    setState(() {
      presenter.carrosCadastrados;
    });
  }

  void clearSelectPet(){
    selectedPagamento = null;
  }

  @override
  void initState() {
    presenter.getUsers(attDono);
    presenter.getCarros(attCarro);
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    dataPtInicio =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(dataAtual!);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cadastro de locações',
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
                                'Dono da locação:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o dono"),
                                value: selectedDono,
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
                                    selectedDono = valuename as String;
                                  });
                                  presenter.getUserID(selectedDono!);
                                },
                              ),
                            ],
                          ),
                          ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Veículo:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione o veículo"),
                                value: selectedCarro,
                                items: presenter.carrosCadastrados
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
                                    selectedCarro = valuename as String;
                                  });
                                  presenter.getCarroID(selectedCarro!);
                                },
                              ),
                            ],
                          ),
                          ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Pagamento:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione a forma"),
                                value: selectedPagamento,
                                items: selectPagamento.map((petname) {
                                  return DropdownMenuItem(
                                      value: petname,
                                      child: Text(
                                        petname,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  setState(() {
                                    selectedPagamento = valuename as String;
                                  });
                                },
                              ),
                            ],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      //   child: TextFormField(
                      //       controller: nomeVacina,
                      //       decoration: const InputDecoration(
                      //         border: OutlineInputBorder(),
                      //         labelText: 'Nome da vacina',
                      //       ),
                      //       keyboardType: TextInputType.name,
                      //       validator: (value) {
                      //         if (value!.isEmpty) {
                      //           return 'Informe algum nome!';
                      //         } else if (value.length > 80) {
                      //           return 'São permitidos no máximo 80 caracteres para o nome!';
                      //         }
                      //         nomeVacinaDigitado = value;
                      //         return null;
                      //       }),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 24, 12),
                        child: Text('Data de início: $dataPtInicio.',
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
                              value: selectedTempo,
                              items: selectTempo.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 20),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                selectedTempo = value as String;
                                selectedTempo == 'Dia'
                                    ? flagTempo = true
                                    : flagTempo = false;
                                setState(() {
                                  selectedTempo = value;
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
                            dataVencimento = dataAtual!
                                .add(Duration(days: tempoDigitado as int));
                            dataPtVencimento =
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                    .format(dataVencimento!);
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: dataPtVencimento != null
                            ? Text('Data de vencimento: $dataPtVencimento.',
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
                                dataPtVencimento;
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
                              if (selectedPagamento != null &&
                                  dataInicio != null &&
                                  dataVencimento != null) {
                                await presenter.addLocacao(
                                    dataInicio!,
                                    dataVencimento!,
                                    presenter.idUser,
                                    presenter.idCarro,
                                    selectedPagamento!);
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
                                  'Cadastrar locação',
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
