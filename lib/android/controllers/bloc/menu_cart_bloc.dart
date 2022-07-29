import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/menu_cart_events.dart';
import 'package:cardapio/android/controllers/bloc/states/menu_cart_states.dart';
import 'package:cardapio/modules/week_menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_menu_cart_usecase.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_cart_usecase_impl.dart';

class MenuCartBloc extends Bloc<MenuCartEvents, MenuCartStates> {
  final IMenuCartUsecase usecase = MenuCartUsecaseImpl(MockRepMenuCartImpl());

  MenuCartBloc() : super(MenuCartInitialState()) {
    on<RemoveItemMenuFromCart>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await usecase.removeItemFromCart(event.item);

      Future.delayed(const Duration(seconds: 1));

      result.fold((l) {
        emit(MenuCartErrorState(error: l));
      }, (r) {
        emit(MenuCartSuccessState(menuItemCartList: []));
      });
    });

    on<GetMenuCartList>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await usecase.getMenuCartList();

      result.fold((l) {
        emit(MenuCartErrorState(error: l));
      }, (r) {
        emit(MenuCartSuccessState(menuItemCartList: r));
      });
    });
  }
}
