part of '../bloc_auth.dart';

extension Init on BlocAuth {
  Future<void> _init(
    InitAuthEvent event,
    Emitter<AuthStates> emit,
  ) async {
    await repoSharedPrefs.init();
    final userName = repoLoginStorage.read();
    if (userName == null) {
      emit(LoginAuthState());
      return;
    }
    final result = await repoAuth.login(userName);
    if (result.error != null) {
      emit(LoginAuthState(message: result.error?.message));
      return;
    }
    final resultRepo = await repoUsers.getRepositories(userName);
    if (resultRepo.error != null) {
      emit(LoginAuthState(message: resultRepo.error?.message));
      return;
    }
    emit(
      AuthorizedAuthState(
        user: result.user,
        repositories: resultRepo.repositories,
      ),
    );
    return;
  }
}
