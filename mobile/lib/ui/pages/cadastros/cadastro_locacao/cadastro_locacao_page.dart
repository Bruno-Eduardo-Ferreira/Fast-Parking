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
  final dataAplicadoCotroller = TextEditingController();
  final dataVencimentoController = TextEditingController();
  final dias = TextEditingController();

  DateTime? dataInicio = DateTime.now();
  DateTime? dataVencimento;
  String? dataPtInicio;
  String? dataPtVencimento;
  DateTime? dataAtual = DateTime.now();
  num? tempoDigitado;
  num? multiplicadorTempo;

  String? selectedPagamento;
  String? selectedParcelas;
  String? selectedDono;
  String? selectedCarro;
  String? selectedTempo;

  bool? flagTempo;
  num? valorTotal;
  num? valorParcela;

  final selectTempo = ['Dia', 'Mês'];
  final selectPagamento = ['à Vista', 'Cartão / crédito', 'Cartão / débito'];
  final selectParcelas = [
    '1x',
    '2x',
    '3x',
    '4x',
    '5x',
    '6x',
    '7x',
    '8x',
    '9x',
    '10x',
    '11x',
    '12x'
  ];

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
              'Cadastro de locação',
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              items:
                                  presenter.clientesCadastrados.map((username) {
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
                              items:
                                  presenter.carrosCadastrados.map((carroname) {
                                return DropdownMenuItem(
                                    value: carroname,
                                    child: Text(
                                      carroname,
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
                              multiplicadorTempo = 1;
                            } else if (flagTempo == false) {
                              tempoDigitado = num.parse(value) * 30;
                              multiplicadorTempo = 30;
                            } else {
                              return 'Informe o tempo no campo superior!';
                            }
                            dataVencimento = dataAtual!
                                .add(Duration(days: tempoDigitado as int));
                            dataPtVencimento =
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                                    .format(dataVencimento!);
                            valorTotal =
                                25 * multiplicadorTempo! * num.parse(value);
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
                                items: selectPagamento.map((pagamentoname) {
                                  return DropdownMenuItem(
                                      value: pagamentoname,
                                      child: Text(
                                        pagamentoname,
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
                      Padding(
                          padding: const EdgeInsets.fromLTRB(44, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Parcelas:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione a quantidade"),
                                value: selectedParcelas,
                                items: selectParcelas.map((parcelasname) {
                                  return DropdownMenuItem(
                                      value: parcelasname,
                                      child: Text(
                                        parcelasname,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedParcelas = value as String;
                                  });
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: dataPtVencimento != null
                            ? Text('Valor total: $valorTotal ,00 R\$.',
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w600))
                            : const Text('Sem valor total.'),
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
                                  dataVencimento != null &&
                                  selectedDono != null &&
                                  selectedCarro != null) {
                                await presenter.addLocacao(
                                    dataInicio!,
                                    dataVencimento!,
                                    presenter.idUser,
                                    presenter.idCarro,
                                    selectedPagamento!,
                                    selectedParcelas!,
                                    valorTotal!,
                                    selectedDono!,
                                    selectedCarro!);
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
