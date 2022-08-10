import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/menu/errors/errors.dart';

abstract class MenuByDayItemStates {
  ItemMenu itemMenu;
  MenuCartError error;

  MenuByDayItemStates({required this.itemMenu, required this.error});
}

class MenuByDayItemIdleState extends MenuByDayItemStates {
  MenuByDayItemIdleState()
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: MenuCartError(''));
}

class MenuByDayItemLoadingState extends MenuByDayItemStates {
  MenuByDayItemLoadingState()
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: MenuCartError(''));
}

class MenuByDayItemSuccessState extends MenuByDayItemStates {
  MenuByDayItemSuccessState({required ItemMenu itemMenu})
      : super(itemMenu: itemMenu, error: MenuCartError(''));
}

class MenuByDayItemErrorState extends MenuByDayItemStates {
  MenuByDayItemErrorState({required MenuCartError error})
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: error);
}
