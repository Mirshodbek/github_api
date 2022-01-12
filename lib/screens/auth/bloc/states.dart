part of 'bloc_auth.dart';

abstract class AuthStates {}

class InitialAuthState extends AuthStates {}

class LoginAuthState extends AuthStates {
  final String? message;
  final bool loading;

  LoginAuthState({this.message, this.loading = false});
}

class AuthorizedAuthState extends AuthStates {
  final User? user;
  final List<Repositories>? repositories;

  AuthorizedAuthState({
    this.user,
    this.repositories,
  });
}
