import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/login/domain/usecases/i_logged_user_usecase.dart';

import '../../../cart/domain/usecase/i_cart_usecase.dart';
import '../../../cart/presenter/bloc/cart_bloc.dart';
import '../../../login/domain/entities/user.dart';
import '../../../menu/domain/entities/item_menu.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/i_order_usecase.dart';
import 'events/order_events.dart';
import 'states/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final ICartUsecase cartUsecase;
  final ILoggedUserUsecase loggedUserUsecase;
  final IOrderUsecase orderUsecase;
  final CartBloc cartBLoc;

  OrderBloc(this.cartUsecase, this.loggedUserUsecase, this.orderUsecase,
      this.cartBLoc)
      : super(OrderIdleState()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      late User? user;
      late List<ItemMenu> menuList = [];

      final userResult = await loggedUserUsecase.getLoggedUser();

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

    on<GetOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.getOrders();

      result.fold((l) => emit(OrderErrorState(l)),
          (r) => emit(OrderGetListSuccessState(r)));
    });

    on<CancelOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      final result = await orderUsecase.cancel(event.order);

      result.fold(
          (l) => emit(OrderErrorState(l)), (r) => emit(OrderSuccessState()));
    });
  }
}
