import 'dart:convert';

import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/login/classes/requestUserAdmin.dart';
import 'package:begappmyadmin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  // static const defaultUrl = "https://localhost:44370/api/v1/";
  var defaultUrl = "https://api.begapp.com.br/api/v1/";

  static getToken() async {
    localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  static validateLogin(String userEmail, String userPassword) async {
    String url = defaultUrl + "auth";

    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body:
            jsonEncode({"UserEmail": userEmail, "UserPassword": userPassword}));
    String body = res.body;
    var json = jsonDecode(body);
    final message = json['accessToken'];
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', json['accessToken']);
    debugPrint(message);
    // var json = jsonDecode(body);

    // //  print('${json.runtimeType} : $json');
    // var errorsJson = json['errors'];

    // Map<String, dynamic> data = json['errors'];
    // final emailError = data['UserEmail'] as List;
    // print(emailError);
    // print("response: ${res.body}");
    return res;
  }

  static registerUser(AdminUser user) async {
    String url = defaultUrl + "auth/RegisterUser";

    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "Name": user.name,
          "Username": user.username,
          "UserEmail": user.email,
          "UserPassword": user.password,
          "UserConfirmPassword": user.confirmPassword
        }));
    String body = res.body;

    //print('${json.runtimeType} : $json');
    // var errorsJson = json['errors'];

    // Map<String, dynamic> data = json['errors'];
    // debugPrint(errorsJson);
    // final emailError = data['UserEmail'] as List;
    // print(emailError);
    print("response: ${res.statusCode}");
    return res;
  }

  static activateUser(String userEmail, String passwordRecoveryCode) async {
    String url = defaultUrl + "auth/ActivateUser";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "UserEmail": userEmail,
          "PasswordRecoveryCode": passwordRecoveryCode,
        }));
    String body = res.body;
    print(body);
    // var json = jsonDecode(body);

    // print('${json.runtimeType} : $json');

    // print("response: ${res.statusCode}");
    return body;
  }

  static forgotPasswordRequest(String userEmail) async {
    String url = defaultUrl + "auth/ForgotMyPasswordRequest";
    // "https://api.begapp.com.br/api/v1/auth/ForgotMyPasswordRequest";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "UserName": userEmail,
        }));
    String body = res.body;
    debugPrint(body);
    var json = jsonDecode(body);
    final message = json['message'];
    debugPrint(message);
    return message;
  }

  static resetPassword({
    required String userEmail,
    required String newPassword,
    required String newPasswordConfirm,
    required String passwordRecoveryCode,
  }) async {
    String url = defaultUrl + "auth/ForgotMyPassword";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "UserName": userEmail,
          "NewPassword": newPassword,
          "NewPasswordConfirm": newPasswordConfirm,
          "PasswordRecoveryCode": passwordRecoveryCode
        }));
    String body = res.body;
    debugPrint(body);
    var json = jsonDecode(body);
    final message = json['message'];
    debugPrint(message);
    return message;
  }

  static createGame({
    required Game game,
  }) async {
    debugPrint(jsonEncode({
      "Name": game.name,
      "Description": game.description,
      "parameters": game.parameters,
      "DefaultParameters": game.parameters
    }));
    String url = defaultUrl + "Games";
    String token = await getToken();
    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "Name": game.name,
          "Description": game.description,
          "parameters": game.parameters,
          "DefaultParameters": game.defaultParameters
        }));
    String body = res.body;
    var json = jsonDecode(body);
    final message = json['message'];
    //debugPrint(message);
    return message;
  }
}
