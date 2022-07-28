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

class MenuLoadingState extends MenuState {
  MenuLoadingState() : super(menuByDayList: [], error: GetMenuError(''));
}

class MenuSuccessState extends MenuState {
  MenuSuccessState(
      {required List<ItemMenu> menuByDayList})
      : super(menuByDayList: menuByDayList, error: GetMenuError(''));
}

class MenuErrorState extends MenuState {
  MenuErrorState({required GetMenuError error})
      : super(menuByDayList: [], error: error);
}
