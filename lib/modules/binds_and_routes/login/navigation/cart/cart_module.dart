import 'package:flutter_modular/flutter_modular.dart';

import '../../../../cart/presenter/pages/cart_page.dart';

class CartModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const CartPage()),
      ];
}
