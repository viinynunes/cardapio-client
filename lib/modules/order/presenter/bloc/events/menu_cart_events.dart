import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

abstract class MenuCartEvents {}

class GetMenuCartList extends MenuCartEvents {}

class RemoveItemMenuFromCart extends MenuCartEvents {
  final ItemMenu item;

  RemoveItemMenuFromCart(this.item);
}
