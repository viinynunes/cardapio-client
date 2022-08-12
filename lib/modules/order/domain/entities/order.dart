import 'package:cardapio/modules/login/domain/entities/user.dart';

import '../../../menu/domain/entities/item_menu.dart';
import 'enums/order_status_enum.dart';

class Order {
  String id;
  User user;
  List<ItemMenu> menuList;
  DateTime registrationDate;
  OrderStatus status;

  Order({
    required this.id,
    required this.user,
    required this.menuList,
    required this.registrationDate,
    required this.status,
  });
}
