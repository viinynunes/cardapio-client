import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

abstract class MenuByDayItemEvents {}

class MenuByDayItemAddItemMenuToCartEvent extends MenuByDayItemEvents {
  ItemMenu itemMenu;

  MenuByDayItemAddItemMenuToCartEvent(this.itemMenu);
}

class MenuByDayItemGetMenuCartEvent extends MenuByDayItemEvents {}
