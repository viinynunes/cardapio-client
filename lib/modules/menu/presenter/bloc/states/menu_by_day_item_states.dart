import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class MenuByDayItemStates {}

class MenuByDayItemIdleState extends MenuByDayItemStates {}

class MenuByDayItemLoadingState extends MenuByDayItemStates {}

class MenuByDayItemGetListSuccessState extends MenuByDayItemStates {
  final List<ItemMenu> itemMenuList;

  MenuByDayItemGetListSuccessState(this.itemMenuList);
}

class MenuByDayItemAddItemToCartSuccessState extends MenuByDayItemStates {
  final ItemMenu itemMenu;

  MenuByDayItemAddItemToCartSuccessState(this.itemMenu);
}

class MenuByDayItemErrorState extends MenuByDayItemStates {
  final CartError error;

  MenuByDayItemErrorState({required this.error});
}
