import 'package:cardapio/modules/cart/cart_module.dart';
import 'package:cardapio/modules/home/presenter/pages/home_page.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/login/external/impl/login_firebase_datasource.dart';
import 'package:cardapio/modules/login/external/impl/login_hive_datasource.dart';
import 'package:cardapio/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:cardapio/modules/login/presenter/bloc/login_bloc.dart';
import 'package:cardapio/modules/login/presenter/pages/login_page.dart';
import 'package:cardapio/modules/menu/menu_module.dart';
import 'package:cardapio/modules/order/order_module.dart';
import 'package:cardapio/modules/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginHiveDatasource()),
        Bind((i) => LoginFirebaseDatasource(i())),
        Bind((i) => LoginRepositoryImpl(i())),
        Bind((i) => LoginUsecaseImpl(i())),
        Bind((i) => LoginBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ChildRoute('/home/', child: (_, __) => const HomePage()),
        ChildRoute('/login/', child: (_, __) => const LoginPage()),
        ModuleRoute('/menu/', module: MenuModule()),
        ModuleRoute('/order/', module: OrderModule()),
        ModuleRoute('/cart/', module: CartModule()),
      ];
}
