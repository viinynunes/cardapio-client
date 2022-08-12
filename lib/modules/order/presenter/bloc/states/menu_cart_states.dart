import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

import '../../../../errors/errors.dart';
import '../../../domain/entities/order.dart';

abstract class MenuCartStates {}

class MenuCartInitialState extends MenuCartStates {}

class MenuCartLoadingState extends MenuCartStates {}

class MenuCartSuccessState extends MenuCartStates {}

class MenuCartGetMenuListSuccessState extends MenuCartSuccessState {
  final List<ItemMenu> menuItemCartList;

  MenuCartGetMenuListSuccessState(this.menuItemCartList);
}

class MenuCartSendOrderSuccessState extends MenuCartSuccessState {
  final Order order;

  MenuCartSendOrderSuccessState(this.order);
}

class MenuCartErrorState extends MenuCartStates {
  final OrderError? orderError;
  final MenuCartError? menuCartError;

  MenuCartErrorState({this.menuCartError, this.orderError});
}
