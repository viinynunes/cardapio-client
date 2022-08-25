import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/menu/infra/models/item_menu_model.dart';

abstract class IItemMenuDatasource {
  Future<List<ItemMenuModel>> getItemMenuByDay(Weekday weekday);
}
