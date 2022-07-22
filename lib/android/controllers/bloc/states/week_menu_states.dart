import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';

abstract class MenuState {
  List<ItemMenu> menuByDayList;
  GetMenuError error;

  MenuState({required this.menuByDayList, required this.error});
}

class MenuInitialState extends MenuState {
  MenuInitialState() : super(menuByDayList: [], error: GetMenuError(''));
}

class MenuSuccess extends MenuState {
  MenuSuccess(
      {required List<ItemMenu> menuByDayList, required GetMenuError error})
      : super(menuByDayList: menuByDayList, error: error);
}

class MenuError extends MenuState {
  MenuError({required GetMenuError error})
      : super(menuByDayList: [], error: error);
}
