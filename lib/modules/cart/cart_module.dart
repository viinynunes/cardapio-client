import 'package:cardapio/modules/cart/presenter/pages/cart_page.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/logged_user_usecase_impl.dart';
import 'package:cardapio/modules/login/external/impl/login_hive_datasource.dart';
import 'package:cardapio/modules/login/infra/repositories/logged_user_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../menu/domain/repository/mock_rep_impl.dart';
import '../order/domain/usecases/impl/order_usecase_impl.dart';
import '../order/infra/repositories/mockOrderRepositoryImpl.dart';
import '../order/presenter/bloc/order_bloc.dart';
import 'domain/usecase/impl/cart_usecase_impl.dart';
import 'presenter/bloc/cart_bloc.dart';

class CartModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginHiveDatasource()),
        Bind.factory((i) => LoggedUserRepositoryImpl(i())),
        Bind.factory((i) => LoggedUserUsecaseImpl(i())),
        Bind.factory((i) => MockOrderRepositoryImpl()),
        Bind.factory((i) => OrderUsecaseImpl(i())),
        Bind.factory((i) => MockMenuCartRepositoryImpl()),
        Bind.factory((i) => CartUsecaseImpl(i())),
        Bind.singleton((i) => OrderBloc(i(), i(), i(), i())),
        Bind.singleton((i) => CartBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const CartPage()),
      ];
}
