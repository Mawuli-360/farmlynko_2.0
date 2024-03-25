import 'package:farmlynko/routes/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStore {

  LocalStore._();

  static const String INITIAL_KEY = "INITIALkEY";


  static Future<void> setInitialRoute(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(INITIAL_KEY, value);
  }

  static Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(INITIAL_KEY) ?? Navigation.loginScreen;
  }
}