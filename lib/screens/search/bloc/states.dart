part of 'bloc_search.dart';

class SearchState {
  final List<User>? users;
  final String? error;
  final String? errorRepo;
  final bool loading;
  final List<Repositories>? repositories;

  SearchState({
    this.loading = false,
    this.users,
    this.error,
    this.errorRepo,
    this.repositories,
  });

  SearchState copyWith({
    List<User>? users,
    String? error,
    String? errorRepo,
    bool? loading,
    List<Repositories>? repositories,
  }) {
    return SearchState(
      users: users ?? this.users,
      error: error ?? this.error,
      errorRepo: errorRepo ?? this.errorRepo,
      loading: loading ?? this.loading,
      repositories: repositories ?? this.repositories,
    );
  }

  @override
  String toString() {
    return 'SearchState{users: $users, error: $error, errorRepo: $errorRepo, loading: $loading, repositories: $repositories}';
  }
}
