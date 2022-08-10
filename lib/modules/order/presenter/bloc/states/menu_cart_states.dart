import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';

abstract class MenuCartStates {
}

class MenuCartInitialState extends MenuCartStates {
}

class MenuCartLoadingState extends MenuCartStates {
}

class MenuCartSuccessState extends MenuCartStates {

  final List<ItemMenu> menuItemCartList;

  MenuCartSuccessState({required this.menuItemCartList});
}

class MenuCartErrorState extends MenuCartStates {

  final MenuCartError error;

  MenuCartErrorState({required this.error});
}
