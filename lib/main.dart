import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_api/screens/auth/auth_screen.dart';
import 'package:github_api/l10n/generated/l10n.dart';
import 'package:github_api/screens/init_widget/init.dart';
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitWidget(
      key: const ValueKey('init_widget'),
      child: MaterialApp(
        title: 'Github API',
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData.dark(),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const AuthScreen(),
      ),
    );
  }
}
