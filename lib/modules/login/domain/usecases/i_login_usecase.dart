import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

abstract class ILoginUsecase {
  Future<Either<LoginError, User>> login(String email, String password);

  Future<Either<LoginError, User>> getLoggedUser();
}
