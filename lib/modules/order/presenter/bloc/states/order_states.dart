import '../../../../errors/errors.dart';
import '../../../domain/entities/order.dart';

abstract class OrderStates {}

class OrderIdleState extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class OrderSuccessState extends OrderStates {}

class OrderSendOrderSuccessState implements OrderSuccessState {
  final Order order;

  OrderSendOrderSuccessState(this.order);
}

class OrderGetListSuccessState extends OrderStates {
  final List<Order> orderList;

  OrderGetListSuccessState(this.orderList);
}

class OrderErrorState extends OrderStates {
  final OrderError orderError;

  OrderErrorState(this.orderError);
}
