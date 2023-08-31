import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static Future<SharedPreferences> get instance async => prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefsInstance = await instance;
    return prefsInstance!;
  }

  // To clear all the sharedPreference data
  static Future<bool> clear() async {
    var prefs = await instance;
    prefs.clear();
    return true;
  }

  static String getString(String key, [String defValue = ""]) {
    return prefsInstance!.getString(key) ?? defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await instance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    return prefs.setString(key, value);
  }

  static int getInt(String key, [int defValue = 0]) {
    return prefsInstance!.getInt(key) ?? defValue;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await instance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    return prefs.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await instance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    return prefs.setBool(key, value);
  }

  static bool getBool(String key, [bool defValue = false]) {
    return prefsInstance!.getBool(key) ?? defValue;
  }
}