abstract class LoginEvents {}

class UserLoginEvent implements LoginEvents {
  String email, password;

  UserLoginEvent(this.email, this.password);
}
