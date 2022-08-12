import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/domain/entities/order.dart';
import 'package:cardapio/modules/order/domain/usecases/i_menu_cart_usecase.dart';
import 'package:cardapio/modules/order/presenter/bloc/events/menu_cart_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/menu_cart_states.dart';

import '../../../errors/errors.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/domain/usecases/i_login_usecase.dart';
import '../../domain/usecases/i_order_usecase.dart';

class MenuCartBloc extends Bloc<MenuCartEvents, MenuCartStates> {
  final IMenuCartUsecase menuCartUsecase;
  final IOrderUsecase orderUsecase;
  final ILoginUsecase loginUsecase;

  MenuCartBloc(
      {required this.menuCartUsecase,
      required this.orderUsecase,
      required this.loginUsecase})
      : super(MenuCartInitialState()) {
    on<RemoveItemMenuFromCart>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await menuCartUsecase.removeItemFromCart(event.item);

      Future.delayed(const Duration(seconds: 1));

      result.fold((l) {
        emit(MenuCartErrorState(menuCartError: l));
      }, (r) {
        emit(MenuCartSuccessState());
      });
    });

    on<GetMenuCartList>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await menuCartUsecase.getMenuCartList();

      result.fold((l) {
        emit(MenuCartErrorState(menuCartError: l));
      }, (r) {
        emit(MenuCartGetMenuListSuccessState(r));
      });
    });

    on<MenuCartSendOrder>((event, emit) async {
      emit(MenuCartLoadingState());

      late User? user;
      late List<ItemMenu> menuList = [];

      final menuCartListResult = await menuCartUsecase.getMenuCartList();

      final userResult = await loginUsecase.getLoggedUser();

      userResult.fold(
          (l) =>
              emit(MenuCartErrorState(menuCartError: MenuCartError(l.message))),
          (r) => user = r);

      menuCartListResult.fold((l) => emit(MenuCartErrorState(menuCartError: l)),
          (r) => menuList = r);

      if (user != null && menuList.isNotEmpty) {
        final order = Order(
            id: '0',
            user: user!,
            menuList: menuList,
            registrationDate: DateTime.now(),
            status: OrderStatus.open);

        final orderResult = await orderUsecase.create(order);

        orderResult.fold((l) => emit(MenuCartErrorState(orderError: l)),
            (r) => emit(MenuCartSendOrderSuccessState(r)));
      } else {
        emit(MenuCartErrorState(
            menuCartError: MenuCartError('Erro ao enviar pedido')));
      }
    });
  }
}
