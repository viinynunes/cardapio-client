import 'package:dartz/dartz.dart';

import '../../errors/login_errors.dart';
import '../entities/client.dart';

abstract class ILoggedClientRepository {
  Future<Either<LoggedClientError, bool>> logout();

  Future<Either<LoggedClientError, Client>> getLoggedUser();
}
