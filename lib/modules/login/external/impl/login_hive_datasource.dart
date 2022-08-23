import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cardapio/modules/login/infra/models/user_model.dart';

class LoginHiveDatasource implements ILoggedUserDatasource {
  @override
  Future<User> getLoggedUser() async {
    return UserModel(
        id: 'yb2x4yYNPOcvgIhvpNgWiMbKL293',
        name: 'Vinicius Nunes',
        email: 'viiny_nunes@hotmail.com',
        phone: '19981436342');
  }

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Future<UserModel> saveLoggedUser(UserModel user) async {
    return user;
  }
}
