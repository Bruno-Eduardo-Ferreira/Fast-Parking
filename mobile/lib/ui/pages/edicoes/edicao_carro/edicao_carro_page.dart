import 'package:flutter/material.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/edicoes/edicao_carro/edicao_carro_presenter.dart';
import '../../consultas/consulta_carro/consulta_carro_page.dart';
import '../../home/home_page.dart';

class EdicaoCarro extends StatefulWidget {
    final String idCarro;
  const EdicaoCarro({Key? key, required this.idCarro}) : super(key: key);

  @override
  State<EdicaoCarro> createState() => _EdicaoCarroState();
}

class _EdicaoCarroState extends State<EdicaoCarro> {
  final IEdicaoCarro presenter = IEdicaoCarro();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final marca = TextEditingController();
  final modelo = TextEditingController();
  final cor = TextEditingController();
  final placa = TextEditingController();

  String? marcaDigitado;
  String? modeloDigitado;
  String? corDigitado;
  String? placaDigitado;

  final selectMarca = [
    'Agrale',
    'Aston',
    'Martin',
    'Audi',
    'BMW',
    'BYD',
    'CAOA Chery',
    'Chevrolet',
    'Citroën',
    'Dodge',
    'Effa',
    'Exeed',
    'Ferrari',
    'Fiat',
    'Ford',
    'Foton',
    'Honda',
    'Hyundai',
    'Iveco',
    'JAC',
    'Jaguar',
    'Jeep',
    'Kia',
    'Lamborghini',
    'Land Rover',
    'Lexus',
    'Lifan',
    'Maserati',
    'McLaren',
    'Mercedes-AMG',
    'Mercedes-Benz',
    'Mini',
    'Mitsubishi',
    'Nissan',
    'Peugeot',
    'Porsche',
    'RAM',
    'Renault',
    'Rolls-Royce',
    'Subaru',
    'Suzuki',
    'Toyota',
    'Volkswagen',
    'Volvo'
  ];

  String? selectedTipo;
  String? selectedMarca;

  void dadosExistentes() {
    setState(() {
      selectedMarca = presenter.marca;
      modelo.text = presenter.modelo;
      cor.text = presenter.cor;
      placa.text = presenter.placa;
    });
  }

   @override
  void initState() {
    presenter.getCarro(dadosExistentes, widget.idCarro);
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
              'Edição de veículo',
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
                          padding: const EdgeInsets.fromLTRB(34, 6, 24, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Marca do veículo:    ',
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton(
                                hint: const Text("Selecione uma marca"),
                                value: selectedMarca,
                                items: selectMarca.map((username) {
                                  return DropdownMenuItem(
                                      value: username,
                                      child: Text(
                                        username,
                                        style: const TextStyle(fontSize: 24),
                                      ));
                                }).toList(),
                                onChanged: (valuename) {
                                  marcaDigitado = valuename as String;
                                  setState(() {
                                    selectedMarca = valuename;
                                  });
                                },
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                            controller: modelo,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Modelo do veículo',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe algum modelo!';
                              } else if (value.length > 80) {
                                return 'São permitidos no máximo 80 caracteres para o modelo!';
                              }
                              modeloDigitado = value;
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: cor,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Cor do veículo',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe alguma cor!';
                            }
                            corDigitado = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: placa,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Placa do veículo',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe alguma placa!';
                            }
                            placaDigitado = value;
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
                              if (marcaDigitado != null &&
                                  modeloDigitado != null &&
                                  corDigitado != null &&
                                  placaDigitado != null) {
                                await presenter.updateCarro(
                                    marcaDigitado!,
                                    modeloDigitado!,
                                    corDigitado!,
                                    placaDigitado!,
                                    widget.idCarro);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ConsultaCarro()));
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
                                  'Editar veículo',
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
