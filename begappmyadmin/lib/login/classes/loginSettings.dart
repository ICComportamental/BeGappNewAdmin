import 'package:begappmyadmin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSettings {
  static Future<SharedPreferences>? isLogged() async {
    localStorage = await SharedPreferences.getInstance();
    // localStorage = await SharedPreferences.getInstance();
    if (localStorage != null) {
      if (localStorage.containsKey('username') != null) {
        print('Logged');
        // print("usuario : ${preferences.get('username')}");
        //return true;
      } else
        print('Out');
      // return false;
    }
    return localStorage;
  }

  static logout() async {
    localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('login', false);
  }

  bool logged = false;
  checkIfAuthenticated() async {
    localStorage = await SharedPreferences.getInstance();
    if (localStorage != null) {
      if (localStorage.containsKey('username') != null) {
        print('Logged');
        // print("usuario : ${localStorage.get('username')}");
        return true;
      } else
        print('Out');
      return false;
    }
    return false;
  }
}
