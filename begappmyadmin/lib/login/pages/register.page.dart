// import 'dart:convert';

// import 'package:begappmyadmin/app_localizations.dart';
// import 'package:flutter/material.dart';

// class RegisterPage extends StatefulWidget {
//   static const routeName = '/RegisterPage';

//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   bool obscure = true;
//   bool requestApproved = true;
//   bool emailUnavailable = true;
//   bool nameAvailable = true;
//   String fullName = "";
//   TextEditingController username = new TextEditingController();
//   TextEditingController email = new TextEditingController();
//   TextEditingController password = new TextEditingController();
//   TextEditingController confirmPassword = new TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final GlobalKey<State> _keyLoader = new GlobalKey<State>();

//   @override
//   void initState() {
//     print("v1");
//     super.initState();
//     // focusNode = new FocusNode();
//     // focusNode.addListener(() {
//     //   if (!focusNode.hasFocus) {
//     //     setState(() {
//     //       checkEmail(email.text); //Check your conditions on text variable
//     //     });
//     //   }
//     // });
//     // focusNodeUsername = new FocusNode();
//     // focusNodeUsername.addListener(() {
//     //   if (!focusNodeUsername.hasFocus) {
//     //     setState(() {
//     //       checkUsername(username.text); //Check your conditions on text variable
//     //     });
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double longestSide = MediaQuery.of(context).size.longestSide;
//     return Scaffold(
//         body: Container(
//       color: Colors.blue,
//       alignment: Alignment.center,
//       padding:
//           EdgeInsets.symmetric(horizontal: width / 3, vertical: height / 10),
//       child: Container(
//           // container do login
//           margin: EdgeInsets.symmetric(vertical: height / 15),
//           padding: EdgeInsets.symmetric(
//               horizontal: width / 30, vertical: height / 30),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x80000000),
//                 blurRadius: 30.0,
//                 offset: Offset(0.0, 5.0),
//               ),
//             ],
//           ),
//           child: Form(
//               key: _formKey,
//               child: Flex(
//                   direction: Axis.vertical,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                         child: Container(
//                       child: Text(
//                         AppLocalizations.of(context).translate('RegisterLabel'),
//                         style: TextStyle(
//                             fontSize: longestSide * 0.02,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )),
//                     Expanded(
//                         flex: 1,
//                         child: TextFormField(
//                           // focusNode: focusNodeUsername,
//                           controller: username,
//                           maxLength: 20,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                               counterText: "",
//                               labelText: AppLocalizations.of(context)
//                                   .translate('username'),
//                               labelStyle: const TextStyle(
//                                 color: Colors.black38,
//                                 fontWeight: FontWeight.w400,
//                                 // fontSize:20,
//                               ),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.blueGrey),
//                                 borderRadius:  BorderRadius.all(
//                                    Radius.circular(10.0),
//                                 ),
//                               )),
//                           validator: (value) => validateUsername(value),
//                         )),
//                     Expanded(
//                         flex: 1,
//                         child: TextFormField(
//                           // focusNode: focusNode,
//                           controller: email,
//                           maxLength: 50,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                               counterText: "",
//                               labelText: AppLocalizations.of(context)
//                                   .translate('email'),
//                               labelStyle: const TextStyle(
//                                 color: Colors.black38,
//                                 fontWeight: FontWeight.w400,
//                                 // fontSize:20,
//                               ),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.blueGrey),
//                                 borderRadius:  BorderRadius.all(
//                                    Radius.circular(10.0),
//                                 ),
//                               )),
//                           validator: (value) => validateEmail(value),
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: TextFormField(
//                         // autofocus: true,
//                         controller: password,
//                         keyboardType: TextInputType.text,
//                         obscureText: obscure,
//                         decoration: InputDecoration(
//                             labelText: AppLocalizations.of(context)
//                                 .translate('password'),
//                             labelStyle: const TextStyle(
//                               color: Colors.black38,
//                               fontWeight: FontWeight.w400,
//                               // fontSize:20,
//                             ),
//                             suffixIcon: GestureDetector(
//                               child: Icon(obscure
//                                   ? Icons.visibility_off
//                                   : Icons.visibility),
//                               onTap: () {
//                                 setState(() {
//                                   obscure = !obscure;
//                                 });
//                               },
//                             ),
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.blueGrey),
//                               borderRadius:  BorderRadius.all(
//                                  Radius.circular(10.0),
//                               ),
//                             )),
//                         validator: (value) => validatePassword(value),
//                         // onChanged: (value) => _formKey.currentState!.validate(),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: TextFormField(
//                         // autofocus: true,
//                         controller: confirmPassword,
//                         keyboardType: TextInputType.text,
//                         obscureText: obscure,
//                         validator: (value) => validatePassword(value),
//                         // onChanged: (value) => _formKey.currentState!.validate(),
//                         decoration: InputDecoration(
//                             labelText: AppLocalizations.of(context)
//                                 .translate('ConfirmPassword'),
//                             labelStyle: TextStyle(
//                               color: Colors.black38,
//                               fontWeight: FontWeight.w400,
//                               // fontSize:20,
//                             ),
//                             suffixIcon: GestureDetector(
//                               child: Icon(obscure
//                                   ? Icons.visibility_off
//                                   : Icons.visibility),
//                               onTap: () {
//                                 setState(() {
//                                   obscure = !obscure;
//                                 });
//                               },
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.blueGrey),
//                               borderRadius: const BorderRadius.all(
//                                 const Radius.circular(10.0),
//                               ),
//                             )),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.all(Radius.circular(5)),
//                           ),
//                           child: TextButton(
//                               child: Text(
//                                   AppLocalizations.of(context)
//                                       .translate('toRegister'),
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: height * 0.04)),
//                               onPressed: () async {
//                                 // validateEmail(email.text);
//                                 // validateUsername(username.text);
//                                 await checkEmail(email.text);
//                                 await checkUsername(username.text);
//                                 // validatePassword(password.text);
//                                 if (_formKey.currentState!.validate())
//                                   // print("passou");
//                                   _handleSubmit(context);
//                               })),
//                     ),
//                   ]))),
//     ));
//   }
// }
