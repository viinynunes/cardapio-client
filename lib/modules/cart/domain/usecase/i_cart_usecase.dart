import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

abstract class ICartUsecase {
  Future<Either<CartError, ItemMenu>> addItemToCart(ItemMenu itemMenu);

  Future<Either<CartError, bool>> removeItemFromCart(ItemMenu itemMenu);

  Future<Either<CartError, bool>> clearMenuCartList();

  Future<Either<CartError, List<ItemMenu>>> getMenuCartList();
}
