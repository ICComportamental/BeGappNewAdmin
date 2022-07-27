import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/classes/participant.dart';
import 'package:begappmyadmin/main.dart';
import 'package:begappmyadmin/widgets/ExperimentsDatatable.dart';
import 'package:begappmyadmin/widgets/ParticipantsDatatable.dart';
import 'package:flutter/material.dart';

import '../widgets/FutureCheckLogin.dart';

class ParticipantsPage extends StatefulWidget {
  String experiment;
  // static const routeName = '/ExperimentsPage';

  ParticipantsPage({required this.experiment});
  // ExperimentsPage();

  @override
  State<ParticipantsPage> createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage> {
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
            future: Database.getParticipants(widget.experiment),
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
              List<Participant> experiments = [];
              for (int index = 0; index < snap.length; index++) {
                experiments.add(Participant.fromJson(snap[index]));
                if (snap[index]['name'] != null) {
                  experiments.last.name = snap[index]['name'];
                  experiments.last.email = snap[index]['email'];
                  experiments.last.age = snap[index]['age'];
                  experiments.last.gender = snap[index]['gender'];
                }
              }

              // print(snap[0]);
              // print(experiments[0].description);

              return Container(
                child: ParticipantsTable(
                  experiments,
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
