import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/domain/repository/i_menu_item_repository.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_menu_item_usecase.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';
import 'package:dartz/dartz.dart';

class ItemMenuUsecaseImpl implements IItemMenuUsecase {
  final IItemMenuRepository _repository;

  ItemMenuUsecaseImpl(this._repository);

  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday) async {
    if (weekday.weekday <= 0 || weekday.weekday > 7) {
      return Left(GetMenuError('Invalid Weekday'));
    }

    return _repository.getItemMenuByDay(weekday);
  }
}