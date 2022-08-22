import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

abstract class CartEvents {}

class GetCartListEvent extends CartEvents {}

class AddItemToCartEvent extends CartEvents {
  ItemMenu itemMenu;

  AddItemToCartEvent(this.itemMenu);
}

class RemoveItemFromCartEvent extends CartEvents {
  final ItemMenu item;

  RemoveItemFromCartEvent(this.item);
}
