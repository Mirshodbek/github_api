part of 'bloc_search.dart';

abstract class SearchEvent{}
class SearchUsersEvent extends SearchEvent{
  final String query;

  SearchUsersEvent(this.query);
}

class RepoUsersEvent extends SearchEvent{
  final String userName;

  RepoUsersEvent(this.userName);
}