import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class IItemMenuUsecase {
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday);
}
