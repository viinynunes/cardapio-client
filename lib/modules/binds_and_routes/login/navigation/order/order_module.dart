import 'package:flutter_modular/flutter_modular.dart';

import '../../../../order/presenter/pages/personal_order_item.dart';
import '../../../../order/presenter/pages/personal_orders.dart';

class OrderModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const PersonalOrders()),
        ChildRoute('/order-item/',
            child: (_, args) => PersonalOrderItem(order: args.data[0])),
      ];
}
