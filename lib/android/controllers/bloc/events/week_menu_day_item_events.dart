import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';

abstract class WeekMenuDayItemEvents {}

class AddItemMenuToCartEvent extends WeekMenuDayItemEvents {
  ItemMenu itemMenu;

  AddItemMenuToCartEvent(this.itemMenu);
}
