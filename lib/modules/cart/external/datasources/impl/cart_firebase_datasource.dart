import 'package:cardapio/modules/login/domain/entities/client.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../menu/infra/models/item_menu_model.dart';
import '../../../infra/datasources/i_cart_datasource.dart';

class CartFirebaseDatasource implements ICartDatasource {
  final ILoggedClientDatasource _loggedUserDatasource;

  late Client user;

  CartFirebaseDatasource(this._loggedUserDatasource);

  final _userCollection = FirebaseFirestore.instance.collection('clients');

  @override
  Future<ItemMenuModel> addItemToCart(ItemMenuModel item) async {
    final client = await _getLoggedUser();

    _userCollection
        .doc(client.id)
        .collection('cart')
        .add(item.toMap())
        .then((value) {
      item.id = value.id;
      _userCollection
          .doc(client.id)
          .collection('cart')
          .doc(value.id)
          .update(item.toMap());
    });

    return item;
  }

  @override
  Future<bool> removeItemFromCart(ItemMenuModel item) async {
    final client = await _getLoggedUser();

    await _userCollection.doc(client.id).collection('cart').doc(item.id).delete();

    return true;
  }

  @override
  Future<bool> clearMenuCartList() async {
    final client = await _getLoggedUser();

    final cartList =
        await _userCollection.doc(client.id).collection('cart').get();

    for (var doc in cartList.docs) {
      await doc.reference.delete();
    }

    return true;
  }

  @override
  Future<List<ItemMenuModel>> getMenuCartList() async {
    List<ItemMenuModel> cartList = [];

    final client = await _getLoggedUser();

    final result = await _userCollection.doc(client.id).collection('cart').get();

    for (var e in result.docs) {
      cartList.add(ItemMenuModel.fromMap(map: e.data()));
    }

    return cartList;
  }

  Future<Client> _getLoggedUser() async {
    return await _loggedUserDatasource.getLoggedClient();
  }
}
