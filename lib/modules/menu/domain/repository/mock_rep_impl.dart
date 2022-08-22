import 'dart:math';

import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';
import 'i_menu_item_repository.dart';

class MockItemMenuRepository implements IItemMenuRepository {
  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday) async {
    List<ItemMenu> menuList = [];

    for (int i = 1; i <= 50; i++) {
      final random = Random();
      menuList.add(
        ItemMenu(
            id: 'id',
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
