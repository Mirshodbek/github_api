part of 'package:github_api/dto/user.dart';

extension UserConverterJson on User {
  User fromJson(dynamic data) {
    return User(
      login: data[_Fields.login],
      avatar: data[_Fields.avatar],
      htmlUrl: data[_Fields.htmlUrl],
      followers: data[_Fields.followers],
      name: data[_Fields.name],
    );
  }
}

abstract class _Fields {
  static const String name = "name";
  static const String login = "login";
  static const String avatar = "avatar_url";
  static const String htmlUrl = "html_url";
  static const String followers = "followers";
}
