import 'dart:async';
import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../cadastros/cadastro_cliente/cadastro_cliente_page.dart';
import '../cadastros/cadastro_pet/cadastro_pet_page.dart';
import '../cadastros/cadastro_vacina/cadastro_vacina_page.dart';
import '../consultas/consulta_cliente/consulta_cliente_page.dart';
import '../consultas/consulta_notificacao/consulta_notificacao_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService auth = AuthService();
  bool cadastro = false;
  bool consulta = false;
  bool notificacao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Home Vacpet',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        if (consulta == true || notificacao == true) {
                          consulta = false;
                          notificacao = false;
                          startTimer(2);
                        } else {
                          cadastro = cadastro ? false : true;
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_box_outlined),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Cadastros',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: cadastro ? 200 : 0,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const CadastroCliente()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.account_box_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      'Cadastrar cliente',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const CadastroPet()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.pets_outlined),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Cadastrar pet',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const CadastroVacina()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.vaccines_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Cadastrar vacina',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        if (cadastro == true || notificacao == true) {
                          cadastro = false;
                          notificacao = false;
                          startTimer(1);
                        } else {
                          consulta = consulta ? false : true;
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search_rounded),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Consultas',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: consulta ? 70 : 0,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const ConsultaCliente()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.account_box_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Consultar cliente',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        if (cadastro == true || consulta == true) {
                          cadastro = false;
                          consulta = false;
                          startTimer(0);
                        } else {
                          notificacao = notificacao ? false : true;
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.notifications_active_outlined),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Notificações',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: notificacao ? 70 : 0,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => const ConsultaVacina()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.vaccines_rounded),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Notificar vencimento de vacina',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    auth.logout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.logout),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer(int flag) {
    const oneSec = Duration(milliseconds: 500);
    Timer(
      oneSec,
      () {
        setState(
          () {
            if (flag == 2) {
              cadastro = true;
            } else if (flag == 1) {
              consulta = true;
            } else if (flag == 0){
              notificacao = true;
            }
          },
        );
      },
    );
  }
}
