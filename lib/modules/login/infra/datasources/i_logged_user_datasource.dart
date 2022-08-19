import '../../domain/entities/user.dart';

abstract class ILoggedUserDatasource {
  Future<User> getLoggedUser();

  Future<bool> logout();
}
