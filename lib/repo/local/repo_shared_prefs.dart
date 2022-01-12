import 'package:shared_preferences/shared_preferences.dart';

class RepoSharedPrefs {
  Future init() async {
    storage = await SharedPreferences.getInstance();
  }

  late SharedPreferences storage;
}
