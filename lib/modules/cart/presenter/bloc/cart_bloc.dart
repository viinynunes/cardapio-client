import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/cart/domain/usecase/i_cart_usecase.dart';
import 'package:cardapio/modules/cart/presenter/bloc/events/cart_events.dart';
import 'package:cardapio/modules/cart/presenter/bloc/states/cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final ICartUsecase cartUsecase;

  CartBloc(this.cartUsecase) : super(CartInitialState()) {
    on<RemoveItemMenuFromCart>((event, emit) async {
      emit(CartLoadingState());

      final result = await cartUsecase.removeItemFromCart(event.item);

      Future.delayed(const Duration(seconds: 1));

      result.fold((l) {
        emit(CartErrorState(menuCartError: l));
      }, (r) {
        emit(CartSuccessState([]));
      });
    });

    on<GetMenuCartList>((event, emit) async {
      emit(CartLoadingState());

      final result = await cartUsecase.getMenuCartList();

      result.fold((l) {
        emit(CartErrorState(menuCartError: l));
      }, (r) {
        emit(CartSuccessState(r));
      });
    });
  }
}
