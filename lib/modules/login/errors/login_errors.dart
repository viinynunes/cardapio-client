class LoginError implements Exception {
  String message;

  LoginError(this.message);
}

class LoggedUserError implements Exception {
  final String message;

  LoggedUserError(this.message);
}

class DataSourceError extends LoginError {
  DataSourceError(super.message);
}
