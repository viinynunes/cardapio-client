import 'package:cardapio/modules/login/infra/models/client_model.dart';

import '../../domain/entities/client.dart';

abstract class ILoggedClientDatasource {
  Future<Client> getLoggedClient();

  Future<ClientModel> saveLoggedClient(ClientModel user);

  Future<bool> logout();
}
