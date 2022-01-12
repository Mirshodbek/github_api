part of '../bloc_auth.dart';

extension Logout on BlocAuth{
  Future<void> _logout(
      LogoutAuthEvent event,
      Emitter<AuthStates> emit,
      ) async {
    await repoLoginStorage.update();
    emit(LoginAuthState());
    return;
  }
}