import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';
import 'package:dartz/dartz.dart';

abstract class IMenuCartRepository {

  Future<Either<MenuCartError, ItemMenu>> addItemToCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, bool>> removeItemFromCart(ItemMenu itemMenu);

  Future<Either<MenuCartError, List<ItemMenu>>> getMenuCartList();
}