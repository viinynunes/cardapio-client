import 'dart:math';

import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/domain/repository/i_menu_cart_repository.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';
import 'package:dartz/dartz.dart';

import 'i_menu_item_repository.dart';

class MockRepImpl implements IItemMenuRepository {
  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday) async {
    List<ItemMenu> menuList = [];

    for (int i = 1; i <= 50; i++) {
      final random = Random();
      menuList.add(
        ItemMenu(
            name: 'Carbo com Farinha Temperada e Batata Frita $i',
            description:
                'comida feita com o ingrediente de numero ${i * 35}, recheado com o molho de numero ${i * 17} e também temperado com ervas número ${i * 23}',
            imgUrl: 'https://portal.fgv.br/sites/portal.fgv.br/files/'
                'styles/noticia_geral/public/noticias/set/17/'
                'prato-feito.jpg?itok=klqGuxxN&c=33313733cdad61e4bd51beabb4a84531',
            weekdayList: [
              1 + random.nextInt(8 - 1),
              1 + random.nextInt(8 - 1),
            ]),
      );
    }

    final listPerDay = menuList
        .where((element) => element.weekdayList.contains(weekday.weekday))
        .toList();

    return Right(listPerDay);
  }
}

class MockRepMenuCartImpl implements IMenuCartRepository {
  List<ItemMenu> cartItemMenuList = [];

  static final MockRepMenuCartImpl _mockMenuRep =
      MockRepMenuCartImpl._internal();

  factory MockRepMenuCartImpl() {
    return _mockMenuRep;
  }

  MockRepMenuCartImpl._internal();

  @override
  Future<Either<MenuCartError, ItemMenu>> addItemToCart(
      ItemMenu itemMenu) async {
    cartItemMenuList.add(itemMenu);

    return Right(itemMenu);
  }

  @override
  Future<Either<MenuCartError, bool>> removeItemFromCart(
      ItemMenu itemMenu) async {
    final result = cartItemMenuList.remove(itemMenu);

    if (result == false) {
      return Left(MenuCartError('Error removing item menu from cart'));
    }

    return Right(result);
  }

  @override
  Future<Either<MenuCartError, List<ItemMenu>>> getMenuCartList() async {
    return Right(cartItemMenuList);
  }
}
