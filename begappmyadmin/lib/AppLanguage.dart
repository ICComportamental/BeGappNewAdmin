//classe para escolher o idioma
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');
  String _username = "";
  String _password = "";
  bool login = false;

  Locale get appLocal => _appLocale; //?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("pt")) {
      _appLocale = Locale("pt");
      await prefs.setString('language_code', 'pt');
      await prefs.setString('countryCode', 'BR');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }

  void saveLogin(String username, String password) async {
    var prefs = await SharedPreferences.getInstance();

    if (_username == username && _password == password) {
      return;
    }
    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setBool('login', true);

    notifyListeners();
  }
}
