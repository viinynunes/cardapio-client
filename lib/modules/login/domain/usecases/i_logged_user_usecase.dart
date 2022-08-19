import 'package:dartz/dartz.dart';

import '../../errors/login_errors.dart';
import '../entities/user.dart';

abstract class ILoggedUserUsecase {
  Future<Either<LoginError, bool>> logout();

  Future<Either<LoginError, User>> getLoggedUser();
}
