import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/errors/login_errors.dart';

abstract class LoginStates {}

class LoginIdleState implements LoginStates {}

class LoginLoadingState implements LoginStates {}

class LoginSuccessState implements LoginStates {
  User user;

  LoginSuccessState(this.user);
}

class LoginLogoutSuccessState implements LoginStates {}

class LoginErrorState implements LoginStates {
  final LoginError error;

  LoginErrorState(this.error);
}
