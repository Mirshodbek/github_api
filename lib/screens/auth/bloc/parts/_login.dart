part of '../bloc_auth.dart';

extension Login on BlocAuth {
  Future<void> _login(
    LoginAuthEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(LoginAuthState(loading: true));
    final result = await repoAuth.login(event.userName);
    if (result.error != null) {
      emit(LoginAuthState(message: result.error?.message, loading: false));
      return;
    }
    final resultRepo = await repoUsers.getRepositories(event.userName);
    if (resultRepo.error != null) {
      emit(LoginAuthState(message: resultRepo.error?.message));
      return;
    }
    await repoLoginStorage.update(userName: event.userName);
    emit(
      AuthorizedAuthState(
        user: result.user,
        repositories: resultRepo.repositories,
      ),
    );
    return;
  }
}
