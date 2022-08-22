import 'package:cardapio/modules/cart/domain/usecase/i_cart_usecase.dart';
import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_item_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/menu_by_day_item_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuByDayItemBloc extends Bloc<MenuByDayItemEvents, MenuByDayItemStates> {
  final ICartUsecase usecase;

  MenuByDayItemBloc(this.usecase) : super(MenuByDayItemIdleState()) {
    on<MenuByDayItemAddItemMenuToCartEvent>((event, emit) async {
      emit(MenuByDayItemLoadingState());

      final result = await usecase.addItemToCart(event.itemMenu);

      result.fold((l) {
        emit(MenuByDayItemErrorState(error: l));
      }, (r) {
        emit(MenuByDayItemAddItemToCartSuccessState(r));
      });
    });

    on<MenuByDayItemGetMenuCartEvent>((event, emit) async {
      emit(MenuByDayItemLoadingState());

      final result = await usecase.getMenuCartList();

      result.fold((l) => emit(MenuByDayItemErrorState(error: l)),
          (r) => emit(MenuByDayItemGetListSuccessState(r)));
    });
  }
}
