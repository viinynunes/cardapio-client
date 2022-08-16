import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/domain/repositories/i_order_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/order.dart' as order;

class MockOrderRepositoryImpl implements IOrderRepository {
  @override
  Future<Either<OrderError, order.Order>> create(order.Order order) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(order);
  }

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    await Future.delayed(const Duration(seconds: 2));

    order.status = OrderStatus.cancelled;

    //return Left(OrderError('Order Expired'));
    return Right(order);
  }
}
