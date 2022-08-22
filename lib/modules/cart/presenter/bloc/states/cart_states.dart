import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartRemoveLoadingState extends CartStates {}

class CartSuccessState extends CartStates {}

class CartAddItemSuccessState extends CartStates {
  final ItemMenu itemMenu;

  CartAddItemSuccessState(this.itemMenu);
}

class CartGetCartListSuccessState extends CartStates {
  final List<ItemMenu> cartList;

  CartGetCartListSuccessState(this.cartList);
}

class CartErrorState extends CartStates {
  final CartError error;

  CartErrorState(this.error);
}
