// ignore_for_file: unnecessary_null_comparison, await_only_futures, unused_local_variable

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:archive/archive_io.dart';
import 'package:begappmyadmin/classes/database.dart';
import 'package:begappmyadmin/classes/roundResults.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'participant.dart';

class Excelfile {
  var excel = Excel.createExcel();
  late String name;
  Excelfile();

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

//excel com as info dos particpantes dos bens publicos
  createSheet(
    List<Participant> participants,
  ) async {
    excel.rename('Sheet1', "Participantes");
    Sheet sheetObject = excel["Participantes"];

    List<String> dataList = [
      "id",
      "Nome",
      "Email",
      "Idade",
      "Gênero",
    ];

    sheetObject.insertRowIterables(dataList, 0);

    participants.forEach((element) {
      List<dynamic> rowList = [];

      rowList.add(element.id);
      rowList.add(element.name);
      rowList.add(element.email);
      rowList.add(element.age);
      rowList.add(element.gender);

      sheetObject.insertRowIterables(
          rowList, participants.indexOf(element) + 1);
    });
    excel.setDefaultSheet("Participantes");
    name = participants.first.experimentId;
    var jsonList = await Database.getRoundsResult(participants.first.id);
    List<RoundResults> rounds = [];
    for (int index = 0; index < jsonList.length; index++) {
      rounds.add(RoundResults.fromJson(jsonList[index]));
    }
    roundsSheetPg(rounds);

    // List<Excelfile> files = [];
    // files.add(this);
    // downloadZip(files, "zipName");
  }

// //cria a tabela com as info das rodadas dos bens publicos
//   createSheetPgData(
//     List<RoundData> roundsData, {
//     List<PgParticipant>? participantsTutorial,
//     List<Participant>? participantsInfo,
//   }) async {
//     await getRoundsResult(roundsData);

//     PgParticipant p;
//     if (participantsTutorial == null) {
//       List list =
//           await Database.getPgParticipantDataTime(roundsData.first.userId);

//       //print(list);
//       p = PgParticipant.fromJson(list[0]);
//       await addTutorialSheetPublicGoods(p);
//     } else {
//       participantsTutorial.forEach((element) {
//         if (element.userId == roundsData.first.userId) p = element;
//       });
//     }

  //   Participant participant;
  //   if (participantsInfo == null) {
  //     List list = await Database.getParticipant(roundsData.first.userId);
  //     //print(list);
  //     participant = Participant.fromJson(list[0]);
  //     await addParticipantData(participant);
  //   } else {
  //     participantsInfo.forEach((element) {
  //       if (element.id == roundsData.first.userId) participant = element;
  //     });
  //   }
  // }

  roundsSheetPg(List<RoundResults> roundsData) {
    excel.rename('Sheet1', roundsData.first.participantId.toString());
    Sheet sheetObject = excel[roundsData.first.participantId.toString()];
    name = roundsData.first.participantId.toString();

    List<String> dataList = ["id"];

    roundsData.first.result.entries.forEach((re) {
      dataList.add(re.key);
    });

    sheetObject.insertRowIterables(dataList, 0);

    roundsData.forEach((round) {
      List<dynamic> rowList = [];
      round.result.entries.forEach((re) {
        rowList.add(re.value);
      });
      sheetObject.insertRowIterables(rowList, roundsData.indexOf(round) + 1);
    });

    // roundsData.forEach((r) {
    //   List<dynamic> rowList = [];
    // double d = (r.earning / r.rib) * 100;
    // if (r.earning < 0) d = 0.0;
    // var f = new NumberFormat("###.0#", "en_US");
    // String perDist = f.format(d);
    // if (d != 0)
    //   perDist = perDist.split('.')[0] + "," + perDist.split('.')[1];
    // else
    //   perDist = "0";
    //   rowList.add(r.userId);
    //   rowList.add(r.round);
    //   rowList.add(r.investment);
    //   rowList.add(r.positionToken);
    //   rowList.add(r.earning);
    //   rowList.add(r.rib);
    //   rowList.add(r.distribution == 1 ? perDist : "");
    //   rowList.add(r.wallet);
    //   rowList.add(r.distribution);
    //   rowList.add(r.suspended);
    //   rowList.add(r.electionCount);
    //   rowList.add(r.votes);
    //   rowList.add(format(r.dragToken));
    //   rowList.add(format(r.distributionTime));
    //   rowList.add(format(r.electionTime));

    //   sheetObject.insertRowIterables(rowList, roundsData.indexOf(r) + 1);

    //   var cell = sheetObject.cell(CellIndex.indexByString(
    //       "I" + (roundsData.indexOf(r) + 2).toString()));
    //   CellStyle cellStyle = r.distribution == 1
    //       ? CellStyle(
    //           backgroundColorHex: "#1AFF1A",
    //           fontFamily: getFontFamily(FontFamily.Calibri))
    //       : CellStyle();
    //   // excel.updateCell(sheetObject.sheetName, CellIndex.indexByColumnRow(columnIndex: cell.colIndex,rowIndex: cell.rowIndex), cell.value, cellStyle: cellStyle);
    //   excel.updateCell(
    //       sheetObject.sheetName,
    //       CellIndex.indexByColumnRow(
    //           columnIndex: cell.colIndex, rowIndex: cell.rowIndex),
    //       "",
    //       cellStyle: cellStyle);

    //   cell = sheetObject.cell(CellIndex.indexByString(
    //       "J" + (roundsData.indexOf(r) + 2).toString()));
    //   cellStyle = r.suspended == 1
    //       ? CellStyle(
    //           backgroundColorHex: "#FF0000",
    //           fontFamily: getFontFamily(FontFamily.Calibri))
    //       : CellStyle();
    //   excel.updateCell(
    //       sheetObject.sheetName,
    //       CellIndex.indexByColumnRow(
    //           columnIndex: cell.colIndex, rowIndex: cell.rowIndex),
    //       "",
    //       cellStyle: cellStyle);
    // });
    excel.setDefaultSheet(sheetObject.sheetName);
    saveExcel();
  }

//   createSheetDilemmaData(List<DilemmaRound> roundsData,
//       {List<DilemmaParticipant>? participantsTutorial,
//       List<Participant>? participantsInfo}) async {
//     await roundsSheetDilemma(roundsData);

//     DilemmaParticipant? p;
//     if (participantsTutorial == null) {
//       List list =
//           await Database.getDilemmaParticipantDataTime(roundsData.first.userId);
//       //print(list);
//       p = DilemmaParticipant.fromJson(list[0]);
//     } else {
//       participantsTutorial.forEach((element) {
//         if (element.userId == roundsData.first.userId) p = element;
//       });
//     }
//     if (p != null) await addDilemmaTutorialSheet(p!);

//     Participant? participant;
//     if (participantsInfo == null) {
//       List list = await Database.getParticipant(roundsData.first.userId);
//       //print(list);
//       participant = Participant.fromJson(list[0]);
//     } else {
//       participantsInfo.forEach((element) {
//         if (element.id == roundsData.first.userId) participant = element;
//       });
//     }
//     if (participant != null) await addParticipantData(participant!);
//     name = roundsData.first.userId.toString();
//     //saveExcel();
//   }

// //cria a tabela com as info das rodadas do Dilema
//   roundsSheetDilemma(List<DilemmaRound> roundsData) {
//     excel.rename('Sheet1', roundsData.first.userId.toString());
//     Sheet sheetObject = excel[roundsData.first.userId.toString()];

//     List<String> dataList = [
//       "id",
//       "Rodada",
//       "Computador",
//       "Escolha",
//       "Pontos do Outro",
//       "Seus Pontos",
//       "Perdeu a vez",
//       "Viu pontos do outro",
//       "Viu seus Pontos",
//       "Arrasta a carta"
//     ];

//     sheetObject.insertRowIterables(dataList, 0);

//     roundsData.forEach((r) {
//       List<dynamic> rowList = [];

//       // var f = new NumberFormat("###.0#", "en_US");
//       rowList.add(r.userId);
//       rowList.add(r.round);
//       rowList.add(r.computer);
//       rowList.add(r.userChoice);
//       rowList.add(r.otherPoints);
//       rowList.add(r.userPoints);
//       rowList.add(r.lostRound);
//       rowList.add(r.sawOtherPoints);
//       rowList.add(r.sawYourPoints);
//       rowList.add(format(r.dragCard));

//       sheetObject.insertRowIterables(rowList, roundsData.indexOf(r) + 1);

//       var cell;
//       CellStyle cellStyle;

//       cell = sheetObject.cell(CellIndex.indexByString(
//           "G" + (roundsData.indexOf(r) + 2).toString()));
//       cellStyle = r.lostRound == 1
//           ? CellStyle(
//               backgroundColorHex: "#FF0000",
//               fontFamily: getFontFamily(FontFamily.Calibri))
//           : CellStyle();
//       excel.updateCell(
//           sheetObject.sheetName,
//           CellIndex.indexByColumnRow(
//               columnIndex: cell.colIndex, rowIndex: cell.rowIndex),
//           "",
//           cellStyle: cellStyle);
//     });
//     excel.setDefaultSheet(sheetObject.sheetName);
//   }

  // addTutorialSheetPublicGoods(PgParticipant p) async {
  //   Sheet sheetObject = excel["Tempo"];

  //   List<String> dataList = [
  //     "Experimento",
  //     "Total",
  //     "Principal",
  //     "Distribuição",
  //     "Eleição",
  //     "Principal",
  //     "Distribuição",
  //     "Eleição",
  //   ];

  //   sheetObject.insertRowIterables(dataList, 0);

  //   if (p == null) return; //participante desistiu

  //   List<dynamic> rowList = [];

  //   rowList.add(p.experiment);
  //   rowList.add(format(p.total));
  //   rowList.add(format(p.tutorialMain));
  //   rowList.add(format(p.tutorialDistribution));
  //   rowList.add(format(p.tutorialElection));
  //   rowList.add(p.sawMainTutorial);
  //   rowList.add(p.sawDistributionTutorial);
  //   rowList.add(p.sawElectionTutorial);

  //   sheetObject.insertRowIterables(rowList, 1);
  // }

  // addDilemmaTutorialSheet(DilemmaParticipant p) async {
  //   Sheet sheetObject = excel["Tempo"];

  //   List<String> dataList = [
  //     "Experimento",
  //     "Tempo total",
  //     "Tempo tutorial",
  //     "Viu o tutorial",
  //   ];

  //   sheetObject.insertRowIterables(dataList, 0);

  //   if (p == null) return;

  //   List<dynamic> rowList = [];

  //   rowList.add(p.experiment);
  //   rowList.add(format(p.total));
  //   rowList.add(format(p.tutorial));
  //   rowList.add(p.sawTutorial);

  //   sheetObject.insertRowIterables(rowList, 1);
  // }

  // addParticipantData(Participant participant) async {
  //   Sheet sheetObject = excel["Participante"];

  //   List<String> dataList = [
  //     "id",
  //     "Idade",
  //     "Gênero",
  //     "Profissão",
  //     "Escolaridade",
  //     "Curso",
  //   ];

  //   sheetObject.insertRowIterables(dataList, 0);

  //   if (participant == null) return;

  //   List<dynamic> rowList = [];

  //   rowList.add(participant.id);
  //   rowList.add(participant.age);
  //   rowList.add(participant.gender);
  //   rowList.add(participant.occupation);
  //   rowList.add(participant.educationLevel);
  //   rowList.add(participant.cours);

  //   sheetObject.insertRowIterables(rowList, 1);
  // }

  saveExcel() async {
    // await downloadZip(name);

    final rawData = await excel.encode();

    final content = base64Encode(rawData!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$content")
      ..setAttribute("download", "$name.xlsx")
      ..click();
  }

  // getPdParticipantsFiles(String key) async {
  //   List<Excelfile> files = [];
  //   //pega as rodadas dos participantes do experimento
  //   List list = await Database.getDilemmaParticipantsData(key);
  //   // await Future.delayed(Duration(seconds: 2));
  //   List<DilemmaRound> roundsData = [];
  //   //print(list);
  //   if (list.isEmpty) return files; //exprimento sem participantes
  //   for (int i = 0; i < list.length; i++) {
  //     roundsData.add(DilemmaRound.fromJson(list[i]));
  //   }
  //   // pega os participantes com info de escolaridade,profissao, idade...
  //   List paticipantsList = await Database.getParticipants(key);
  //   List<Participant> participants = [];
  //   for (int i = 0; i < paticipantsList.length; i++) {
  //     participants.add(Participant.fromJson(paticipantsList[i]));
  //   }

  //   //pega as informações dos tempos
  //   list = await Database.getDilemmaParticipants(key);
  //   List<DilemmaParticipant> participantsTutorial = [];

  //   for (int i = 0; i < list.length; i++) {
  //     participantsTutorial.add(DilemmaParticipant.fromJson(list[i]));
  //   }

  //   int userId = roundsData.first.userId;
  //   int index = 0;
  //   for (var i = 0; i < roundsData.length; i++) {
  //     if (userId != roundsData[i].userId || roundsData[i] == roundsData.last) {
  //       //print("INDEX: $index - I: $i");
  //       List<DilemmaRound> rounds = roundsData.sublist(index, i);
  //       Excelfile file = new Excelfile();
  //       await file.createSheetDilemmaData(rounds,
  //           participantsTutorial: participantsTutorial,
  //           participantsInfo: participants);
  //       //print("NOME: ${file.name}");
  //       files.add(file);
  //       index = i;
  //       userId = roundsData[i].userId;
  //     }
  //   }
  //   return files;
  // }

  static downloadZip(List<Excelfile> files, String zipName) async {
    //objeto do futuro zip
    Archive zipArchive = new Archive();

    files.forEach((e) async {
      final rawData = e.excel.encode();

      final content = rawData;

      ArchiveFile excelFile =
          new ArchiveFile("${e.name}.xlsx", content!.length, content);
      //adiciona o arquivo excel ao zip
      zipArchive.addFile(excelFile);
    });

    List<int> zipInBytes = new ZipEncoder().encode(zipArchive)!;
    final base64 = base64Encode(zipInBytes);

    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$base64")
      ..setAttribute("download", "$zipName.zip")
      ..click();
  }

  downloadZipok(String name) async {
    final rawData = await excel.encode();

    final content = rawData;

    ArchiveFile excelFile =
        new ArchiveFile("$name.xlsx", content!.length, content);

    Archive zipArchive = new Archive();
    zipArchive.addFile(excelFile);
    zipArchive.addFile(excelFile);
    List<int> zipInBytes = new ZipEncoder().encode(zipArchive)!;
    final base64 = base64Encode(zipInBytes);

    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-8;base64,$base64")
      ..setAttribute("download", "$name.zip")
      ..click();
  }
}
