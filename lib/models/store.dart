import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lime_mobile_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreModel extends ChangeNotifier {
  static final StoreModel _singleton = StoreModel._internal();

  StoreModel._internal() {
    _darkMode = false;
    _authenticated = false;
    _processing = false;

    // TODO use UserModel.zero to clear these values
    user = UserModel(
      id: 0,
      firstName: 'John',
      lastName: 'Doe',
    );
    env = {};
  }

  StoreModel.zero() {
    StoreModel._internal();
  }

  factory StoreModel() {
    return _singleton;
  }

  bool _darkMode;
  bool _authenticated;
  bool _processing;
  bool firstRun;
  String flutterEnv = 'production';
  Map<String, String> env;
  UserModel user;
  Uint8List picture;
  Brightness oldPlatformBrightness;
  Brightness platformBrightness;
  Brightness oldBrightness;
  Brightness brightness;

  bool get isDarkMode => _darkMode == true;

  bool get isAuthenticated => _authenticated;

  bool get isProcessing => _processing;

  set darkMode(bool value) {
    if (_darkMode != value) {
      _darkMode = value;
      _saveThemeMode();
      notifyListeners();
    }
  }

  set processing(bool value) {
    if (_processing != value) {
      _processing = value;
      notifyListeners();
    }
  }

  Future<bool> login() {
    if (user != null || user != UserModel.zero) {
      _authenticated = true;
      notifyListeners();
    }
    return Future.delayed(Duration(seconds: 0), () => _authenticated);
  }

  Future<bool> logout() {
    return Future.delayed(Duration(milliseconds: 500), () {
      if (isAuthenticated) {
        _authenticated = false;
        user = UserModel.zero;
        picture = null;
        notifyListeners();
      }
      return true;
    });
  }

  onChangePlatformBrightness(Brightness _platformBrightness) async {
    bool isDarkPlatform = _platformBrightness == Brightness.dark;
    platformBrightness = _platformBrightness;
    oldBrightness = isDarkMode ? Brightness.dark : Brightness.light;

    if (platformBrightness != oldBrightness) {
      if (isDarkPlatform && !isDarkMode) {
        darkMode = true;
      } else if (!isDarkPlatform && isDarkMode) {
        darkMode = false;
      }
    }
  }

  Future _saveThemeMode() async {
    var sharedPref = await SharedPreferences.getInstance();
    brightness = isDarkMode ? Brightness.dark : Brightness.light;
    oldBrightness = brightness;
    oldPlatformBrightness = platformBrightness;
    return sharedPref.setBool('darkMode', isDarkMode);
  }
}

final StoreModel appStore = StoreModel();
