import 'package:dartz/dartz.dart';

import '../../errors/login_errors.dart';
import '../entities/user.dart';

abstract class ILoggedUserUsecase {
  Future<Either<LoggedUserError, bool>> logout();

  Future<Either<LoggedUserError, User>> getLoggedUser();
}
