import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';

abstract class MenuCartStates {
  List<ItemMenu> menuItemCartList;
  MenuCartError error;

  MenuCartStates({required this.menuItemCartList, required this.error});
}

class MenuCartInitialState extends MenuCartStates {
  MenuCartInitialState()
      : super(menuItemCartList: [], error: MenuCartError(''));
}

class MenuCartLoadingState extends MenuCartStates {
  MenuCartLoadingState()
      : super(menuItemCartList: [], error: MenuCartError(''));
}

class MenuCartSuccessState extends MenuCartStates {
  MenuCartSuccessState({required List<ItemMenu> menuItemCartList})
      : super(menuItemCartList: menuItemCartList, error: MenuCartError(''));
}

class MenuCartErrorState extends MenuCartStates {
  MenuCartErrorState({required MenuCartError error})
      : super(menuItemCartList: [], error: error);
}
