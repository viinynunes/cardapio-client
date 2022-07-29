import 'package:cardapio/android/controllers/bloc/events/week_menu_day_item_events.dart';
import 'package:cardapio/android/controllers/bloc/states/week_menu_day_item_states.dart';
import 'package:cardapio/modules/week_menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_menu_cart_usecase.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_cart_usecase_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekMenuDayItemBloc
    extends Bloc<WeekMenuDayItemEvents, WeekMenuDayItemStates> {
  final IMenuCartUsecase usecase = MenuCartUsecaseImpl(MockRepMenuCartImpl());

  WeekMenuDayItemBloc() : super(WeekMenuDayItemInitialState()) {
    on<AddItemMenuToCartEvent>((event, emit) async {
      emit(WeekMenuDayItemLoadingState());

      final result = await usecase.addItemToCart(event.itemMenu);

      result.fold((l) {
        emit(WeekMenuDayItemErrorState(error: l));
      }, (r) {
        emit(WeekMenuDayItemSuccessState(itemMenu: r));
      });
    });
  }
}
