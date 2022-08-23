import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/order/domain/repositories/i_order_repository.dart';
import 'package:cardapio/modules/order/domain/usecases/i_order_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../entities/order.dart' as order;

class OrderUsecaseImpl implements IOrderUsecase {
  final IOrderRepository _repository;

  OrderUsecaseImpl(this._repository);

  @override
  Future<Either<OrderError, order.Order>> create(order.Order order) async {
    if (order.menuList.isEmpty) {
      return Left(OrderError('Order cannot be empty'));
    }

    return _repository.create(order);
  }

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    if (order.status.name == 'closed') {
      return Left(OrderError('Order Already closed'));
    }

    if (order.status.name == 'cancelled') {
      return Left(OrderError('Order Already Cancelled'));
    }

    if (order.id.isEmpty) {
      return Left(OrderError('ID cannot be empty'));
    }

    return _repository.cancel(order);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders() async {
    return _repository.getOrders();
  }
}
