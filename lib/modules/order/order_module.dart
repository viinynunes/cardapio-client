import 'package:cardapio/modules/order/presenter/bloc/menu_cart_bloc.dart';
import 'package:cardapio/modules/order/presenter/pages/menu_cart.dart';
import 'package:cardapio/modules/menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/order/domain/usecases/impl/menu_cart_usecase_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => MockRepMenuCartImpl()),
    Bind.factory((i) => MenuCartUsecaseImpl(i())),
    Bind.singleton((i) => MenuCartBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const MenuCart()),
      ];
}
