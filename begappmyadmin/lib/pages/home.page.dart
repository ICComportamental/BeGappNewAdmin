import 'dart:ui';

import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Plataforma de jogos comportamentais",
        textAlign: TextAlign.center,
      )),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: const Text(
                  "Adicionar Jogo",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await Dialogs.showAddNewGame(
                    context,
                  );
                  setState(() {});
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: const Text(
                  "Listar Jogos",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, "/GamesPage");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
