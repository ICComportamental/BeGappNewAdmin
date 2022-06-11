import 'package:begappmyadmin/classes/database.dart';
import 'package:flutter/material.dart';

class ConfirmAccount extends StatefulWidget {
  String? myurl, userEmail, passwordRecoveryCode;

  ConfirmAccount({this.myurl, this.userEmail, this.passwordRecoveryCode});

  @override
  State<ConfirmAccount> createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
  String? url;
  String? userEmail;
  @override
  void initState() {
    String? url = Uri.base.toString(); //get complete url
    String? userEmail = Uri.base.queryParameters["teste"];
    // String? passwordRecoveryCode =
    //   Uri.base.queryParameters["PasswordRecoveryCode"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Database.activateUser(
            widget.userEmail!, widget.passwordRecoveryCode!),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data future:" +
                  snapshot.error.toString() +
                  widget.userEmail! +
                  widget.passwordRecoveryCode!),
            );
          }
          // Navigator.pushReplacementNamed(context, '/login');
          // localStorage = snapshot.data as SharedPreferences;
          // if (localStorage.containsKey('login')) {
          //   if (!localStorage.getBool('login')!) {
          //     print("AA : ${localStorage.get('username')}");
          //     logged = false;
          //   }
          // } else {
          //   logged = false;
          // }
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            //ao terminar o build, se não estiver logado, redireciona para o login
            // if (!logged)
            Navigator.pushReplacementNamed(context, '/login');
          });

          return const Center(
            child: CircularProgressIndicator(),
          );

          // return (!logged)
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : widget.page;
        });

    Scaffold(
        appBar: AppBar(
          title: Text("Get URL Parameter"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              children: [
                //display parameters and URL here
                Text(widget.userEmail == null
                    ? "Parameter1 is null"
                    : "Parameter 1 = " + widget.userEmail!),
                Text(userEmail == null
                    ? "teste is null"
                    : "teste = " + userEmail!),
                Text(widget.passwordRecoveryCode == null
                    ? "Parameter2 is null"
                    : "Parameter 2 = " + widget.passwordRecoveryCode!),
                Text(widget.myurl == null
                    ? "URl is null"
                    : "URL = " + widget.myurl!)
              ],
            )));
  }
}
