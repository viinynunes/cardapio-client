import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/order/domain/usecases/i_menu_cart_usecase.dart';
import 'package:cardapio/modules/order/presenter/bloc/events/menu_cart_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/menu_cart_states.dart';

class MenuCartBloc extends Bloc<MenuCartEvents, MenuCartStates> {
  final IMenuCartUsecase menuCartUsecase;

  MenuCartBloc(this.menuCartUsecase) : super(MenuCartInitialState()) {
    on<RemoveItemMenuFromCart>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await menuCartUsecase.removeItemFromCart(event.item);

      Future.delayed(const Duration(seconds: 1));

      result.fold((l) {
        emit(MenuCartErrorState(menuCartError: l));
      }, (r) {
        emit(MenuCartSuccessState([]));
      });
    });

    on<GetMenuCartList>((event, emit) async {
      emit(MenuCartLoadingState());

      final result = await menuCartUsecase.getMenuCartList();

      result.fold((l) {
        emit(MenuCartErrorState(menuCartError: l));
      }, (r) {
        emit(MenuCartSuccessState(r));
      });
    });
  }
}
