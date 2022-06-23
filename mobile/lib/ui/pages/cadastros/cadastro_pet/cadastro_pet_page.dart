import 'package:flutter/material.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/cadastros/cadastro_pet/cadastro_pet_presenter.dart';
import '../../home/home_page.dart';

class CadastroPet extends StatefulWidget {
  const CadastroPet({Key? key}) : super(key: key);

  @override
  State<CadastroPet> createState() => _CadastroPetState();
}

class _CadastroPetState extends State<CadastroPet> {
  final ICadastroPet presenter = ICadastroPet();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nomeDono = TextEditingController();
  final nomePet = TextEditingController();
  final idadePet = TextEditingController();
  final sexoPet = TextEditingController();
  final pesoPet = TextEditingController();
  final racaPet = TextEditingController();

  String? nomeDonoDigitado;
  String? nomePetDigitado;
  String? idadePetDigitado;
  String? sexoPetDigitado;
  String? pesoPetDigitado;
  String? racaPetDigitado;

  final selectSexo = ['F', 'M'];
  final selectTempoIdade = ['Ano', 'Mês'];

  String? selectedSexoPet;
  String? selectedTempoIdade;
  String? selectDono;
  String? idUser;
  bool? flagTempo;

  void attDono() {
    setState(() {
      presenter.clientesCadastrados;
    });
  }

  @override
  void initState() {
    presenter.getUsers(attDono);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cadastro de pets',
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
                          padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
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
                                  nomeDonoDigitado = valuename as String;
                                  setState(() {
                                    selectDono = valuename;
                                  });
                                  presenter.getUserId(selectDono!);
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                            controller: nomePet,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome do pet',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe algum nome!';
                              } else if (value.length > 80) {
                                return 'São permitidos no máximo 80 caracteres para o nome!';
                              }
                              nomePetDigitado = value;
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Informe o tempo:    ',
                              style: TextStyle(fontSize: 16),
                            ),
                            DropdownButton(
                              hint: const Text('Selecione o tempo'),
                              value: selectedTempoIdade,
                              items: selectTempoIdade.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 24),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTempoIdade = value as String?;
                                  flagTempo = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: idadePet,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Idade do pet',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe alguma idade!';
                            } else if (flagTempo != true) {
                              return 'Selecione o tempo no campo superior!';
                            }
                            if (value != '1') {
                              idadePetDigitado = value;
                              if (selectedTempoIdade == 'Mês') {
                                selectedTempoIdade = 'Meses';
                                idadePetDigitado = idadePetDigitado! +
                                    ' ' +
                                    selectedTempoIdade!;
                              } else {
                                idadePetDigitado = idadePetDigitado! +
                                    ' ' +
                                    selectedTempoIdade! +
                                    's';
                              }
                            } else {
                              idadePetDigitado = value;
                              idadePetDigitado =
                                  idadePetDigitado! + ' ' + selectedTempoIdade!;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Sexo do pet:    ',
                              style: TextStyle(fontSize: 16),
                            ),
                            DropdownButton(
                              hint: const Text('Selecione o sexo do pet'),
                              value: selectedSexoPet,
                              items: selectSexo.map((itemsname) {
                                return DropdownMenuItem(
                                    value: itemsname,
                                    child: Text(
                                      itemsname,
                                      style: const TextStyle(fontSize: 24),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                sexoPetDigitado = value as String;
                                setState(() {
                                  selectedSexoPet = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: pesoPet,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Peso do pet em kg',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum peso!';
                            }
                            pesoPetDigitado = value + ' Kg';
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: racaPet,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Raça do pet',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe alguma raça!';
                            }
                            racaPetDigitado = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();

                              if (nomeDonoDigitado != null &&
                                  nomePetDigitado != null &&
                                  idadePetDigitado != null &&
                                  sexoPetDigitado != null &&
                                  pesoPetDigitado != null &&
                                  racaPetDigitado != null) {
                                await presenter.addPet(
                                    nomeDonoDigitado!,
                                    nomePetDigitado!,
                                    idadePetDigitado!,
                                    sexoPetDigitado!,
                                    pesoPetDigitado!,
                                    racaPetDigitado!,
                                    presenter.idUser);
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
                                  'Cadastrar pet',
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
