import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/menu/infra/datasources/i_item_menu_datasource.dart';
import 'package:cardapio/modules/menu/infra/models/item_menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemMenuFirebaseDatasource implements IItemMenuDatasource {
  final _menuCollection = FirebaseFirestore.instance.collection('menu');

  @override
  Future<List<ItemMenuModel>> getItemMenuByDay(Weekday weekday) async {
    List<ItemMenuModel> menuList = [];

    final result = await _menuCollection
        .where('enabled', isEqualTo: true)
        .where('weekdayList', arrayContains: weekday.weekday)
        .get();

    for (var index in result.docs) {
      menuList.add(ItemMenuModel.fromMap(map: index.data()));
    }

    return menuList;
  }
}
