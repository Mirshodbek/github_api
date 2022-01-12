import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api/l10n/generated/l10n.dart';
import 'package:github_api/main.dart';
import 'package:github_api/screens/search/bloc/bloc_search.dart';
import 'package:github_api/screens/repositories/repositories_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _SearchBar(),
      ),
      body: BlocConsumer<BlocSearch, SearchState>(
        listener: (context, state) {
          if (state.error != null) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(
                  state.error!,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.users?.isEmpty ?? true) {
            return Center(
              child: Text(
                S.of(context).noUser,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            );
          }
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, _) => const Divider(
                thickness: 1,
                height: 32,
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                final user = state.users?[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<BlocSearch>()
                            ..add(RepoUsersEvent(
                                user?.login ?? user?.name ?? "")),
                          child: RepositoryScreen(
                            userName: user?.login ?? user?.name ?? "",
                          ),
                        ),
                      ),
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: (user?.avatar != null)
                        ? Image.network(user!.avatar!)
                        : const SizedBox(),
                  ),
                  title: Text(
                    user?.login ?? user?.name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: state.users?.length ?? 0,
            ),
          );
        },
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: S.of(context).searchUser,
        ),
        onSubmitted: (_) {
          context.read<BlocSearch>().add(SearchUsersEvent(_controller.text));
          _debounce?.cancel();
        },
        onChanged: (_) {
          setState(() {
            if (_debounce?.isActive ?? false) _debounce?.cancel();

            _debounce = Timer(
              const Duration(seconds: 1),
              () {
                context
                    .read<BlocSearch>()
                    .add(SearchUsersEvent(_controller.text));
              },
            );
          });
        },
      ),
    );
  }
}
