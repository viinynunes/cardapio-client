import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/infra/datasources/i_order_datasource.dart';
import 'package:cardapio/modules/order/infra/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../login/infra/models/client_model.dart';
import '../../../../menu/infra/models/item_menu_model.dart';

class OrderFirebaseDatasource implements IOrderDatasource {
  final ILoggedClientDatasource _loggedUserDatasource;
  final _clientOrderCollection =
      FirebaseFirestore.instance.collection('clients');
  final _orderCollection = FirebaseFirestore.instance.collection('orders');

  OrderFirebaseDatasource(this._loggedUserDatasource);

  @override
  Future<OrderModel> create(OrderModel order) async {
    try {
      final client = ClientModel.fromClient(user: order.client).toMap();

      order.registrationDate = DateTime(order.registrationDate.year,
          order.registrationDate.month, order.registrationDate.day);

      final result = await _clientOrderCollection
          .doc(order.client.id)
          .collection('orders')
          .add(order.toMap(client: client))
          .catchError((e) => throw OrderError(e.toString()));

      order.id = result.id;
      await _clientOrderCollection
          .doc(order.client.id)
          .collection('orders')
          .doc(result.id)
          .update(order.toMap(client: client))
          .catchError((e) => throw OrderError(e.toString()));

      await _orderCollection
          .doc(order.id)
          .set(order.toMap(client: client))
          .catchError((e) => throw OrderError(e.toString()));

      return order;
    } on OrderError catch (e) {
      throw OrderError(e.message);
    }
  }

  @override
  Future<OrderModel> cancel(OrderModel order) async {
    order.status = OrderStatus.cancelled;

    final client = ClientModel.fromClient(user: order.client).toMap();

    _clientOrderCollection
        .doc(order.client.id)
        .collection('orders')
        .doc(order.id)
        .update(order.toMap(client: client));

    _orderCollection.doc(order.id).update(order.toMap(client: client));

    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orderList = [];
    final client = await _loggedUserDatasource.getLoggedClient();

    final snap =
        await _clientOrderCollection.doc(client.id).collection('orders').get();

    for (var e in snap.docs) {
      Timestamp timestamp = e.data()['registrationDate'];
      final registrationDate = DateTime.parse(timestamp.toDate().toString());

      List<ItemMenuModel> menuList = [];
      for (var e in e.data()['menuList']) {
        menuList.add(ItemMenuModel.fromMap(map: e));
      }
      orderList.add(OrderModel.fromMap(
          map: e.data(),
          registrationDate: registrationDate,
          menuList: menuList));
    }

    return orderList;
  }

  @override
  void sortOrderList(List<OrderModel> orderList) {
    orderList.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
  }
}
