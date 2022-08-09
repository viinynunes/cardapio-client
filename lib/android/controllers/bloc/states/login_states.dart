import 'package:cardapio/modules/login/domain/entities/user.dart';

abstract class LoginStates {}

class LoginIdleState implements LoginStates {}

class LoginLoadingState implements LoginStates {}

class LoginSuccessState implements LoginStates {
  User user;

  LoginSuccessState(this.user);
}

class LoginErrorState implements LoginStates {
  final String message;

  LoginErrorState(this.message);
}
