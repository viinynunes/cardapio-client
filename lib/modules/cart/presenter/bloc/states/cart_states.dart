import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartSuccessState extends CartStates {
  final List<ItemMenu> menuItemCartList;

  CartSuccessState(this.menuItemCartList);
}

class CartErrorState extends CartStates {
  final OrderError? orderError;
  final CartError? menuCartError;

  CartErrorState({this.menuCartError, this.orderError});
}
