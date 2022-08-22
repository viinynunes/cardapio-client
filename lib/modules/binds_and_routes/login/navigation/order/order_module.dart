import 'package:flutter_modular/flutter_modular.dart';

import '../../../../order/presenter/pages/order_item.dart';
import '../../../../order/presenter/pages/orders.dart';

class OrderModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const Orders()),
        ChildRoute('/order-item/',
            child: (_, args) => OrderItem(order: args.data[0])),
      ];
}
