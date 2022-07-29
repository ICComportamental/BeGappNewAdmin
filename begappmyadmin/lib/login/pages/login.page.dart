import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/connection.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/login/pages/forgotPasswordSendEmail.page.dart';
import 'package:begappmyadmin/login/widgets/requestNewUser.dart';
import 'package:begappmyadmin/main.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int flexUsername = 2;
  int flexPassword = 3;
  int flexLogin = 2;
  int flexRegister = 2;

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Connection.showLoadingDialog(context, _keyLoader); //invoking login
      await loadingLogin(context);
      save();
    } catch (error) {
      print(error);
    }
  }

  //salvar login
  save() async {
    await MyApp.init();

    localStorage.setString('username', username.text.toString());
    localStorage.setBool('login', true);
  }

  loadingLogin(BuildContext context) async {
    var jsonList;

    jsonList = await Database.validateLogin(username.text, password.text);
    await MyApp.init();
    if (jsonList.statusCode != 400) {
      await Future.delayed(
        Duration(
          seconds: 2,
        ),
      );
      Navigator.of(
        _keyLoader.currentContext!,
      ).pop();
      Navigator.pushNamed(context, "/HomePage");
      // adminUser = AdminUser.fromJson(jsonList[0]);
      // localStorage.setString('userType', adminUser.userType);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => HomePage(adminUser)));
      // Navigator.pushNamed(context, HomePage.routeName, arguments: adminUser);
    } else {
      Navigator.of(
        _keyLoader.currentContext!,
      ).pop(); //close the dialoge

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(
                  AppLocalizations.of(context).translate('invalidLogin'),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('ok'),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30),
                      )),
                ],
              ));
    }
  }

  //List<MaxLength> lengths = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // username.text = "usuario";
    // password.text = "a";
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (() {
      //   Database.validateLogin("yasmin.carolina12@gmail.com", "1234");
      // })),
      body: Container(
          color: Colors.purple[800],
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: width / 3, vertical: height / 10),
          child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              front: Container(
                  // container do login
                  margin: EdgeInsets.symmetric(vertical: height / 7),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 30, vertical: height / 30),
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
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        Expanded(
                            flex: flexUsername,
                            child: TextFormField(
                              controller: username,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('username'),
                                  labelStyle: const TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                    // fontSize:20,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  )),
                              // style: TextStyle(fontSize: 20),
                            )),
                        Expanded(
                            flex: flexPassword,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: password,
                                    keyboardType: TextInputType.text,
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
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        )),
                                    // style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('forgotPassword'),
                                          style:
                                              TextStyle(color: Colors.purple),
                                          textAlign: TextAlign.left,
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context,
                                              ForgotPasswordSendEmailPage
                                                  .routeName);
                                        },
                                      ),
                                    )),
                              ],
                            )),
                        Expanded(
                          flex: flexLogin,
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 201, 148, 231),
                                    Color.fromARGB(255, 72, 46, 165),
                                  ],
                                ),
                              ),
                              child: TextButton(
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.04)),
                                  onPressed: () => _handleSubmit(context))),
                        ),
                        Expanded(
                          flex: flexRegister,
                          child: Container(
                            height: 40,
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('register'),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () async {
                                setState(() {
                                  cardKey.currentState!.toggleCard();
                                });
                              },
                            ),
                          ),
                        ),
                      ]))),
              back: RequestNewUser(
                onCancel: () {
                  setState(() {
                    cardKey.currentState!.toggleCard();
                  });
                },
              ))),
    );
  }
}
