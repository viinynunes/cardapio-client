import 'package:cardapio/modules/login/domain/repositories/mock_login_repository.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio/modules/order/presenter/pages/personal_orders.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../cart/domain/usecase/impl/cart_usecase_impl.dart';
import '../menu/domain/repository/mock_rep_impl.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => MockLoginRepository()),
        Bind.factory((i) => MockMenuCartRepositoryImpl()),
        Bind.factory((i) => CartUsecaseImpl(i())),
        Bind.factory((i) => LoginUsecaseImpl(i())),
        Bind.singleton((i) => OrderBloc(i(), i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const PersonalOrders()),
      ];
}
