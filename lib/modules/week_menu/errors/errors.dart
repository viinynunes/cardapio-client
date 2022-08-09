class GetMenuError implements Exception {
  String message;

  GetMenuError(this.message);
}

class GetDaysOfWeekError implements Exception {
  String message;

  GetDaysOfWeekError(this.message);
}

class MenuCartError implements Exception {
  String message;

  MenuCartError(this.message);
}

class LoginError implements Exception {
  String message;

  LoginError(this.message);
}