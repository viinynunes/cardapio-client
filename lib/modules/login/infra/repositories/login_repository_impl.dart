import 'package:cardapio/modules/login/errors/login_errors.dart';
import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/domain/repositories/i_login_repository.dart';
import 'package:cardapio/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginDatasource _datasource;

  LoginRepositoryImpl(this._datasource);

  @override
  Future<Either<LoginError, User>> login(String email, String password) async {
    try {
      final result = await _datasource.login(email, password);
      return Right(result);
    } on LoginError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoginError('Uncaught exception'));
    }
  }

  @override
  Future<Either<LoginError, User>> getLoggedUser() async {
    try {
      final result = await _datasource.getLoggedUser();

      return Right(result);
    } on LoginError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LoginError('Uncaught Exception'));
    }
  }
}
