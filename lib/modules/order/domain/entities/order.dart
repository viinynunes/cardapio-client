import 'package:cardapio/modules/login/domain/entities/user.dart';

import '../../../menu/domain/entities/item_menu.dart';
import 'enums/order_status_enum.dart';

class Order {
  final String id;
  final User user;
  final List<ItemMenu> menuList;
  final DateTime registrationDate;
  OrderStatus status;

  Order({
    required this.id,
    required this.user,
    required this.menuList,
    required this.registrationDate,
    required this.status,
  });
}
