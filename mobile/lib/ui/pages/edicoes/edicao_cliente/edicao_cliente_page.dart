import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// ignore: avoid_relative_lib_imports
import '../../../../../../presentation/lib/pages/edicoes/edicao_cliente/edicao_cliente_presenter.dart';
import '../../consultas/consulta_cliente/consulta_cliente_page.dart';
import '../../home/home_page.dart';

class EdicaoCliente extends StatefulWidget {
  final String idUser;
  const EdicaoCliente({Key? key, required this.idUser}) : super(key: key);

  @override
  State<EdicaoCliente> createState() => _EdicaoClienteState();
}

class _EdicaoClienteState extends State<EdicaoCliente> {
  final IEdicaoCliente presenter = IEdicaoCliente();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final cpf = TextEditingController();
  final celular = TextEditingController();
  final endereco = TextEditingController();
  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###.##", type: MaskAutoCompletionType.eager);
  final maskCel = MaskTextInputFormatter(
      mask: "+ (##) #####-####", type: MaskAutoCompletionType.eager);

  String? nomeDigitado;
  String? cpfDigitado;
  String? celularDigitado;
  String? enderecoDigitado;
  String? teste;

  void dadosExistentes() {
    setState(() {
      nome.text = presenter.nome;
      print(presenter.nome);
      cpf.text = presenter.cpf;
      celular.text = presenter.celular;
      endereco.text = presenter.endereco;
    });
  }

  @override
  void initState() {
    presenter.getCliente(dadosExistentes, widget.idUser);
    print(widget.idUser);
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
              'Cadastro de clientes',
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
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                            controller: nome,
                            initialValue: teste,
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
                          inputFormatters: [maskCpf],
                          controller: cpf,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CPF',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum cpf!';
                            } else if (value.length != 14) {
                              return 'Verifique a quantidade de números informados!';
                            }
                            cpfDigitado = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          inputFormatters: [maskCel],
                          controller: celular,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Número do celular',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum número de celular!';
                            } else if (value.length != 17) {
                              return 'Verifique a quantidade de números informados!';
                            }
                            celularDigitado = value;
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        child: TextFormField(
                          controller: endereco,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Endereço',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe algum endereço!';
                            }
                            enderecoDigitado = value;
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

                              if (nomeDigitado != null &&
                                  cpfDigitado != null &&
                                  celularDigitado != null &&
                                  enderecoDigitado != null) {
                                await presenter.updateCliente(
                                  nomeDigitado!,
                                  cpfDigitado!,
                                  celularDigitado!,
                                  enderecoDigitado!,
                                  widget.idUser,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ConsultaCliente()));
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
                                  'Editar cliente',
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
