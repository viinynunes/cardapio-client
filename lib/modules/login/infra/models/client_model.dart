import 'dart:convert';

import 'package:cardapio/modules/login/domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.phone});

  ClientModel.fromClient({required Client client})
      : super(
            id: client.id, name: client.name, email: client.email, phone: client.phone);

  static ClientModel fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }

  String toJson() => json.encode(toMap());

  static ClientModel fromJson(String source) => fromMap(json.decode(source));
}
