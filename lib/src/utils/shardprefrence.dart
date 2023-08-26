import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  LocalDatabase._();

  static final localDatabase = LocalDatabase._();

  late SharedPreferences sh;
  saredPreferencesAsign() async {
    sh = await SharedPreferences.getInstance();
  }
}
