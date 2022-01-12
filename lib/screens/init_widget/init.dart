import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/repo/api.dart';
import 'package:github_api/repo/api/auth/repo_auth.dart';
import 'package:github_api/repo/api/users/repo_users.dart';
import 'package:github_api/repo/local/login_storage/repo_login_storage.dart';
import 'package:github_api/repo/local/repo_shared_prefs.dart';
import 'package:github_api/screens/auth/bloc/bloc_auth.dart';

class InitWidget extends StatelessWidget {
  InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  final api = Api();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: api,
        ),
        RepositoryProvider(
          create: (context) => RepoSharedPrefs(),
        ),
        RepositoryProvider(
          create: (context) => RepoAuth(
            api: RepositoryProvider.of<Api>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => RepoUsers(
            api: RepositoryProvider.of<Api>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => RepoLoginStorage(
            sharedPrefs: RepositoryProvider.of<RepoSharedPrefs>(context),
          ),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BlocAuth(
                repoUsers:  RepositoryProvider.of<RepoUsers>(context),
                repoSharedPrefs:
                    RepositoryProvider.of<RepoSharedPrefs>(context),
                repoLoginStorage:
                    RepositoryProvider.of<RepoLoginStorage>(context),
                repoAuth: RepositoryProvider.of<RepoAuth>(context),
              )..add(InitAuthEvent()),
            ),
          ],
          child: Builder(
            builder: (context) {
              return child;
            },
          ),
        );
      }),
    );
  }
}
