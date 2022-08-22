import 'package:cardapio/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/binds_and_routes/main_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Modular.to.addListener(() {
    debugPrint(Modular.to.path);
  });

  return runApp(ModularApp(module: MainModule(), child: const MainApp()));
}
