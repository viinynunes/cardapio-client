import 'dart:convert';

import 'package:cardapio/modules/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.phone});

  UserModel.fromUser({required User user})
      : super(
            id: user.id, name: user.name, email: user.email, phone: user.phone);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserModel fromJson(String source) => fromMap(json.decode(source));
}
