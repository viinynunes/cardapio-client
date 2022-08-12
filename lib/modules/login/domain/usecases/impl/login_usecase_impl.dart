import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/domain/repositories/i_login_repository.dart';
import 'package:cardapio/modules/login/domain/usecases/i_login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../../../../errors/errors.dart';

class LoginUsecaseImpl implements ILoginUsecase {
  final ILoginRepository _repository;

  LoginUsecaseImpl(this._repository);

  @override
  Future<Either<LoginError, User>> login(String email, String password) async {
    if (!isEmail(email)) {
      return Left(LoginError('Invalid email'));
    }

    if (password.length < 6) {
      return Left(LoginError('Password cannot be less then 6 characters'));
    }

    return _repository.login(email, password);
  }

  @override
  Future<Either<LoginError, User>> getLoggedUser() async {
    return _repository.getLoggedUser();
  }
}
