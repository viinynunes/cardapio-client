import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/order/domain/entities/order.dart' as order;
import 'package:cardapio/modules/order/domain/repositories/i_order_repository.dart';
import 'package:cardapio/modules/order/infra/datasources/i_order_datasource.dart';
import 'package:cardapio/modules/order/infra/models/order_model.dart';
import 'package:dartz/dartz.dart';

class OrderRepositoryImpl implements IOrderRepository {
  final IOrderDatasource _orderDatasource;

  OrderRepositoryImpl(this._orderDatasource);

  @override
  Future<Either<OrderError, order.Order>> create(order.Order order) async {
    try {
      final result =
          await _orderDatasource.create(OrderModel.fromOrder(order: order));

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    try {
      final result =
          await _orderDatasource.cancel(OrderModel.fromOrder(order: order));

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders() async {
    try {
      final result = await _orderDatasource.getOrders();

      _orderDatasource.sortOrderList(result);

      return Right(result);
    } on OrderError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderError(e.toString()));
    }
  }
}
