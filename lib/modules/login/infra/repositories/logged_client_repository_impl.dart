import 'package:cardapio/modules/login/domain/repositories/i_logged_client_repository.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/client.dart';
import '../../errors/login_errors.dart';

class LoggedClientRepositoryImpl implements ILoggedClientRepository {
  final ILoggedClientDatasource _datasource;

  LoggedClientRepositoryImpl(this._datasource);

  @override
  Future<Either<LoggedClientError, Client>> getLoggedUser() async {
    try {
      final result = await _datasource.getLoggedClient();

      return Right(result);
    } on LoggedClientError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoggedClientError('Uncaught Exception'));
    }
  }

  @override
  Future<Either<LoggedClientError, bool>> logout() async {
    try {
      final result = await _datasource.logout();

      return Right(result);
    } on LoggedClientError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoggedClientError('Uncaught Exception'));
    }
  }
}
