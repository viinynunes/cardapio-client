import 'package:cardapio/modules/cart/infra/models/item_menu_model.dart';
import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../infra/datasources/i_cart_datasource.dart';

class CartFirebaseDatasource implements ICartDatasource {
  final ILoggedUserDatasource _loggedUserDatasource;

  late User user;

  CartFirebaseDatasource(this._loggedUserDatasource);

  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<ItemMenuModel> addItemToCart(ItemMenuModel item) async {
    final user = await _getLoggedUser();

    _userCollection
        .doc(user.id)
        .collection('cart')
        .add(item.toMap())
        .then((value) => item.id = value.id);

    return item;
  }

  @override
  Future<bool> removeItemFromCart(ItemMenuModel item) {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }

  @override
  Future<bool> clearMenuCartList() {
    // TODO: implement clearMenuCartList
    throw UnimplementedError();
  }

  @override
  Future<List<ItemMenuModel>> getMenuCartList() async {
    List<ItemMenuModel> cartList = [];

    final user = await _getLoggedUser();

    final result = await _userCollection.doc(user.id).collection('cart').get();

    for (var e in result.docs) {
      cartList.add(ItemMenuModel.fromMap(map: e.data()));
    }

    return cartList;
  }

  Future<User> _getLoggedUser() async {
    return await _loggedUserDatasource.getLoggedUser();
  }
}
