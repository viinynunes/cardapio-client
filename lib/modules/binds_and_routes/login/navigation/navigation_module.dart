import 'package:cardapio/modules/cart/infra/repositories/cart_repository_impl.dart';
import 'package:cardapio/modules/order/infra/repositories/mockOrderRepositoryImpl.dart';
import 'package:cardapio/modules/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../cart/domain/usecase/impl/cart_usecase_impl.dart';
import '../../../cart/external/datasources/impl/cart_firebase_datasource.dart';
import '../../../cart/presenter/bloc/cart_bloc.dart';
import '../../../home/presenter/pages/home_page.dart';
import '../../../order/domain/usecases/impl/order_usecase_impl.dart';
import '../../../order/presenter/bloc/order_bloc.dart';
import 'cart/cart_module.dart';
import 'menu/menu_module.dart';
import 'order/order_module.dart';

class NavigationModule extends Module {
  @override
  List<Bind> get binds => [
        //Cart Dependencies
        Bind((i) => CartFirebaseDatasource(i())),
        Bind((i) => CartRepositoryImpl(i())),
        Bind((i) => CartUsecaseImpl(i())),
        Bind((i) => CartBloc(i())),

        //Order Dependencies
        Bind((i) => MockOrderRepositoryImpl()),
        Bind((i) => OrderUsecaseImpl(i())),
        Bind((i) => OrderBloc(i(), i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreenInitial()),
        ChildRoute('/home/', child: (_, __) => const HomePage()),
        ModuleRoute('/cart/', module: CartModule()),
        ModuleRoute('/menu/', module: MenuModule()),
        ModuleRoute('/order/', module: OrderModule()),
      ];
}
