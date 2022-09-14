import 'package:cardapio/modules/login/domain/entities/client.dart';
import 'package:cardapio/modules/login/errors/login_errors.dart';

abstract class LoggedClientStates {}

class LoggedClientIdleState implements LoggedClientStates {}

class LoggedClientLoadingState implements LoggedClientStates {}

class LoggedClientSuccessState implements LoggedClientStates {
  Client user;

  LoggedClientSuccessState(this.user);
}

class LoggedClientErrorState implements LoggedClientStates {
  final LoggedClientError error;

  LoggedClientErrorState(this.error);
}
