import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

abstract class CartEvents {}

class GetMenuCartList extends CartEvents {}

class RemoveItemMenuFromCart extends CartEvents {
  final ItemMenu item;

  RemoveItemMenuFromCart(this.item);
}
