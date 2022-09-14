import 'package:cardapio/modules/login/domain/entities/client.dart';
import 'package:dartz/dartz.dart';

import '../../errors/login_errors.dart';

abstract class ILoginRepository {
  Future<Either<LoginError, Client>> login(String email, String password);

  Future<Either<LoginError, bool>> logout();
}
