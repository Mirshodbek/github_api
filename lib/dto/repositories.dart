part 'package:github_api/repo/api/_converters/repositories.dart';

class Repositories {
  final String? name;
  final String? description;
  final DateTime? updatedAt;
  final String? defaultBranch;
  final int? forksCount;
  final int? stargazersCount;

  Repositories({
    this.name,
    this.description,
    this.updatedAt,
    this.defaultBranch,
    this.forksCount,
    this.stargazersCount,
  });
}
