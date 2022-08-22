import 'dart:convert';

import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';

class ItemMenuModel extends ItemMenu {
  ItemMenuModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imgUrl,
    required super.weekdayList,
  });

  ItemMenuModel.fromItemMenu({required ItemMenu itemMenu})
      : super(
          id: itemMenu.id,
          name: itemMenu.name,
          description: itemMenu.description,
          imgUrl: itemMenu.imgUrl,
          weekdayList: itemMenu.weekdayList,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imgUrl': imgUrl,
      'weekdayList': weekdayList,
    };
  }

  ItemMenuModel fromMap(Map<String, dynamic> map) {
    return ItemMenuModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imgUrl: map['imgUrl'],
      weekdayList: map['weekdayList'],
    );
  }

  String toJson() => json.encode(toMap());

  ItemMenuModel fromJson(String source) => fromMap(json.decode(source));
}
