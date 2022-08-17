class LoginError implements Exception {
  String message;

  LoginError(this.message);
}

class DataSourceError extends LoginError {
  DataSourceError(super.message);
}
