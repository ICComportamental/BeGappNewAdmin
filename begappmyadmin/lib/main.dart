import 'package:begappmyadmin/AppLanguage.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/login/pages/ResetPassword.page.dart';
import 'package:begappmyadmin/login/pages/confirmAccount.dart';
import 'package:begappmyadmin/login/pages/login.page.dart';
import 'package:begappmyadmin/pages/games.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/MyCustomScrollBehavior.dart';
import 'classes/NavigationService.dart';
import 'login/pages/forgotPasswordSendEmail.page.dart';
import 'pages/experiments.page.dart';
import 'pages/home.page.dart';

void main() async {
  String? myurl = Uri.base.toString(); //get complete url
  String? userEmail = Uri.base.queryParameters["UserEmail"];
  String? passwordRecoveryCode =
      Uri.base.queryParameters["PasswordRecoveryCode"];

  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
      appLanguage: appLanguage,
      myurl: myurl,
      userEmail: userEmail,
      passwordRecoveryCode: passwordRecoveryCode));
}

late SharedPreferences localStorage;

TextEditingController username = TextEditingController(text: "");
TextEditingController password = TextEditingController(text: "");
// TextEditingController username =
//     TextEditingController(text: "yasmin.carolina12@gmail.com");
// TextEditingController password = TextEditingController(text: "1234");

String gameId =
    ""; //id do jogo de onde provem os experimentos na pagina da tabela dos experiments

class MyApp extends StatefulWidget {
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString("gameId", "");
  }

  final AppLanguage appLanguage;
  String? myurl, userEmail, passwordRecoveryCode;

  MyApp(
      {required this.appLanguage,
      this.myurl,
      this.userEmail,
      this.passwordRecoveryCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("V8 - Pesquisa na tabela Games");
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          widget.appLanguage.changeLanguage(Locale("pt"));
          return MaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            navigatorKey: NavigationService.navigatorKey,
            initialRoute: "/login",
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              HomePage.routeName: (context) => HomePage(),
              GamesPage.routeName: (context) => const GamesPage(),
              // ExperimentsPage.routeName: (context) => ExperimentsPage(),
              LoginPage.routeName: (context) => LoginPage(),
              '/confirm-account': (context) => ConfirmAccount(
                    myurl: widget.myurl,
                    userEmail: widget.userEmail,
                    passwordRecoveryCode: widget.passwordRecoveryCode,
                  ),
              '/ForgotPassword': (context) => ForgotPasswordSendEmailPage(),
              '/ResetPassword': (context) => ResetPassword(
                    myurl: widget.myurl,
                    userEmail: widget.userEmail,
                    passwordRecoveryCode: widget.passwordRecoveryCode,
                  )
            },
            locale: model.appLocal,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('pt', 'BR'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],

            debugShowCheckedModeBanner: false,
            /*onGenerateRoute: (settings) {
              List<String> pathComponents = settings.name!.split('/');
              final Map<String, dynamic> arguments = {
                "dataKey": ModalRoute.of(context)!.settings.arguments
              };
              print("PARAMETROS:");
              print(pathComponents[2]);
              switch ("/" + pathComponents[1]) {
                case '/confirm-account':
                  return MaterialPageRoute(
                      builder: (context) => ConfirmAccount(
                            myurl: widget.myurl,
                            userEmail: widget.userEmail,
                            passwordRecoveryCode: widget.passwordRecoveryCode,
                          ));

                default:
                  return MaterialPageRoute(builder: (context) => LoginPage());
              }
            },*/
            title: 'BeGapp',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            // home: LoginPage()
            // const MyHomePage(title: 'Flutter Demo Home Page'),
            /*home: Scaffold(
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
                        Text(widget.passwordRecoveryCode == null
                            ? "Parameter2 is null"
                            : "Parameter 2 = " + widget.passwordRecoveryCode!),
                        Text(widget.myurl == null
                            ? "URl is null"
                            : "URL = " + widget.myurl!)
                      ],
                    ))),*/
          );
        }));
  }
}
