import 'package:cardapio/modules/cart/presenter/pages/cart_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../login/domain/repositories/mock_login_repository.dart';
import '../login/domain/usecases/impl/login_usecase_impl.dart';
import '../menu/domain/repository/mock_rep_impl.dart';
import '../order/domain/usecases/impl/order_usecase_impl.dart';
import '../order/infra/repositories/mockOrderRepositoryImpl.dart';
import '../order/presenter/bloc/order_bloc.dart';
import 'domain/usecase/impl/cart_usecase_impl.dart';
import 'presenter/bloc/cart_bloc.dart';

class CartModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => MockLoginRepository()),
        Bind.factory((i) => LoginUsecaseImpl(i())),
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
