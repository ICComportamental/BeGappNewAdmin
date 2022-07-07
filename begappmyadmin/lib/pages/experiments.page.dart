import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/main.dart';
import 'package:begappmyadmin/widgets/ExperimentsDatatable.dart';
import 'package:flutter/material.dart';

import '../widgets/FutureCheckLogin.dart';

class ExperimentsPage extends StatefulWidget {
  String? gameId;
  // static const routeName = '/ExperimentsPage';

  ExperimentsPage({required this.gameId});
  // ExperimentsPage();

  @override
  State<ExperimentsPage> createState() => _ExperimentsPageState();
}

class _ExperimentsPageState extends State<ExperimentsPage> {
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
            future: Database.getExperiments(widget.gameId!),
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
              List<Experiment> experiments = [];
              for (int index = 0; index < snap.length; index++) {
                experiments.add(Experiment.fromJson(snap[index]));
              }

              // print(snap[0]);
              // print(experiments[0].description);

              return Container(
                child: ExperimentsTable(experiments),
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
