import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/domain/repositories/i_logged_user_repository.dart';
import 'package:cardapio/modules/login/errors/login_errors.dart';
import 'package:dartz/dartz.dart';

import '../i_logged_user_usecase.dart';

class LoggedUserUsecaseImpl implements ILoggedUserUsecase {
  final ILoggedUserRepository _repository;

  LoggedUserUsecaseImpl(this._repository);

  @override
  Future<Either<LoginError, User>> getLoggedUser() async {
    return _repository.getLoggedUser();
  }

  @override
  Future<Either<LoginError, bool>> logout() {
    throw UnimplementedError();
  }
}
