import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/modals/UpdateExperiment.dart';
import 'package:begappmyadmin/modals/createGame.dart';
import 'package:begappmyadmin/modals/CreateExperiment.dart';
import 'package:begappmyadmin/modals/updateGame.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showAddNewGame(context) async {
    Dialog createGameDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CreateGame());
    await showDialog(
        context: context, builder: (BuildContext context) => createGameDialog);
  }

  static showUpdateGame(context, Game game) async {
    Dialog createGameDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: UpdateGame(game));
    await showDialog(
        context: context, builder: (BuildContext context) => createGameDialog);
  }

  static showUpdateExperiment(
      context, Experiment experiment, Map parameters) async {
    Dialog updateExperimentDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: UpdateExperiment(experiment, parameters));
    await showDialog(
        context: context,
        builder: (BuildContext context) => updateExperimentDialog);
  }

  static showCreateExperiment(context, Game game) async {
    Dialog createGameDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: CreateExperiment(game));
    await showDialog(
        context: context, builder: (BuildContext context) => createGameDialog);
  }

  static showRegisterUser(context) async {
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
