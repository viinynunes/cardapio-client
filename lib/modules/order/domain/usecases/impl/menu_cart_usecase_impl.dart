import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/order/domain/repositories/i_menu_cart_repository.dart';

import 'package:cardapio/modules/menu/errors/errors.dart';

import 'package:dartz/dartz.dart';

import '../i_menu_cart_usecase.dart';

class MenuCartUsecaseImpl implements IMenuCartUsecase {
  final IMenuCartRepository _repository;

  MenuCartUsecaseImpl(this._repository);

  @override
  Future<Either<MenuCartError, ItemMenu>> addItemToCart(ItemMenu itemMenu) async {
    if (itemMenu.name.isEmpty || itemMenu.description.isEmpty || itemMenu.imgUrl.isEmpty){
      return Left(MenuCartError('Invalid item menu'));
    }

    return _repository.addItemToCart(itemMenu);
  }

  @override
  Future<Either<MenuCartError, bool>> removeItemFromCart(
      ItemMenu itemMenu) async {
    if (itemMenu.name.isEmpty) {
      return Left(MenuCartError('Invalid menu item'));
    }

    return await _repository.removeItemFromCart(itemMenu);
  }

  @override
  Future<Either<MenuCartError, List<ItemMenu>>> getMenuCartList() async {
    return await _repository.getMenuCartList();
  }
}
