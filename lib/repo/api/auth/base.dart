import 'package:github_api/dto/error.dart';
import 'package:github_api/dto/user.dart';

abstract class BaseRepoAuth {
  Future<ResultRepoAuth> login(String userName);
}

class ResultRepoAuth {
  ResultRepoAuth({
    this.error,
    this.user,
  });

  final AppError? error;
  final User? user;

  @override
  String toString() => 'ResultRepoAuth(error: $error, user: $user)';
}
