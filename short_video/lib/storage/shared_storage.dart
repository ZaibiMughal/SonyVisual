import 'dart:convert';

import 'package:hive/hive.dart';

class SharedStorage{

  static Box box = Hive.box("sonyVisual");


  static setBool(String key, bool value) async {
    await box.put(key, value);
  }

  static bool? getBool(String key) {
    return box.get(key);
  }

  static setInt(String key, int value) async {
    await box.put(key, value);
  }

  static int? getInt(String key) {
    return box.get(key);
  }

  static setDouble(String key, double value) async {
    await box.put(key, value);
  }

  static double? getDouble(String key) {
    return box.get(key);
  }

  static setStringList(String key, List<String> list) async {
    await box.put(key, list);
  }

  static List<String>? getStringList(String key) {
    List<dynamic>? data = box.get(key);

    print("Data $data");

    if(data == null){
      return [];
    }
    return (data).map((item) => item as String).toList();
  }

  static setString(String key, String value) async {
    await box.put(key, value);
  }

  static String? getString(String key) {
    return box.get(key);
  }


  static remove(String key) async  {
    return await box.delete(key);
  }

  static set(String key, dynamic value) async {
    await box.put(key, value);
  }

  static T? get<T>(String key) {
    return box.get(key);
  }
}