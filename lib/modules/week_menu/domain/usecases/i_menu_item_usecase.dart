import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';
import 'package:dartz/dartz.dart';

abstract class IItemMenuUsecase {
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday);
}
