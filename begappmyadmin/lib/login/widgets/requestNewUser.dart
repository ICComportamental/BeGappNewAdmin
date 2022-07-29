import 'dart:convert';

import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/login/classes/requestUserAdmin.dart';
import 'package:flutter/material.dart';

class RequestNewUser extends StatefulWidget {
  final Function onCancel;

  RequestNewUser({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  @override
  _RequestNewUserState createState() => _RequestNewUserState();
}

class _RequestNewUserState extends State<RequestNewUser> {
  TextEditingController txtName = TextEditingController(text: "");

  TextEditingController txtNewUsername = TextEditingController(text: "");

  TextEditingController txtEmail = TextEditingController(text: "");

  TextEditingController txtPassword = TextEditingController(text: "");

  TextEditingController txtConfirmPassword = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  bool requestExist = true;

  bool emailUnavailable = true;

  bool obscure = false;

  // late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validator(value) {
      if (value.isEmpty) {
        return AppLocalizations.of(context).translate('Required field');
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double longest = MediaQuery.of(context).size.longestSide;
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

    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 40),
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
                      child: Container(
                    child: Text(
                      AppLocalizations.of(context).translate('RegisterUser'),
                      style: TextStyle(
                          fontSize: longest * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtName,
                        keyboardType: TextInputType.emailAddress,
                        decoration: setDecoration(
                            AppLocalizations.of(context).translate('Name')),
                        // style: TextStyle(fontSize: 20),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtNewUsername,
                        keyboardType: TextInputType.emailAddress,
                        decoration: setDecoration(
                            AppLocalizations.of(context).translate('username')),
                        // style: TextStyle(fontSize: 20),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: setDecoration("Email"),
                        // style: TextStyle(fontSize: 20),
                        // validator: (value) => validateEmail(value),
                      )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtPassword,
                        maxLines: 1,
                        obscureText: obscure,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('password'),
                            labelStyle: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              // fontSize:20,
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            )),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: txtConfirmPassword,
                        obscureText: obscure,
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('confirmPassword'),
                            labelStyle: const TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              // fontSize:20,
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            )),
                        validator: (value) => validator(value),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextButton(
                            child: Text(
                                AppLocalizations.of(context).translate('Send'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.04)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                AdminUser adminUserRequest = AdminUser(
                                  txtName.text,
                                  txtNewUsername.text,
                                  txtEmail.text,
                                  txtPassword.text,
                                  txtConfirmPassword.text,
                                );
                                await Database.registerUser(adminUserRequest);
                                // Dialogs.showMessageDialog(
                                //     context,
                                //     AppLocalizations.of(context)
                                //         .translate('requestSend'));
                                widget.onCancel();
                              }
                            })),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // height: 40,
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context).translate('cancel'),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => widget.onCancel(),
                      ),
                    ),
                  ),
                ])));
  }
}
