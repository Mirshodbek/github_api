part of 'bloc_auth.dart';

abstract class AuthEvents {}

class InitAuthEvent extends AuthEvents {}

class LoginAuthEvent extends AuthEvents {
  final String userName;

  LoginAuthEvent(this.userName);
}

class LogoutAuthEvent extends AuthEvents {}

