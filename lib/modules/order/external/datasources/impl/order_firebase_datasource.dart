import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/infra/datasources/i_order_datasource.dart';
import 'package:cardapio/modules/order/infra/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../login/infra/models/user_model.dart';
import '../../../../menu/infra/models/item_menu_model.dart';

class OrderFirebaseDatasource implements IOrderDatasource {
  final ILoggedUserDatasource _loggedUserDatasource;
  final _userOrderCollection = FirebaseFirestore.instance.collection('users');
  final _orderCollection = FirebaseFirestore.instance.collection('orders');

  OrderFirebaseDatasource(this._loggedUserDatasource);

  @override
  Future<OrderModel> create(OrderModel order) async {
    try {
      final user = UserModel.fromUser(user: order.user).toMap();
      final result = await _userOrderCollection
          .doc(order.user.id)
          .collection('orders')
          .add(order.toMap(user: user))
          .catchError((e) => throw OrderError(e.toString()));

      order.id = result.id;
      await _userOrderCollection
          .doc(order.user.id)
          .collection('orders')
          .doc(result.id)
          .update(order.toMap(user: user))
          .catchError((e) => throw OrderError(e.toString()));

      await _orderCollection
          .doc(order.id)
          .set(order.toMap(user: user))
          .catchError((e) => throw OrderError(e.toString()));

      return order;
    } on OrderError catch (e) {
      throw OrderError(e.message);
    }
  }

  @override
  Future<OrderModel> cancel(OrderModel order) async {
    order.status = OrderStatus.cancelled;

    final user = UserModel.fromUser(user: order.user).toMap();

    _userOrderCollection
        .doc(order.user.id)
        .collection('orders')
        .doc(order.id)
        .update(order.toMap(user: user));

    _orderCollection.doc(order.id).update(order.toMap(user: user));

    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orderList = [];
    final user = await _loggedUserDatasource.getLoggedUser();

    final snap =
        await _userOrderCollection.doc(user.id).collection('orders').get();

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
