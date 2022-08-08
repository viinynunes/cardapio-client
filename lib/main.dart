import 'package:cardapio/main_app.dart';
import 'package:cardapio/main_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: MainModule(), child: const MainApp()));
}
