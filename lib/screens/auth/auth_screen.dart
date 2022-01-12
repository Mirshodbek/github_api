import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api/features/svg.dart';
import 'package:github_api/l10n/generated/l10n.dart';
import 'package:github_api/main.dart';
import 'package:github_api/screens/auth/bloc/bloc_auth.dart';
import 'package:github_api/screens/profile/profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _controller;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).github,
        ),
      ),
      body: BlocConsumer<BlocAuth, AuthStates>(
        listener: (context, state) {
          if (state is AuthorizedAuthState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          }
          if (state is LoginAuthState) {
            if (state.message != null) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text(
                    state.message!,
                  ),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcons.github,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 32),
                  if (state is InitialAuthState)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  if (state is LoginAuthState)
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null) return null;
                              if (value.isEmpty) {
                                return S.of(context).inputError;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: S.of(context).userName,
                              fillColor: Colors.grey[600],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.grey[600]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.grey[600]!,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.grey[600]!,
                                ),
                              ),
                            ),
                            controller: _controller,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                            ),
                            onPressed: () {
                              if (!state.loading &&
                                  (_formKey.currentState?.validate() ??
                                      false)) {
                                context
                                    .read<BlocAuth>()
                                    .add(LoginAuthEvent(_controller.text));
                              }
                            },
                            child: state.loading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  )
                                : Text(
                                    S.of(context).login,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
