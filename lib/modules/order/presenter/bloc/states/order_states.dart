import '../../../../errors/errors.dart';
import '../../../domain/entities/order.dart';

abstract class OrderStates {}

class OrderIdleState extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class OrderSuccessState extends OrderStates {
  final Order order;

  OrderSuccessState(this.order);
}

class OrderErrorState extends OrderStates {
  final OrderError orderError;

  OrderErrorState(this.orderError);
}
