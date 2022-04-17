import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 109.0),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Image.asset('assets/images/logo.png')),
        ],
      ),
    );
  }
}
