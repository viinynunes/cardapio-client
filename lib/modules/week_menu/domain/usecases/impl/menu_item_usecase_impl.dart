import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/week_menu/domain/repository/i_menu_item_repository.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_menu_item_usecase.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';
import 'package:dartz/dartz.dart';

class ItemMenuUsecaseImpl implements IItemMenuUsecase {
  final IItemMenuRepository _repository;

  ItemMenuUsecaseImpl(this._repository);

  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      DateTime dateTime) async {
    if (dateTime.weekday <= 0 || dateTime.weekday > 7) {
      return Left(GetMenuError('Invalid Weekday'));
    }

    return _repository.getItemMenuByDay(dateTime);
  }
}