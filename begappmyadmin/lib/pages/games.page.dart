import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/widgets/FutureCheckLogin.dart';
import 'package:begappmyadmin/widgets/GamesDatatable.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  static const routeName = '/GamesPage';

  const GamesPage({Key? key}) : super(key: key);

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return FutureCheckLogin(
      page: FutureBuilder(
          future: Database.getGames(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (snapshot.hasError) {
            //   return Center(
            //     child: Text(
            //         "Error fetching data future:" + snapshot.error.toString()),
            //   );
            // }

            List snap = snapshot.data as List<dynamic>;
            List<Game> games = [];
            for (int index = 0; index < snap.length; index++) {
              games.add(Game.fromJson(snap[index]));
            }

            print(snap[0]);
            print(games[0].name);

            return Container(
              child: GamesTable(games),
            );
            return const Center(
              child: CircularProgressIndicator(),
            );

            // return (!logged)
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : widget.page;
          }),
    );
  }
}
