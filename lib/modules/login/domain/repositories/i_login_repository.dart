import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/menu/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class ILoginRepository {
  Future<Either<LoginError, User>> login(String email, String password);
}
