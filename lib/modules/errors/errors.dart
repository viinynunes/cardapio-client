class GetMenuError implements Exception {
  String message;

  GetMenuError(this.message);
}

class GetDaysOfWeekError implements Exception {
  String message;

  GetDaysOfWeekError(this.message);
}

class CartError implements Exception {
  String message;

  CartError(this.message);
}

class LoginError implements Exception {
  String message;

  LoginError(this.message);
}

class OrderError implements Exception {
  String message;

  OrderError(this.message);
}
