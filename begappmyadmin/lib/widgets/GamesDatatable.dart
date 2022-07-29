import 'package:begappmyadmin/DatatableElements/TableRows/datatableRows.dart';
import 'package:begappmyadmin/DatatableElements/pagedTable.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/main.dart';
import 'package:begappmyadmin/pages/experiments.page.dart';
import 'package:begappmyadmin/widgets/customDatatable.dart';
import 'package:flutter/material.dart';

class GamesTable extends StatefulWidget {
  List<Game> games;
  GamesTable(this.games);

  @override
  State<GamesTable> createState() => _GamesTableState();
}

class _GamesTableState extends State<GamesTable> {
  List<Game> gamesAll = [];
  List<Game> games = [];
  int nGames = 2;
  int indexPage = 1;
  @override
  void initState() {
    gamesAll = widget.games;
    games = gamesAll.sublist(
        0, nGames < gamesAll.length ? nGames : gamesAll.length);
    getRows();
    super.initState();
  }

  function() {
    setState(() {});
  }

  TextEditingController txtSearch = new TextEditingController();

  int searchFlex = 1;
  int tableFlex = 4;
  int btnFlex = 1;
  List<DataRow> rows = [];

  getRows() {
    debugPrint("Games: ${games.length}");
    debugPrint("Gamesall: ${gamesAll.length}");
    rows = [];
    for (var i = 0; i < games.length; i++) {
      rows.add(DataRow(
          color: MaterialStateColor.resolveWith(
            (states) {
              if (i % 2 > 0)
                return Color.fromARGB(255, 209, 209, 209);
              else
                return Colors.white;
            },
          ),
          cells: [
            DataCell(Text((gamesAll.indexOf(games[i]) + 1).toString())),
            DataCell(Text(games[i].name)),
            DataCell(Text(games[i].description)),
            DataCell(
              InkWell(
                child: Icon(Icons.edit),
                onTap: () async {
                  await Dialogs.showUpdateGame(context, games[i]);
                  setState(() {});
                },
              ),
            ),
            DataCell(
              Center(
                child: InkWell(
                  child: Icon(Icons.add_circle_outlined),
                  onTap: () async {
                    await Dialogs.showCreateExperiment(context, games[i]);
                    // setState(() {});
                  },
                ),
              ),
            ),
            DataCell(
              Center(
                child: InkWell(
                  child: Icon(Icons.list),
                  onTap: () async {
                    // await Dialogs.showCreateExperiment(context, games[i]);
                    // setState(() {});
                    // Navigator.pushNamed(
                    //   context,
                    //   ExperimentsPage.routeName,
                    //   arguments: <String, String>{'gameId': games[i].id},
                    // );
                    // gameId = games[i].id;
                    localStorage.setString('gameId', games[i].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExperimentsPage(game: games[i])));
                  },
                ),
              ),
            ),
          ]));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    space() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      );
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() async {
      //     String token = await Database.verifyToken();
      //     DateTime dateTime = DateTime.parse(token);
      //     // print(dateTime.isBefore(DateTime.now()));
      //     // print(dateTime);
      //   }),
      // ),
      body: PagedTable(
        table: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
              (states) {
                return Color.fromARGB(255, 151, 44, 170);
              },
            ),
            headingRowHeight: 56,
            dataRowHeight: 56,
            columns: const [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('Nome')),
              DataColumn(label: Text('Descrição')),
              DataColumn(label: Text('Editar')),
              DataColumn(label: Text('Adicionar Experimento')),
              DataColumn(label: Text('Listar Experimentos')),
            ],
            rows: rows),
        previous: () {
          if (indexPage > 1) indexPage--;
          games = gamesAll.sublist(
              (nGames * (indexPage - 1) > 0) ? nGames * (indexPage - 1) : 0,
              (nGames * indexPage) < gamesAll.length
                  ? (nGames * indexPage)
                  : gamesAll.length);

          setState(() {
            getRows();
          });
        },
        next: () {
          if ((nGames * indexPage) < gamesAll.length) indexPage++;
          games = gamesAll.sublist(
              nGames * (indexPage - 1),
              (nGames * indexPage) < gamesAll.length
                  ? (nGames * indexPage)
                  : gamesAll.length);

          setState(() {
            getRows();
          });
        },
      ),
    );
    Scaffold(
        body: Scrollbar(
      isAlwaysShown: true,
      child: ListView(
        children: [
          space(),
          Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return Color.fromARGB(255, 151, 44, 170);
                  },
                ),
                headingRowHeight: 56,
                dataRowHeight: 56,
                columns: const [
                  DataColumn(label: Text('#')),
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Descrição')),
                  DataColumn(label: Text('edit')),
                  DataColumn(label: Text('Adicionar Experimento')),
                ],
                rows: rows),
          ),
          space(),
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                onTap: () {
                  print("object");
                  if (indexPage > 1) indexPage--;
                  games = gamesAll.sublist(
                      (nGames * (indexPage - 1) > 0)
                          ? nGames * (indexPage - 1)
                          : 0,
                      (nGames * indexPage) < gamesAll.length
                          ? (nGames * indexPage)
                          : gamesAll.length);

                  setState(() {
                    getRows();
                  });
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.purple, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  print("object");
                  if ((nGames * indexPage) < gamesAll.length) indexPage++;
                  games = gamesAll.sublist(
                      nGames * (indexPage - 1),
                      (nGames * indexPage) < gamesAll.length
                          ? (nGames * indexPage)
                          : gamesAll.length);

                  setState(() {
                    getRows();
                  });
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.purple, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
              ),
            ]),
          )
        ],
      ),
    ));
  }
}
