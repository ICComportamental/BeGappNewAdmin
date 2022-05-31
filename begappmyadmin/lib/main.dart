import 'package:begappmyadmin/AppLanguage.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/login/pages/confirmAccount.page.dart';
import 'package:begappmyadmin/login/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();

class MyApp extends StatefulWidget {
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
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
    print("V1");
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          widget.appLanguage.changeLanguage(Locale("pt"));
          return MaterialApp(
            initialRoute: "/login",
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/login': (context) => LoginPage(),
              '/confirm-account': (context) => ConfirmAccount(
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
              primarySwatch: Colors.blue,
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
