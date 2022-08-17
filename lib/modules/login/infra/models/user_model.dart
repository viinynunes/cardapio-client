import 'dart:convert';

import 'package:cardapio/modules/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel(String name, String email, String phone)
      : super(email: email, name: name, phone: phone);

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone};
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(map['name'], map['email'], map['phone']);
  }

  String toJson() => json.encode(toMap());

  UserModel fromJson(String source) => fromMap(json.decode(source));
}
