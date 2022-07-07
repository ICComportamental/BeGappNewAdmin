import 'package:begappmyadmin/login/classes/loginSettings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class FutureCheckLogin extends StatefulWidget {
  final Widget page;

  const FutureCheckLogin({Key? key, required this.page}) : super(key: key);
  @override
  _FutureCheckLoginState createState() => _FutureCheckLoginState();
}

class _FutureCheckLoginState extends State<FutureCheckLogin> {
  bool logged = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: LoginSettings.isLogged(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data future"),
            );
          }
          localStorage = snapshot.data as SharedPreferences;
          if (localStorage.containsKey('login')) {
            if (!localStorage.getBool('login')!) {
              print("AA : ${localStorage.get('username')}");
              logged = false;
            }
          } else {
            logged = false;
          }
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            //ao terminar o build, se não estiver logado, redireciona para o login
            if (!logged) Navigator.pushReplacementNamed(context, '/login');
          });

          return (!logged)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : widget.page;
        });
  }
}
