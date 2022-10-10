import 'package:livewell/core/local_storage/pref_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConstant.accessToken, token);
    return token;
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.accessToken) ?? '';
  }

  static Future<String> saveRefreshToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConstant.refreshToken, token);
    return token;
  }

  static Future<String> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.refreshToken) ?? '';
  }

  static Future<bool> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<bool> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(PrefConstant.accessToken);
  }

  static Future<bool> removeRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(PrefConstant.refreshToken);
  }

  static Future<String> getMealHistories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.mealHistories) ?? '';
  }

  static Future<bool> saveMealHistories(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefConstant.mealHistories, data);
  }
}
