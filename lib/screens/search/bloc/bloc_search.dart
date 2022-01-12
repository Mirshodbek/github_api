import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/dto/repositories.dart';
import 'package:github_api/dto/user.dart';
import 'package:github_api/repo/api/users/base.dart';

part 'events.dart';

part 'states.dart';

class BlocSearch extends Bloc<SearchEvent, SearchState> {
  BlocSearch({
    required this.repoUsers,
  }) : super(SearchState()) {
    on<SearchUsersEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      final result = await repoUsers.getUsers(event.query);
      if (result.error != null) {
        emit(state.copyWith(error: result.error?.message, loading: false));
        return;
      }
      emit(state.copyWith(users: result.users, loading: false));
      return;
    });

    on<RepoUsersEvent>((event, emit) async {
      final result = await repoUsers.getRepositories(event.userName);
      if (result.error != null) {
        emit(state.copyWith(errorRepo: result.error?.message));
        return;
      }
      emit(state.copyWith(repositories: result.repositories));
      return;
    });
  }

  final BaseRepoUsers repoUsers;
}
