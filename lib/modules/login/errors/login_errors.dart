class LoginError implements Exception {
  String message;

  LoginError(this.message);
}

class LoggedClientError implements Exception {
  final String message;

  LoggedClientError(this.message);
}

class DataSourceError extends LoginError {
  DataSourceError(super.message);
}
