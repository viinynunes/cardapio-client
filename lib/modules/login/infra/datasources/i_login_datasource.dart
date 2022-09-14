import 'package:cardapio/modules/login/infra/models/client_model.dart';

abstract class ILoginDatasource {
  Future<ClientModel> login(String email, String password);

  Future<bool> logout();
}
