import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/domain/repositories/i_login_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

class MockLoginRepository implements ILoginRepository {
  @override
  Future<Either<LoginError, User>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(User(
        name: 'Vinicius Nunes', email: 'viny@gmail.com', phone: '19981436342'));

    /*return Left(LoginError('Usuario ou senha invalido'));*/
  }

  @override
  Future<Either<LoginError, User>> getLoggedUser() async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(User(
        name: 'Vinicius Nunes', email: 'viny@gmail.com', phone: '19981436342'));

    /*return Left(LoginError('Usuario ou senha invalido'));*/
  }
}
