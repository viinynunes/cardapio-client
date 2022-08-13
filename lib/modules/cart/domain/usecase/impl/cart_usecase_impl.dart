import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/cart/domain/repositories/i_cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';
import '../i_cart_usecase.dart';

class CartUsecaseImpl implements ICartUsecase {
  final ICartRepository _repository;

  CartUsecaseImpl(this._repository);

  @override
  Future<Either<CartError, ItemMenu>> addItemToCart(
      ItemMenu itemMenu) async {
    if (itemMenu.name.isEmpty ||
        itemMenu.description.isEmpty ||
        itemMenu.imgUrl.isEmpty) {
      return Left(CartError('Invalid item menu'));
    }

    return _repository.addItemToCart(itemMenu);
  }

  @override
  Future<Either<CartError, bool>> removeItemFromCart(
      ItemMenu itemMenu) async {
    if (itemMenu.name.isEmpty) {
      return Left(CartError('Invalid menu item'));
    }

    return await _repository.removeItemFromCart(itemMenu);
  }

  @override
  Future<Either<CartError, bool>> clearMenuCartList() async {
    return await _repository.clearMenuCartList();
  }

  @override
  Future<Either<CartError, List<ItemMenu>>> getMenuCartList() async {
    return await _repository.getMenuCartList();
  }
}
