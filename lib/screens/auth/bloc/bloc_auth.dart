import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/dto/repositories.dart';
import 'package:github_api/dto/user.dart';
import 'package:github_api/repo/api/auth/repo_auth.dart';
import 'package:github_api/repo/api/users/base.dart';
import 'package:github_api/repo/local/login_storage/base_repo_login_storage.dart';
import 'package:github_api/repo/local/repo_shared_prefs.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_init.dart';

part 'parts/_login.dart';

part 'parts/_logout.dart';

class BlocAuth extends Bloc<AuthEvents, AuthStates> {
  BlocAuth({
    required this.repoLoginStorage,
    required this.repoSharedPrefs,
    required this.repoAuth,
    required this.repoUsers,
  }) : super(InitialAuthState()) {
    on<InitAuthEvent>(_init);
    on<LoginAuthEvent>(_login);
    on<LogoutAuthEvent>(_logout);
  }

  final BaseRepoLoginStorage repoLoginStorage;
  final BaseRepoUsers repoUsers;
  final RepoAuth repoAuth;
  final RepoSharedPrefs repoSharedPrefs;
}
