import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cardapio/modules/login/infra/models/user_model.dart';

class LoginHiveDatasource implements ILoggedUserDatasource {
  @override
  Future<User> getLoggedUser() async {
    await Future.delayed(const Duration(seconds: 2));

    return User(
        name: 'Vinicius Nunes', email: 'viny@gmail.com', phone: '19981436342');

    /*return Left(LoginError('Usuario ou senha invalido'));*/
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
