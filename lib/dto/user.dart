part 'package:github_api/repo/api/_converters/user.dart';

class User {
  String? login;
  String? avatar;
  String? htmlUrl;
  int? followers;
  String? name;

  User({
     this.login,
     this.avatar,
     this.htmlUrl,
     this.followers,
     this.name,
  });

  @override
  String toString() {
    return 'User{login: $login, avatar: $avatar, htmlUrl: $htmlUrl, followers: $followers, name: $name}';
  }
}
