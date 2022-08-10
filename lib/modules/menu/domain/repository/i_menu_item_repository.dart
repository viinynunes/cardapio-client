import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

abstract class IItemMenuRepository {
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(Weekday weekday);
}
