import 'package:github_api/repo/local/login_storage/base_repo_login_storage.dart';

import '../repo_shared_prefs.dart';

class RepoLoginStorage implements BaseRepoLoginStorage {
  RepoLoginStorage({
    required this.sharedPrefs,
  });

  final RepoSharedPrefs sharedPrefs;

  @override
  String? read() {
    return sharedPrefs.storage.getString(_LoginFields.user);
  }

  @override
  Future<bool> update({String? userName}) {
    if (userName == null) {
      return sharedPrefs.storage.remove(
        _LoginFields.user,
      );
    } else {
      return sharedPrefs.storage.setString(
        _LoginFields.user,
        userName,
      );
    }
  }
}

abstract class _LoginFields {
  static const String user = "user_name";
}
