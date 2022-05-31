import 'dart:convert';

import 'package:begappmyadmin/login/classes/requestUserAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Database {
  static validateLogin(String userEmail, String userPassword) async {
    String url = "https://api.begapp.com.br/api/v1/auth";

    var res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body:
            jsonEncode({"UserEmail": userEmail, "UserPassword": userPassword}));
    String body = res.body;
    // var json = jsonDecode(body);

    // //  print('${json.runtimeType} : $json');
    // var errorsJson = json['errors'];

    // Map<String, dynamic> data = json['errors'];
    // final emailError = data['UserEmail'] as List;
    // print(emailError);
    print("response: ${res.statusCode}");
    return res;
  }

  static registerUser(AdminUser user) async {
    String url = "https://api.begapp.com.br/api/v1/auth/RegisterUser";

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
    var json = jsonDecode(body);

    print('${json.runtimeType} : $json');
    // var errorsJson = json['errors'];

    // Map<String, dynamic> data = json['errors'];
    // debugPrint(errorsJson);
    // final emailError = data['UserEmail'] as List;
    // print(emailError);
    print("response: ${res.statusCode}");
    return res;
  }

  static activateUser(String userEmail, String passwordRecoveryCode) async {
    String url = "https://api.begapp.com.br/api/v1/auth/ActivateUser";
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
}
