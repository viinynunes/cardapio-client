import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class MenuByDayStates {
  List<ItemMenu> menuByDayList;
  GetMenuError error;

  MenuByDayStates({required this.menuByDayList, required this.error});
}

class MenuByDayInitialState extends MenuByDayStates {
  MenuByDayInitialState() : super(menuByDayList: [], error: GetMenuError(''));
}

class MenuByDayLoadingState extends MenuByDayStates {
  MenuByDayLoadingState() : super(menuByDayList: [], error: GetMenuError(''));
}

class MenuByDaySuccessState extends MenuByDayStates {
  MenuByDaySuccessState(
      {required List<ItemMenu> menuByDayList})
      : super(menuByDayList: menuByDayList, error: GetMenuError(''));
}

class MenuByDayErrorState extends MenuByDayStates {
  MenuByDayErrorState({required GetMenuError error})
      : super(menuByDayList: [], error: error);
}
