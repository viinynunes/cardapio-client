import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/login/errors/login_errors.dart';

abstract class LoggedUserStates {}

class LoggedUserIdleState implements LoggedUserStates {}

class LoggedUserLoadingState implements LoggedUserStates {}

class LoggedUserSuccessState implements LoggedUserStates {
  User user;

  LoggedUserSuccessState(this.user);
}

class LoggedUserErrorState implements LoggedUserStates {
  final LoggedUserError error;

  LoggedUserErrorState(this.error);
}
