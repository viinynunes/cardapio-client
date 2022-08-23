import 'package:cardapio/modules/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../entities/order.dart' as order;

abstract class IOrderRepository {
  Future<Either<OrderError, order.Order>> create(order.Order order);

  Future<Either<OrderError, order.Order>> cancel(order.Order order);

  Future<Either<OrderError, List<order.Order>>> getOrders();
}
