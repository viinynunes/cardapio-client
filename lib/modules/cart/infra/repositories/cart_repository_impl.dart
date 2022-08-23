import 'package:cardapio/modules/cart/domain/repositories/i_cart_repository.dart';
import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:dartz/dartz.dart';

import '../../../menu/infra/models/item_menu_model.dart';
import '../datasources/i_cart_datasource.dart';

class CartRepositoryImpl implements ICartRepository {
  final ICartDatasource _cartDatasource;

  CartRepositoryImpl(this._cartDatasource);

  @override
  Future<Either<CartError, ItemMenu>> addItemToCart(ItemMenu itemMenu) async {
    try {
      final result = await _cartDatasource
          .addItemToCart(ItemMenuModel.fromItemMenu(itemMenu: itemMenu));

      return Right(result);
    } on CartError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartError(e.toString()));
    }
  }

  @override
  Future<Either<CartError, bool>> removeItemFromCart(ItemMenu itemMenu) async {
    try {
      final result =
          await _cartDatasource.removeItemFromCart(itemMenu as ItemMenuModel);
      return Right(result);
    } on CartError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartError(e.toString()));
    }
  }

  @override
  Future<Either<CartError, bool>> clearMenuCartList() async {
    try {
      final result = await _cartDatasource.clearMenuCartList();
      return Right(result);
    } on CartError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartError(e.toString()));
    }
  }

  @override
  Future<Either<CartError, List<ItemMenu>>> getMenuCartList() async {
    try {
      final result = await _cartDatasource.getMenuCartList();
      return Right(result);
    } on CartError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartError(e.toString()));
    }
  }
}
