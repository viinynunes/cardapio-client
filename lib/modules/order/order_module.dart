import 'package:cardapio/modules/login/domain/repositories/mock_login_repository.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/order/domain/usecases/impl/menu_cart_usecase_impl.dart';
import 'package:cardapio/modules/order/domain/usecases/impl/order_usecase_impl.dart';
import 'package:cardapio/modules/order/infra/repositories/mockOrderRepositoryImpl.dart';
import 'package:cardapio/modules/order/presenter/bloc/menu_cart_bloc.dart';
import 'package:cardapio/modules/order/presenter/pages/menu_cart_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => MockLoginRepository()),
        Bind.factory((i) => LoginUsecaseImpl(i())),
        Bind.factory((i) => MockRepMenuCartImpl()),
        Bind.factory((i) => MenuCartUsecaseImpl(i())),
        Bind.singleton((i) => MenuCartBloc(
            orderUsecase: i(), menuCartUsecase: i(), loginUsecase: i())),
        Bind.factory((i) => MockOrderRepositoryImpl()),
        Bind.factory((i) => OrderUsecaseImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const MenuCartPage()),
      ];
}
