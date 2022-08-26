import 'package:cardapio/modules/order/infra/models/order_model.dart';

abstract class IOrderDatasource {
  Future<OrderModel> create(OrderModel order);

  Future<OrderModel> cancel(OrderModel order);

  Future<List<OrderModel>> getOrders();

  void sortOrderList(List<OrderModel> orderList);
}
