import 'package:cardapio/android/modules/login_module.dart';
import 'package:cardapio/android/modules/order_module.dart';
import 'package:cardapio/android/modules/week_menu_module.dart';
import 'package:cardapio/android/pages/android_home/android_home.dart';
import 'package:cardapio/android/pages/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ChildRoute('/android-home', child: (_, __) => const AndroidHome()),
        ModuleRoute('/week-menu', module: WeekMenuModule()),
        ModuleRoute('/login/', module: LoginModule()),
        ModuleRoute('/order/', module: OrderModule()),
      ];
}
