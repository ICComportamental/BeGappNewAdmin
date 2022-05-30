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
    return
        // Scaffold(
        //   body: Container(
        //     child: CircularProgressIndicator(),
        //   ),
        // );

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
