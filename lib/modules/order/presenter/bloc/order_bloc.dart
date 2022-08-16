import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/errors/errors.dart';

import '../../../cart/domain/usecase/i_cart_usecase.dart';
import '../../../cart/presenter/bloc/cart_bloc.dart';
import '../../../login/domain/entities/user.dart';
import '../../../login/domain/usecases/i_login_usecase.dart';
import '../../../menu/domain/entities/item_menu.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/i_order_usecase.dart';
import 'events/order_events.dart';
import 'states/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final ICartUsecase cartUsecase;
  final ILoginUsecase loginUsecase;
  final IOrderUsecase orderUsecase;
  final CartBloc menuCartBLoc;

  OrderBloc(
      this.cartUsecase, this.loginUsecase, this.orderUsecase, this.menuCartBLoc)
      : super(OrderIdleState()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      late User? user;
      late List<ItemMenu> menuList = [];

      final userResult = await loginUsecase.getLoggedUser();

      userResult.fold(
          (l) => emit(OrderErrorState(OrderError(l.message))), (r) => user = r);

      final menuCartListResult = await cartUsecase.getMenuCartList();

      menuCartListResult.fold((l) => OrderErrorState(OrderError(l.message)),
          (r) => menuList.addAll(r));

      if (user != null && menuList.isNotEmpty) {
        final order = Order(
            id: '0',
            user: user!,
            menuList: menuList,
            registrationDate: DateTime.now(),
            status: OrderStatus.open);

        final orderResult = await orderUsecase.create(order);

        orderResult.fold((l) => emit(OrderErrorState(l)),
            (r) => emit(OrderSendOrderSuccessState(r)));

        await cartUsecase.clearMenuCartList();
      } else {
        emit(OrderErrorState(OrderError('')));
      }
    });

    on<CancelOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.cancel(event.order);

      result.fold(
          (l) => emit(OrderErrorState(l)), (r) => emit(OrderSuccessState()));
    });
  }
}
