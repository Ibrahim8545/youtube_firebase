import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveLogin() async {
    await sharedPreferences.setBool('isLoggedIn', true);
  }

  static bool isLoggedIn() {
    return sharedPreferences.getBool('isLoggedIn') ?? false;
  }
}
