import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/modals/createGame.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showAddNewGame(context) async {
    // var snap = await Database.getPublicGoodsExperiment('default');
    // Game experiment = Game.fromJson(snap[0]);

    Dialog createGameDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CreateGame());
    await showDialog(
        context: context, builder: (BuildContext context) => createGameDialog);
  }

  static showRegisterUser(context) async {
    // var snap = await Database.getPublicGoodsExperiment('default');
    // Game experiment = Game.fromJson(snap[0]);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(
                AppLocalizations.of(context).translate('checkEmail'),
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

  static okDialog(String txt, context, {Function? onPop}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(
                txt,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 30),
              ),
              actions: [
                TextButton(
                    onPressed: onPop != null
                        ? () => onPop()
                        : () {
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
