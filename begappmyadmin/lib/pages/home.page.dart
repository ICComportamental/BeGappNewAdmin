import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
          child: Text("open"),
          onPressed: () async {
            await Dialogs.showAddNewGame(
              context,
            );
            setState(() {});
          },
        ),
      ),
    );
  }
}
