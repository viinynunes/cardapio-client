import 'package:cardapio/android/modules/android_home_module.dart';
import 'package:cardapio/android/modules/login_module.dart';
import 'package:cardapio/android/modules/order_module.dart';
import 'package:cardapio/android/modules/week_menu_module.dart';
import 'package:cardapio/android/pages/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ModuleRoute('/android-home/', module: AndroidHomeModule()),
        ModuleRoute('/login/', module: LoginModule()),
        ModuleRoute('/order/', module: OrderModule()),
        ModuleRoute('/week-menu/', module: WeekMenuModule()),
      ];
}
