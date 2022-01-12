abstract class BaseRepoLoginStorage {
  Future<bool> update({String? userName});

  String? read();
}
