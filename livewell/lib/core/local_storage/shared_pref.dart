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

  static Future<String?> getLastHealthSyncDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.lastHealthSyncDate);
  }

  static Future<bool> saveLastHealthSyncDate(DateTime date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefConstant.lastHealthSyncDate, date.toString());
  }

  static Future<bool> getShowCoachmarkFood() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConstant.showCoachmarkFood) ?? true;
  }

  static Future<bool> saveShowCoachmarkFood(bool show) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefConstant.showCoachmarkFood, show);
  }

  static Future<bool> getCoachmarkDashboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConstant.showCoachmarkDashboard) ?? true;
  }

  static Future<bool> saveCoachmarkDashboard(bool show) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefConstant.showCoachmarkDashboard, show);
  }

  static Future<bool> showInfoExercise() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConstant.showInfoExercise) ?? true;
  }

  static Future<bool> saveShowInfoExercise(bool show) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefConstant.showInfoExercise, show);
  }

  static Future<bool> showInfoWater() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConstant.showInfoWater) ?? true;
  }

  static Future<bool> saveShowInfoWater(bool show) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefConstant.showInfoWater, show);
  }

  static Future<bool> showInfoSleep() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefConstant.showInfoSleep) ?? true;
  }

  static Future<bool> saveShowInfoSleep(bool show) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefConstant.showInfoSleep, show);
  }

  // save user locale
  static Future<String> saveUserLocale(String locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConstant.userLocale, locale);
    return locale;
  }

  static Future<String> getUserLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.userLocale) ?? '';
  }

  static Future<String> saveLocalizationJson(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConstant.localizationJSON, data);
    return data;
  }

  static Future<String?> getLocalizationJson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConstant.localizationJSON);
  }
}
