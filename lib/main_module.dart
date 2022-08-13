import 'package:cardapio/modules/cart/cart_module.dart';
import 'package:cardapio/modules/login/login_module.dart';
import 'package:cardapio/modules/order/order_module.dart';
import 'package:cardapio/modules/menu/menu_module.dart';
import 'package:cardapio/modules/home/presenter/pages/home_page.dart';
import 'package:cardapio/modules/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ChildRoute('/home', child: (_, __) => const HomePage()),
        ModuleRoute('/login/', module: LoginModule()),
        ModuleRoute('/menu', module: MenuModule()),
        ModuleRoute('/order/', module: OrderModule()),
        ModuleRoute('/cart/', module: CartModule()),
      ];
}
