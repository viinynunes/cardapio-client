import '../../../domain/entities/order.dart';

abstract class OrderEvents {}

class SendOrderEvent extends OrderEvents {}

class GetOrderEvent extends OrderEvents {}

class CancelOrderEvent extends OrderEvents {
  final Order order;

  CancelOrderEvent(this.order);
}
