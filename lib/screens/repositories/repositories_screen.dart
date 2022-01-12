import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/l10n/generated/l10n.dart';
import 'package:github_api/main.dart';
import 'package:github_api/screens/search/bloc/bloc_search.dart';
import 'package:intl/intl.dart';

class RepositoryScreen extends StatelessWidget {
  const RepositoryScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${S.of(context).repositories} $userName"),
      ),
      body: BlocConsumer<BlocSearch, SearchState>(
        listener: (context, state) {
          if (state.errorRepo != null) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(
                  state.errorRepo!,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (state.repositories?.isNotEmpty ?? false)
                  for (int i = 0; i < (state.repositories?.length ?? 0); i++)
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        leading: Text("${i + 1})"),
                        trailing: Column(
                          children: [
                            Text(
                              "forks: ${state.repositories?[i].forksCount}",
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "stars: ${state.repositories?[i].stargazersCount}",
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "branch: ${state.repositories?[i].defaultBranch}"),
                            const Divider(
                              height: 24,
                              color: Colors.grey,
                              thickness: 2,
                            ),
                            Text(
                              "${S.of(context).description}:\n${state.repositories?[i].description}",
                            )
                          ],
                        ),
                        title: Text(
                          "${state.repositories?[i].name} ${DateFormat("MM/yyyy HH:mm").format(
                            state.repositories?[i].updatedAt ?? DateTime.now(),
                          )}",
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
