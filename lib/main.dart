import 'package:cardapio/main_app.dart';
import 'package:cardapio/main_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Modular.to.addListener(() {
    debugPrint(Modular.to.path);
  });

  return runApp(ModularApp(module: MainModule(), child: const MainApp()));
}
