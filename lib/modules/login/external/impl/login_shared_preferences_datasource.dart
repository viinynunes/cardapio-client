import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cardapio/modules/login/infra/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreferencesDatasource implements ILoggedUserDatasource {
  @override
  Future<UserModel> getLoggedUser() async {
    final userPref = await SharedPreferences.getInstance();

    return UserModel.fromJson(userPref.get('user') as String);
  }

  @override
  Future<bool> logout() async {
    final userPref = await SharedPreferences.getInstance();

    await userPref.remove('user');

    return true;
  }

  @override
  Future<UserModel> saveLoggedUser(UserModel user) async {
    final userPref = await SharedPreferences.getInstance();

    await userPref.setString('user', user.toJson());

    final recUser = UserModel.fromJson(userPref.get('user') as String);

    return recUser;
  }
}
