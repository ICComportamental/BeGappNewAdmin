// import 'package:flutter/material.dart';

// List<DataCell> getDilemmaParticipant(
//     DilemmaParticipant participant, index, contextDialog, setstate) {
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
//         List list =
//             await Database.getDilemmaParticipantData(participant.userId);
//         // print("HEREEEEEEEEEEEEEE ${participant.userId}\n" + list.toString());
//         List<DilemmaRound> roundsData = [];
//         for (int i = 0; i < list.length; i++) {
//           roundsData.add(DilemmaRound.fromJson(list[i]));
//         }
//         list = await Database.getDilemmaExperiment(participant.experiment);
//         DilemmaVariables dilemmaVariables = DilemmaVariables.fromJson(list[0]);
//         Dialog dialog = Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: GameDataDilemma(
//               participant: participant,
//               rounds: roundsData,
//               maxRounds: dilemmaVariables.roundsNumber,
//             ));
//         await showDialog(
//             context: contextDialog, builder: (BuildContext context) => dialog);
//       }));
//   row.add(DatatableRows.getDownloadCell(() async {
//     Excelfile _excelfile = new Excelfile();

//     List list = await Database.getDilemmaParticipantData(participant.userId);
//     List<DilemmaRound> roundsData = [];
//     // print(list);
//     for (int i = 0; i < list.length; i++) {
//       roundsData.add(DilemmaRound.fromJson(list[i]));
//     }
//     await _excelfile.createSheetDilemmaData(roundsData);
//     _excelfile.saveExcel();
//   }));
//   return row;
// }
