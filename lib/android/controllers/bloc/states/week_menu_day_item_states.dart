import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';

abstract class WeekMenuDayItemStates {
  ItemMenu itemMenu;
  MenuCartError error;

  WeekMenuDayItemStates({required this.itemMenu, required this.error});
}

class WeekMenuDayItemInitialState extends WeekMenuDayItemStates {
  WeekMenuDayItemInitialState()
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: MenuCartError(''));
}

class WeekMenuDayItemLoadingState extends WeekMenuDayItemStates {
  WeekMenuDayItemLoadingState()
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: MenuCartError(''));
}

class WeekMenuDayItemSuccessState extends WeekMenuDayItemStates {
  WeekMenuDayItemSuccessState({required ItemMenu itemMenu})
      : super(itemMenu: itemMenu, error: MenuCartError(''));
}

class WeekMenuDayItemErrorState extends WeekMenuDayItemStates {
  WeekMenuDayItemErrorState({required MenuCartError error})
      : super(
            itemMenu: ItemMenu(
                name: '', description: '', imgUrl: '', weekdayList: []),
            error: error);
}
