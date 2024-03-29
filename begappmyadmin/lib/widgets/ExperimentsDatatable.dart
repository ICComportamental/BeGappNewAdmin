import 'dart:convert';

import 'package:begappmyadmin/DatatableElements/pagedTable.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/pages/participants.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../DatatableElements/classes/search.dart';
import '../classes/database.dart';

class ExperimentsTable extends StatefulWidget {
  List<Experiment> experiments;
  Game game;
  ExperimentsTable(this.experiments, this.game);

  @override
  State<ExperimentsTable> createState() => _ExperimentsTableState();
}

class _ExperimentsTableState extends State<ExperimentsTable> {
  List<Experiment> experimentsAll = [];
  List<Experiment> experiments = [];
  int nExperiments = 2;
  int indexPage = 1;
  @override
  void initState() {
    experimentsAll = widget.experiments;
    experiments = experimentsAll.sublist(
        0,
        nExperiments < experimentsAll.length
            ? nExperiments
            : experimentsAll.length);
    getColumns();
    getRows();
    super.initState();
  }

  function() {
    setState(() {});
  }

  TextEditingController txtSearch = TextEditingController();

  int searchFlex = 1;
  int tableFlex = 4;
  int btnFlex = 1;
  List<DataRow> rows = [];
  List<DataColumn> columns = [];

  getColumns() {
    columns.add(const DataColumn(label: Text('Código')));
    experiments.first.parameters.entries.forEach((element) {
      columns.add(DataColumn(label: Text(element.key)));
    });
    columns.add(const DataColumn(label: Text('Editar Experimento')));
    columns.add(const DataColumn(label: Text('Listar Resultados')));
  }

  getRows() {
    debugPrint("Games: ${experiments.length}");
    debugPrint("Gamesall: ${experimentsAll.length}");
    rows = [];
    for (var i = 0; i < experiments.length; i++) {
      List<DataCell> cells = [];
      cells.add(DataCell(SelectableText(experiments[i].id)));
      // cells.add(DataCell(Text(experiments[i].id)));
      // cells.add(DataCell(
      //     Text((experimentsAll.indexOf(experiments[i]) + 1).toString())));
      experiments[i].parameters.entries.forEach((element) {
        cells.add(DataCell(Text(element.value)));
      });
      cells.add(
        DataCell(
          InkWell(
            child: Icon(Icons.edit),
            onTap: () async {
              await Dialogs.showUpdateExperiment(
                  context, experiments[i], widget.game.parameters);
              setState(() {});
            },
          ),
        ),
      );
      cells.add(
        DataCell(
          InkWell(
            child: Icon(Icons.list),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParticipantsPage(
                            experiment: experiments[i].id,
                          )));
              // await Dialogs.showUpdateExperiment(
              //     context, experiments[i], widget.game.parameters);
              // setState(() {});
            },
          ),
        ),
      );
      rows.add(DataRow(
          color: MaterialStateColor.resolveWith(
            (states) {
              if (i % 2 > 0)
                return Color.fromARGB(255, 209, 209, 209);
              else
                return Colors.white;
            },
          ),
          cells: cells
          // [
          //   DataCell(
          //       Text((experimentsAll.indexOf(experiments[i]) + 1).toString())),
          //   DataCell(Text(experiments[i].name)),
          //   DataCell(Text(experiments[i].description)),
          // DataCell(
          //   InkWell(
          //     child: Icon(Icons.edit),
          //     onTap: () async {
          //       await Dialogs.showUpdateGame(context, experiments[i]);
          //       setState(() {});
          //     },
          //   ),
          // ),
          // DataCell(
          //   Center(
          //     child: InkWell(
          //       child: Icon(Icons.add_circle_outlined),
          //       onTap: () async {
          //         await Dialogs.showCreateExperiment(context, experiments[i]);
          //         // setState(() {});
          //       },
          //     ),
          //   ),
          // ),
          // DataCell(
          //   Center(
          //     child: InkWell(
          //       child: Icon(Icons.list),
          //       onTap: () async {
          //         // await Dialogs.showCreateExperiment(context, games[i]);
          //         // setState(() {});
          //       },
          //     ),
          //   ),
          // ),
          // ]
          ));
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
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: PagedTable(
        search: Search(
          [
            AppLocalizations.of(context).translate('code'),
            // AppLocalizations.of(context).translate('description'),
          ],
          [
            "id",
          ],
          (String filter, String value) async {
            if (value != "") {
              try {
                // List snap = await Database.getExperiments(
                //     widget.experiments.first.gameId,
                //     filter: filter,
                //     value: value) as List<dynamic>;
                // List<Experiment> experimentsSearch = [];
                // for (int index = 0; index < snap.length; index++) {
                //   experimentsSearch.add(Experiment.fromJson(snap[index]));
                // }
                var snap = await Database.getExperiment(value);

                List<Experiment> experimentsSearch = [];

                experimentsSearch.add(Experiment.fromJson(jsonDecode(snap)));

                experimentsAll = experimentsSearch;
              } catch (e) {
                experimentsAll = widget.experiments;
              }
            } else {
              experimentsAll = widget.experiments;
            }

            setState(() {
              experiments = experimentsAll.sublist(
                  0,
                  nExperiments < experimentsAll.length
                      ? nExperiments
                      : experimentsAll.length);
              getRows();

              print("FILTER$filter VALUE:$value");
            });
          },
        ),
        table: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
              (states) {
                return Color.fromARGB(255, 151, 44, 170);
              },
            ),
            headingRowHeight: 56,
            dataRowHeight: 56,
            columns: columns,
            //const [
            //   DataColumn(label: Text('#')),
            //   DataColumn(label: Text('rounds')),
            //   DataColumn(label: Text('algorithm')),
            //   // DataColumn(label: Text('edit')),
            //   // DataColumn(label: Text('Adicionar Experimento')),
            //   // DataColumn(label: Text('Listar Experimentos')),
            // ],
            rows: rows),
        previous: () {
          if (indexPage > 1) indexPage--;
          experiments = experimentsAll.sublist(
              (nExperiments * (indexPage - 1) > 0)
                  ? nExperiments * (indexPage - 1)
                  : 0,
              (nExperiments * indexPage) < experimentsAll.length
                  ? (nExperiments * indexPage)
                  : experimentsAll.length);

          setState(() {
            getRows();
          });
        },
        next: () {
          if ((nExperiments * indexPage) < experimentsAll.length) indexPage++;
          experiments = experimentsAll.sublist(
              nExperiments * (indexPage - 1),
              (nExperiments * indexPage) < experimentsAll.length
                  ? (nExperiments * indexPage)
                  : experimentsAll.length);

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
                  debugPrint("object");
                  if (indexPage > 1) indexPage--;
                  experiments = experimentsAll.sublist(
                      (nExperiments * (indexPage - 1) > 0)
                          ? nExperiments * (indexPage - 1)
                          : 0,
                      (nExperiments * indexPage) < experimentsAll.length
                          ? (nExperiments * indexPage)
                          : experimentsAll.length);

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
                  debugPrint("object");
                  if ((nExperiments * indexPage) < experimentsAll.length)
                    indexPage++;
                  experiments = experimentsAll.sublist(
                      nExperiments * (indexPage - 1),
                      (nExperiments * indexPage) < experimentsAll.length
                          ? (nExperiments * indexPage)
                          : experimentsAll.length);

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
