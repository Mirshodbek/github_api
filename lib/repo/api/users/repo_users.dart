import 'package:github_api/dto/error.dart';
import 'package:github_api/dto/repositories.dart';
import 'package:github_api/dto/user.dart';
import 'package:github_api/features/app_logger.dart';
import 'package:github_api/repo/api.dart';
import 'package:github_api/repo/api/users/base.dart';
import 'package:github_api/l10n/generated/l10n.dart';

class RepoUsers implements BaseRepoUsers {
  RepoUsers({required this.api});

  final Api api;

  @override
  Future<ResultRepoUsers> getUsers(String query) async {
    try {
      final result = await api.dio.get('/search/users?q=$query');
      final jsonList = result.data[_Fields.items] ?? [];
      final users = jsonList
          .map<User>(
            User().fromJson,
          )
          .toList();
      return ResultRepoUsers(
        users: users,
      );
    } catch (error) {
      AppLogger.log(error);
      return ResultRepoUsers(
        error: AppError(message: S.current.errorGeneral),
      );
    }
  }

  @override
  Future<ResultRepoUsers> getRepositories(String userName) async {
    try {
      final result = await api.dio.get("/users/$userName/repos");
      final jsonList = result.data ?? [];
      final repositories = jsonList
          .map<Repositories>(
            Repositories().fromJson,
          )
          .toList();
      return ResultRepoUsers(
        repositories: repositories,
      );
    } catch (error) {
      AppLogger.log(error);
      return ResultRepoUsers(
        error: AppError(message: S.current.errorGeneral),
      );
    }
  }
}

abstract class _Fields {
  static const String items = "items";
}
