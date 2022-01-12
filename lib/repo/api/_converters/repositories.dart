part of 'package:github_api/dto/repositories.dart';

extension RepositoriesConverterJson on Repositories {
  Repositories fromJson(dynamic data) {
    return Repositories(
      name: data[_Fields.name],
      description: data[_Fields.description],
      updatedAt: DateTime.tryParse(
        data[_Fields.updatedAt],
      ),
      defaultBranch: data[_Fields.defaultBranch],
      forksCount: data[_Fields.forksCount],
      stargazersCount: data[_Fields.stargazersCount],
    );
  }
}

abstract class _Fields {
  static const String name = "name";
  static const String description = "description";
  static const String updatedAt = "updated_at";
  static const String defaultBranch = "default_branch";
  static const String forksCount = "forks_count";
  static const String stargazersCount = "stargazers_count";
}
