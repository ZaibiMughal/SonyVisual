import 'dart:convert';
import 'package:short_video/storage/shared_storage.dart';
import '../config/main_config.dart';
import '../models/user.dart';

class AppState {
  AppState._();

  User? user;
  bool? isLoggedIn;

  // Singleton instance
  static final AppState _singleton = AppState._();

  // Singleton accessor
  static AppState get instance => _singleton;

  Future<bool> setIsLoggedIn(bool value) async {
    await SharedStorage.setBool(Config.isLoggedIn, value);
    return isLoggedIn = value;
  }

  bool? getIsLoggedIn() {
    if(isLoggedIn == null || isLoggedIn == false){
      bool? output = SharedStorage.getBool(Config.isLoggedIn);
      return isLoggedIn = output ?? false;
    }

    return isLoggedIn;
  }

  Future<User?> getUser() async {
    if(user == null){
      dynamic output = SharedStorage.get(Config.userStorageKey);
      if(output != null){
        user = User();
        user!.fromMap(json.decode(output));
      }
    }
    return user;
  }

  Future<User?> setUser(User? value) async {
    if(value != null) {
      await SharedStorage.set(
          Config.userStorageKey, json.encode(value.toMap()));
      setIsLoggedIn(true);
      // isLoggedIn = true;
    } else {
      await SharedStorage.set(
          Config.userStorageKey, null);
      setIsLoggedIn(false);
      // isLoggedIn = false;
    }
    return user = value;
  }


  updateUser() async {
    if(user != null){
      await SharedStorage.set(
          Config.userStorageKey, json.encode(user!.toMap()));
    }
  }


  getUserId(){
    if(user == null) {
      return 0;
    }
    return user!.getId();
  }


  Future<void> initialize() async {
    await getIsLoggedIn();
    await getUser();
  }

  logout() async {
    setUser(null);
    setIsLoggedIn(false);
  }
}
