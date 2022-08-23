import '../../../menu/infra/models/item_menu_model.dart';

abstract class ICartDatasource {
  Future<ItemMenuModel> addItemToCart(ItemMenuModel item);

  Future<bool> removeItemFromCart(ItemMenuModel item);

  Future<bool> clearMenuCartList();

  Future<List<ItemMenuModel>> getMenuCartList();
}
