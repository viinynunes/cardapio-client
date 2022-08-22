import 'package:cardapio/modules/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login/login_module.dart';

class MainModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ModuleRoute('/login/', module: LoginModule()),
      ];
}
