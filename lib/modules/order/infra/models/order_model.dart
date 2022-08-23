import 'package:cardapio/modules/login/infra/models/user_model.dart';
import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';

import '../../../menu/infra/models/item_menu_model.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel(
      {required String id,
      required UserModel user,
      required DateTime registrationDate,
      required OrderStatus status,
      required List<ItemMenu> menuList})
      : super(
            id: id,
            user: user,
            registrationDate: registrationDate,
            status: status,
            menuList: menuList);

  OrderModel.fromOrder({required Order order})
      : super(
          id: order.id,
          user: UserModel.fromUser(user: order.user),
          registrationDate: order.registrationDate,
          status: order.status,
          menuList: order.menuList,
        );

  OrderModel.fromMap(
      {required Map<String, dynamic> map,
      required DateTime registrationDate,
      required List<ItemMenuModel> menuList})
      : super(
          id: map['id'],
          user: UserModel.fromMap(map['user']),
          registrationDate: registrationDate,
          status: OrderStatus.values.byName(map['status']),
          menuList: menuList,
        );

  Map<String, dynamic> toMap({required Map<String, dynamic> user}) {
    final map = {
      'id': id,
      'user': user,
      'registrationDate': registrationDate,
      'status': status.name,
      'menuList': menuList
          .map((e) => ItemMenuModel.fromItemMenu(itemMenu: e).toMap())
          .toList(),
    };

    return map;
  }
}
