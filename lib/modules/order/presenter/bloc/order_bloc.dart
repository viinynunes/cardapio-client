import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/core/connectivity/usecases/i_connectivity_usecase.dart';
import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/login/domain/usecases/i_logged_client_usecase.dart';

import '../../../cart/domain/usecase/i_cart_usecase.dart';
import '../../../cart/presenter/bloc/cart_bloc.dart';
import '../../../login/domain/entities/client.dart';
import '../../../menu/domain/entities/item_menu.dart';
import '../../domain/entities/enums/order_status_enum.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/i_order_usecase.dart';
import 'events/order_events.dart';
import 'states/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  final IConnectivityUsecase connectivityUsecase;
  final ICartUsecase cartUsecase;
  final ILoggedClientUsecase loggedClientUsecase;
  final IOrderUsecase orderUsecase;
  final CartBloc cartBLoc;

  OrderBloc(this.connectivityUsecase, this.cartUsecase, this.loggedClientUsecase,
      this.orderUsecase, this.cartBLoc)
      : super(OrderIdleState()) {
    on<SendOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      late Client? client;
      late List<ItemMenu> menuList = [];

      final clientResult = await loggedClientUsecase.getLoggedUser();

      clientResult.fold(
          (l) => emit(OrderErrorState(OrderError(l.message))), (r) => client = r);

      final menuCartListResult = await cartUsecase.getMenuCartList();

      menuCartListResult.fold((l) => OrderErrorState(OrderError(l.message)),
          (r) => menuList.addAll(r));

      if (client != null && menuList.isNotEmpty) {
        final order = Order(
            id: '0',
            number: 1,
            client: client!,
            menuList: menuList,
            registrationDate: DateTime.now(),
            status: OrderStatus.open);

        final connected = await connectivityUsecase.checkConnectivity();

        if (connected) {
          final orderResult = await orderUsecase.create(order);

          orderResult.fold((l) => emit(OrderErrorState(l)),
              (r) => emit(OrderSendOrderSuccessState(r)));

          await cartUsecase.clearMenuCartList();
        } else {
          emit(OrderErrorState(OrderError('No internet connection')));
        }
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
