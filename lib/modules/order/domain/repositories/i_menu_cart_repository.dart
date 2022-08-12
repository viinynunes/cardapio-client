import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

abstract class IMenuCartRepository {
  Future<Either<MenuCartError, ItemMenu>> addItemToCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, bool>> removeItemFromCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, bool>> clearMenuCartList();

  Future<Either<MenuCartError, List<ItemMenu>>> getMenuCartList();
}
