import 'package:shared_preferences/shared_preferences.dart';

class LastSongListenPreference {

  Future<void> saveData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data.forEach((key, value) {
    if (value is int) {
        prefs.setInt(key, value);
      } else if (value is double) {
        prefs.setDouble(key, value);
      } else if (value is String) {
        prefs.setString(key, value);
      } else if (value is bool) {
        prefs.setBool(key, value);
      } else {
        throw ArgumentError('Tipo de datos no admitido para guardar en SharedPreferences.');
      }
    });
  }

  Future<Map<String, dynamic>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {};

    Set<String> keys = prefs.getKeys();
    for (String key in keys) {
      dynamic value = prefs.get(key);
      if (value != null) {
        data[key] = value;
      }
    }

    return data;
}

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}