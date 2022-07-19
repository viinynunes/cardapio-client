import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';

import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';

import 'package:dartz/dartz.dart';

import 'i_menu_item_repository.dart';

class MockRepImpl implements IItemMenuRepository {
  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      DateTime dateTime) async {
    List<ItemMenu> menuList = [];

    for (int i = 1; i <= 100; i++) {
      menuList.add(
        ItemMenu(
            'Arroz com Feijão e Batata Frita $i',
            'comida feita com o ingrediente de numero ${i * 35}, recheado com o molho de numero ${i * 17} e também temperado com ervas número ${i * 23}',
            'https://portal.fgv.br/sites/portal.fgv.br/files/'
                'styles/noticia_geral/public/noticias/set/17/'
                'prato-feito.jpg?itok=klqGuxxN&c=33313733cdad61e4bd51beabb4a84531'),
      );
    }

    return Right(menuList);
  }
}
