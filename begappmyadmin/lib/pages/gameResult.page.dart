import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/classes/roundResults.dart';
import 'package:begappmyadmin/main.dart';
import 'package:begappmyadmin/widgets/ExperimentsDatatable.dart';
import 'package:begappmyadmin/widgets/GameResultDatatable.dart';
import 'package:flutter/material.dart';

import '../widgets/FutureCheckLogin.dart';

class GameResultPage extends StatefulWidget {
  String participantId;
  // static const routeName = '/ExperimentsPage';

  GameResultPage({required this.participantId});
  // ExperimentsPage();

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    MyApp.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("GAMEID:${widget.gameId}");
    return FutureCheckLogin(
        page: FutureBuilder(
            future: Database.getRoundsResult(widget.participantId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error fetching data future:" +
                      snapshot.error.toString()),
                );
              }

              List snap = snapshot.data as List<dynamic>;
              List<RoundResults> rounds = [];
              for (int index = 0; index < snap.length; index++) {
                rounds.add(RoundResults.fromJson(snap[index]));
              }

              // print(snap[0]);
              // print(experiments[0].description);

              return Container(
                child: GameResultTable(
                  rounds,
                ),
              );
              // return const Center(
              //   child: CircularProgressIndicator(),
              // );

              // return (!logged)
              //     ? Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     : widget.page;
            }));
  }
}
