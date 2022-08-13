import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class MenuByDayItemStates {}

class MenuByDayItemIdleState extends MenuByDayItemStates {}

class MenuByDayItemLoadingState extends MenuByDayItemStates {}

class MenuByDayItemSuccessState extends MenuByDayItemStates {
  final ItemMenu? itemMenu;
  final List<ItemMenu>? itemMenuList;

  MenuByDayItemSuccessState({this.itemMenu, this.itemMenuList});
}

class MenuByDayItemErrorState extends MenuByDayItemStates {
  final CartError error;

  MenuByDayItemErrorState({required this.error});
}
