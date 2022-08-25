import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/menu/domain/repository/i_menu_item_repository.dart';
import 'package:cardapio/modules/menu/infra/datasources/i_item_menu_datasource.dart';
import 'package:dartz/dartz.dart';

class ItemMenuRepositoryImpl implements IItemMenuRepository {
  final IItemMenuDatasource _datasource;

  ItemMenuRepositoryImpl(this._datasource);

  @override
  Future<Either<GetMenuError, List<ItemMenu>>> getItemMenuByDay(
      Weekday weekday) async {
    try {
      final result = await _datasource.getItemMenuByDay(weekday);

      return Right(result);
    } on GetMenuError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GetMenuError(e.toString()));
    }
  }
}
