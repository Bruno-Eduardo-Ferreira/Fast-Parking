import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';
import 'services/auth_service.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(), 
      child: const MyApp(),
    ),
  );
}

