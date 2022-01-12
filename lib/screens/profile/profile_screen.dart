import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/repo/api/users/repo_users.dart';
import 'package:github_api/screens/auth/auth_screen.dart';
import 'package:github_api/screens/auth/bloc/bloc_auth.dart';
import 'package:github_api/screens/search/bloc/bloc_search.dart';
import 'package:github_api/screens/search/search_screen.dart';
import 'package:github_api/l10n/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocAuth, AuthStates>(
      listener: (context, state) {
        if (state is LoginAuthState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthorizedAuthState) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () =>
                    context.read<BlocAuth>().add(LogoutAuthEvent()),
                icon: const Icon(Icons.exit_to_app),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => BlocSearch(
                          repoUsers: RepositoryProvider.of<RepoUsers>(context),
                        ),
                        child: const SearchScreen(),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.user?.avatar != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          state.user!.avatar!,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              state.user?.name ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.user?.login ?? "",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.people),
                            const SizedBox(width: 10),
                            Text(
                              "${state.user?.followers}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).repositories,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      height: 24,
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    for (int i = 0; i < (state.repositories?.length ?? 0); i++)
                      ListTile(
                        leading: Text("${i+1})"),
                        trailing: Text("${state.repositories?[i].forksCount}"),
                        subtitle: Text("branch: ${state.repositories?[i].defaultBranch}"),
                        title: Text(
                          "${state.repositories?[i].name}",
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
