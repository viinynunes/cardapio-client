import 'package:cardapio/modules/login/domain/entities/client.dart';
import 'package:cardapio/modules/login/domain/repositories/i_logged_client_repository.dart';
import 'package:cardapio/modules/login/errors/login_errors.dart';
import 'package:dartz/dartz.dart';

import '../i_logged_client_usecase.dart';

class LoggedClientUsecaseImpl implements ILoggedClientUsecase {
  final ILoggedClientRepository _repository;

  LoggedClientUsecaseImpl(this._repository);

  @override
  Future<Either<LoggedClientError, Client>> getLoggedUser() async {
    return _repository.getLoggedUser();
  }

  @override
  Future<Either<LoggedClientError, bool>> logout() {
    return _repository.logout();
  }
}
