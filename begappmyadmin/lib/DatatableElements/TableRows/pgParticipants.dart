// import 'package:begapp_web/DatatableElements/TableRows/datatableRows.dart';
// import 'package:begapp_web/classes/database.dart';
// import 'package:begapp_web/classes/excel.dart';
// import 'package:begapp_web/public_goods/classes/pgparticipant.dart';
// import 'package:begapp_web/public_goods/classes/roundData.dart';
// import 'package:begapp_web/public_goods/modals/gameData.dart';
// import 'package:flutter/material.dart';

// List<DataCell> getPGParticipant(
//     PgParticipant participant, index, contextDialog, setstate) {
//   List<DataCell> row = [];
//   List<String> datas = [
//     (index).toString(),
//     participant.age.toString(),
//     participant.gender,
//     participant.occupation,
//     participant.cours,
//   ];
//   datas.forEach((e) => row.add(DatatableRows.getCell(e)));

//   row.add(DatatableRows.getSeeCell(
//       condition: true,
//       seeData: () async {
//         List list = await Database.getPgParticipantData(participant.userId);
//         List<RoundData> roundsData = [];
//         // print(list);
//         for (int i = 0; i < list.length; i++) {
//           roundsData.add(RoundData.fromJson(list[i]));
//         }
//         Dialog dialog = Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: GameData(
//               participant: participant,
//               rounds: roundsData,
//             ));
//         await showDialog(
//             context: contextDialog, builder: (BuildContext context) => dialog);
//       }));
//   row.add(DatatableRows.getDownloadCell(() async {
//     Excelfile _excelfile = new Excelfile();

//     List list = await Database.getPgParticipantData(participant.userId);
//     List<RoundData> roundsData = [];
//     // print(list);
//     for (int i = 0; i < list.length; i++) {
//       roundsData.add(RoundData.fromJson(list[i]));
//     }
//     await _excelfile.createSheetPgData(roundsData);
//     _excelfile.saveExcel();
//   }));
//   return row;
// }
