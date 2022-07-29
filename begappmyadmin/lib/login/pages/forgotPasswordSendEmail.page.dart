// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class ForgotPasswordSendEmailPage extends StatelessWidget {
  final TextEditingController txtEmail = new TextEditingController();
  static const routeName = '/ForgotPassword';
  bool emailDoesntExist = false;
  final _formKey = GlobalKey<FormState>();
  ForgotPasswordSendEmailPage();

  int flexTitle = 2;
  int flexMessage = 4;
  int flexEmail = 4;
  int flexBtn = 4;

  @override
  Widget build(BuildContext context) {
    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setDecoration(String label) {
      return InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            // fontSize:20,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ));
    }

    // txtEmail.text = "usuario@gmail.com";
    return Scaffold(
      body: Container(
          color: Colors.purple,
          alignment: Alignment.center,
          child: Container(
              height: height / 2.5,
              width: width / 3,
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x80000000),
                    blurRadius: 30.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: flexTitle,
                            child: Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('resetPassword'),
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                            .size
                                            .longestSide *
                                        0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: flexMessage,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.purple[100],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('infoEmail'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.longestSide *
                                          0.012,
                                  color: Colors.black87,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: flexEmail,
                            child: TextFormField(
                              controller: txtEmail,
                              keyboardType: TextInputType.emailAddress,
                              // maxLength: lengths[0].character_maximum_length,
                              decoration: setDecoration(
                                  AppLocalizations.of(context)
                                      .translate('Email')),
                              // onChanged: (value) => onChanged(value),
                              validator: (value) => validator(value),
                            )),
                        Expanded(
                          flex: flexBtn,
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.purple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('continue'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.04)),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      debugPrint("query:NEXT");
                                      String txt =
                                          await Database.forgotPasswordRequest(
                                              txtEmail.text);

                                      Dialogs.okDialog(txt, context);
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ForgotPasswordCodePage(
                                      //                 txtEmail.text)));
                                    }
                                  })),
                        ),
                      ])))),
    );
  }
}
