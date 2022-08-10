import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/menu/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class IMenuCartUsecase {

  Future<Either<MenuCartError, ItemMenu>> addItemToCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, bool>> removeItemFromCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, List<ItemMenu>>> getMenuCartList();
}