import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/cart/domain/usecase/i_cart_usecase.dart';
import 'package:cardapio/modules/cart/presenter/bloc/events/cart_events.dart';
import 'package:cardapio/modules/cart/presenter/bloc/states/cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  final ICartUsecase cartUsecase;

  CartBloc(this.cartUsecase) : super(CartInitialState()) {
    on<GetCartListEvent>((event, emit) async {
      emit(CartLoadingState());

      final result = await cartUsecase.getMenuCartList();

      result.fold((l) {
        emit(CartErrorState(l));
      }, (r) {
        emit(CartGetCartListSuccessState(r));
      });
    });

    on<AddItemToCartEvent>((event, emit) async {
      emit(CartLoadingState());

      final result = await cartUsecase.addItemToCart(event.itemMenu);

      result.fold((l) {
        emit(CartErrorState(l));
      }, (r) {
        emit(CartAddItemSuccessState(r));
      });
    });

    on<RemoveItemFromCartEvent>((event, emit) async {
      emit(CartLoadingState());

      final result = await cartUsecase.removeItemFromCart(event.item);

      Future.delayed(const Duration(seconds: 1));

      result.fold((l) {
        emit(CartErrorState(l));
      }, (r) {});
    });
  }
}
