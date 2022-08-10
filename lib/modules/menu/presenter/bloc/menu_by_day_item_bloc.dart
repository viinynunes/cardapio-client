import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_item_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/menu_by_day_item_states.dart';
import 'package:cardapio/modules/order/domain/usecases/i_menu_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuByDayItemBloc
    extends Bloc<MenuByDayItemEvents, MenuByDayItemStates> {
  final IMenuCartUsecase usecase;

  MenuByDayItemBloc(this.usecase) : super(MenuByDayItemIdleState()) {
    on<MenuByDayItemAddItemMenuToCartEvent>((event, emit) async {
      emit(MenuByDayItemLoadingState());

      final result = await usecase.addItemToCart(event.itemMenu);

      result.fold((l) {
        emit(MenuByDayItemErrorState(error: l));
      }, (r) {
        emit(MenuByDayItemSuccessState(itemMenu: r));
      });
    });
  }
}
