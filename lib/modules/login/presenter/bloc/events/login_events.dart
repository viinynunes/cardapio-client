abstract class LoginEvents {}

class ClientLoginEvent implements LoginEvents {
  String email, password;

  ClientLoginEvent(this.email, this.password);
}

class ClientLogoutEvent implements LoginEvents {}
