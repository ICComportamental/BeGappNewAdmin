import 'package:begappmyadmin/DatatableElements/pagedTable.dart';
import 'package:begappmyadmin/app_localizations.dart';
import 'package:begappmyadmin/classes/dialogs.dart';
import 'package:begappmyadmin/classes/excel.dart';
import 'package:begappmyadmin/classes/experiment.dart';
import 'package:begappmyadmin/classes/game.dart';
import 'package:begappmyadmin/classes/participant.dart';
import 'package:begappmyadmin/pages/gameResult.page.dart';
import 'package:flutter/material.dart';

class ParticipantsTable extends StatefulWidget {
  List<Participant> participants;

  ParticipantsTable(
    this.participants,
  );

  @override
  State<ParticipantsTable> createState() => _ParticipantsTableState();
}

class _ParticipantsTableState extends State<ParticipantsTable> {
  List<Participant> participantsAll = [];
  List<Participant> participants = [];
  int nParticipants = 5;
  int indexPage = 1;
  @override
  void initState() {
    participantsAll = widget.participants;
    participants = participantsAll.sublist(
        0,
        nParticipants < participantsAll.length
            ? nParticipants
            : participantsAll.length);
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
    columns.add(const DataColumn(label: Text('#')));
    columns.add(const DataColumn(label: Text("Nome")));
    columns.add(const DataColumn(label: Text("Email")));
    columns.add(const DataColumn(label: Text("Idade")));
    columns.add(const DataColumn(label: Text("Genêro")));

    columns.add(const DataColumn(label: Text('Listar Resultados')));
    columns.add(const DataColumn(label: Text('Download')));
  }

  getRows() {
    debugPrint("Games: ${participants.length}");
    debugPrint("Gamesall: ${participantsAll.length}");
    rows = [];
    for (var i = 0; i < participants.length; i++) {
      List<DataCell> cells = [];
      cells.add(DataCell(
          Text((participantsAll.indexOf(participants[i]) + 1).toString())));
      // participants[i].parameters.entries.forEach((element) {
      //   cells.add(DataCell(Text(element.value)));
      // });

      cells.add(DataCell(Text(participants[i].name!)));
      cells.add(DataCell(Text(participants[i].email!)));
      cells.add(DataCell(Text(participants[i].age!)));
      cells.add(DataCell(Text(participants[i].gender!)));

      cells.add(
        DataCell(
          InkWell(
            child: Icon(Icons.list),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GameResultPage(participantId: participants[i].id)),
              );
            },
          ),
        ),
      );
      cells.add(
        DataCell(
          InkWell(
            child: Icon(Icons.download),
            onTap: () async {
              var excel = Excelfile();
              excel.createSheet(participants);
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
      body: PagedTable(
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
          participants = participantsAll.sublist(
              (nParticipants * (indexPage - 1) > 0)
                  ? nParticipants * (indexPage - 1)
                  : 0,
              (nParticipants * indexPage) < participantsAll.length
                  ? (nParticipants * indexPage)
                  : participantsAll.length);

          setState(() {
            getRows();
          });
        },
        next: () {
          if ((nParticipants * indexPage) < participantsAll.length) indexPage++;
          participants = participantsAll.sublist(
              nParticipants * (indexPage - 1),
              (nParticipants * indexPage) < participantsAll.length
                  ? (nParticipants * indexPage)
                  : participantsAll.length);

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
                  participants = participantsAll.sublist(
                      (nParticipants * (indexPage - 1) > 0)
                          ? nParticipants * (indexPage - 1)
                          : 0,
                      (nParticipants * indexPage) < participantsAll.length
                          ? (nParticipants * indexPage)
                          : participantsAll.length);

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
                  if ((nParticipants * indexPage) < participantsAll.length)
                    indexPage++;
                  participants = participantsAll.sublist(
                      nParticipants * (indexPage - 1),
                      (nParticipants * indexPage) < participantsAll.length
                          ? (nParticipants * indexPage)
                          : participantsAll.length);

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
