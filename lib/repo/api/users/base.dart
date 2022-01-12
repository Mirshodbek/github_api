import 'package:github_api/dto/error.dart';
import 'package:github_api/dto/repositories.dart';
import 'package:github_api/dto/user.dart';

abstract class BaseRepoUsers {
  Future<ResultRepoUsers> getUsers(String query);
  Future<ResultRepoUsers> getRepositories(String userName);
}

class ResultRepoUsers {
  ResultRepoUsers({
    this.error,
    this.users,
    this.repositories,
  });

  final AppError? error;
  final List<User>? users;
  final List<Repositories>? repositories;

  @override
  String toString() =>
      'ResultRepoAuth(error: $error, users: $users, repositories: $repositories)';
}
