import 'package:cardapio/modules/login/domain/repositories/i_logged_user_repository.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../errors/login_errors.dart';

class LoggedUserRepositoryImpl implements ILoggedUserRepository {
  final ILoggedUserDatasource _datasource;

  LoggedUserRepositoryImpl(this._datasource);

  @override
  Future<Either<LoggedUserError, User>> getLoggedUser() async {
    try {
      final result = await _datasource.getLoggedUser();

      return Right(result);
    } on LoggedUserError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoggedUserError('Uncaught Exception'));
    }
  }

  @override
  Future<Either<LoggedUserError, bool>> logout() async {
    try {
      final result = await _datasource.logout();

      return Right(result);
    } on LoggedUserError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoggedUserError('Uncaught Exception'));
    }
  }
}
