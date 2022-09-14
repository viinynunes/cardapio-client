import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:cardapio/modules/login/infra/models/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreferencesDatasource implements ILoggedClientDatasource {
  @override
  Future<ClientModel> getLoggedClient() async {
    final clientPref = await SharedPreferences.getInstance();

    return ClientModel.fromJson(clientPref.get('client') as String);
  }

  @override
  Future<bool> logout() async {
    final clientPref = await SharedPreferences.getInstance();

    await clientPref.remove('client');

    return true;
  }

  @override
  Future<ClientModel> saveLoggedClient(ClientModel client) async {
    final clientPref = await SharedPreferences.getInstance();

    await clientPref.setString('client', client.toJson());

    final recClient = ClientModel.fromJson(clientPref.get('client') as String);

    return recClient;
  }
}
