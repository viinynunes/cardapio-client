import 'package:cardapio/modules/login/infra/models/user_model.dart';

import '../../domain/entities/user.dart';

abstract class ILoggedUserDatasource {
  Future<User> getLoggedUser();

  Future<UserModel> saveLoggedUser(UserModel user);

  Future<bool> logout();
}
