import 'package:github_api/dto/error.dart';
import 'package:github_api/dto/user.dart';
import 'package:github_api/features/app_logger.dart';
import 'package:github_api/repo/api.dart';
import 'package:github_api/repo/api/auth/base.dart';
import 'package:github_api/l10n/generated/l10n.dart';

class RepoAuth implements BaseRepoAuth {
  RepoAuth({required this.api});

  final Api api;

  @override
  Future<ResultRepoAuth> login(String userName) async {
    try {
      final result = await api.dio.get('/users/$userName');
      return ResultRepoAuth(
        user: User().fromJson(result.data),
      );
    } catch (error) {
      AppLogger.log(error);
      return ResultRepoAuth(
        error: AppError(message: S.current.noAccount),
      );
    }
  }
}
