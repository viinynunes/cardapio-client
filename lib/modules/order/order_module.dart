import 'package:cardapio/modules/cart/presenter/bloc/cart_bloc.dart';
import 'package:cardapio/modules/login/domain/repositories/mock_login_repository.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/order/domain/usecases/impl/order_usecase_impl.dart';
import 'package:cardapio/modules/order/infra/repositories/mockOrderRepositoryImpl.dart';
import 'package:cardapio/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio/modules/order/presenter/pages/personal_order_item.dart';
import 'package:cardapio/modules/order/presenter/pages/personal_orders.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cart/domain/usecase/impl/cart_usecase_impl.dart';
import '../login/domain/usecases/impl/logged_user_usecase_impl.dart';
import '../login/external/impl/login_hive_datasource.dart';
import '../login/infra/repositories/logged_user_repository_impl.dart';
import '../menu/domain/repository/mock_rep_impl.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => MockLoginRepository()),
        Bind.factory((i) => MockMenuCartRepositoryImpl()),
        Bind.factory((i) => LoginHiveDatasource()),
        Bind.factory((i) => LoggedUserRepositoryImpl(i())),
        Bind.factory((i) => LoggedUserUsecaseImpl(i())),
        Bind.factory((i) => CartUsecaseImpl(i())),
        Bind.factory((i) => LoginUsecaseImpl(i())),
        Bind.factory((i) => MockOrderRepositoryImpl()),
        Bind.factory((i) => OrderUsecaseImpl(i())),
        Bind.factory((i) => CartBloc(i())),
        Bind.singleton((i) => OrderBloc(i(), i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const PersonalOrders()),
        ChildRoute('/order-item/',
            child: (_, args) => PersonalOrderItem(
                  order: args.data[0],
                ))
      ];
}
